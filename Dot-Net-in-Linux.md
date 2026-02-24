# Working with .Net in Linux

## Install .Net Core

Install .Net.

```bash
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb

sudo dpkg -i packages-microsoft-prod.deb

sudo apt update
```

Now install the SDK:

```bash
    sudo apt-get install -y dotnet-sdk-10.0
```

## Add paths to .bashrc

```bash
export DOTNET_ROOT=$HOME/.dotnet

export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
```

Run this command:

```bash
    dotnet tool install -g dotnet-scripts	
```

This will install the .Net core runtime and the SDK.

## Creating a Console program

These are the instructions to create a simple .Net core Console application.

First create a folder, e.g. ``dotnetapp``. CD into this folder.

```bash
    dotnet new console
```

This will create a console application named ``dotnetapp``.

### Compile the application

```bash
    dotnet build .
```

### Running the application

From this folder.

```bash
    dotnet run
```

**Note:** using ``dotnet run`` will compile and run the application at the same time so you don't really need to ``dotnet build .``.

### Publishing the application

It is okay to run the application from the root folder with ``dotnet run`` but if you want to create an application that can run from a **$PATH** folder you will need to publish the application.

```bash
    dotnet publish -r linux-x64
```

This will create a Linux version of your application. You can find the application in the folder.

> home\alanr\Source\dotnetapp\bin\Release\net9.0\linux-x64\publish

**Note:** this also works in **WSL**. I can also use this command in Powershell wth a Windows project and move the published file to a Linux machine and it will work as long as it has the .Net Core runtime.

To be able to run this command you need three files from the publish folder.

> dotnetapp     
> dotnetapp.dll     
> dotnetapp.runtimeconfig.json

**Note:** the ``dotnet`` commands that I am running have a number of other options that I need to learn. Check the Microsoft documentation.

In the publish process the binary should have execute permissions. If not you need to do this.

```bash
    sudo chmod +x /usr/local/bin/dotnetapp
```

## Running the application from $PATH

I got into a lot of grief trying to get this binary to run from somewhere in the **$PATH** directories. Originally I named my project ``test``. This was a problem because when I added the binary to a folder in my **$PATH** it wouldn't run. After a lot of investigation I found that ``test`` caused a name collision. ChatGPT was able to tell me.

The name ``test`` is already a built-in command in most shells. You can verify this by running:

```bash
    type test
```

If the Output Shows:

> test is a shell builtin: Your command is being overridden by the shell's built-in test command.     
> /usr/bin/test or similar: Your command is being overridden by a system binary.

It turned out that ``test`` is a built-in test command. Once I renamed my project it worked perfectly.

Although this problem took me a while to solve I used ChatGPT to fix it and learnt a lot of things about Linux in the process.

## Copying files to #PATH

The ``$PATH`` command is Linux's path specification. To check this.

```bash
    echo $PATH
```

Will show you the directories that are searchable.

You can move your binaries to ``/usr/local/bin`` or ``/opt`` and they will run on your Linux system from anywhere.

There is an issue with these two directories in that they seem to be system directories and you need to use ``sudo`` to run the copy commands.

```bash
    sudo cp -r bin/Release/net8.0/linux-x64/publish /usr/local/bin
```

This will copy the whole publish directory to ``bin``. There is a big problem with this because when I run this command it changes ownership to **root**. To run this command I have to use ``sudo``.

```bash
    sudo dotnetapp
```

To get around this I need to change ownership.

```bash
    sudo chown -v -R alanr:alanr /usr/local/bin/dotnetapp.*
    sudo chown -v -R alanr:alanr /usr/local/bin/dotnetapp
```

Once again make sure the binary is executable.

```bash
    chmod -R u+rx,g+rx /usr/local/bin/dotnetapp
```

This is a lot of effort to make sure you can access ``dotnetapp`` from anywhere.

## Create a user-writable directory

If ``/usr/local/bin`` causes persistent permission issues, consider moving your app to a user-writable directory, such as ``$HOME/.local/bin``.

Create the directory if it doesn't exist:

```bash
    mkdir -p $HOME/.local/bin
```

where ``$HOME`` is ``/home/alanr``.

**Note:** in my case this directory existed and was being used by Docker.

Copy ``dotnetapp`` and associated files to this directory. As you own this directory you won't have permissions issues.

The next step is to add the ``$HOME/.local/bin`` directory to your ``$PATH`` variable.

```bash
    echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
```

Or use Nano to add this text to the bottom of your ``.bashrc`` file.

**Note:** there is a minor issue with doing this if other users are using this Linux machine. It makes the files accessible only to you.

You can now access this file from anywhere with.

```bash
    dotnetapp
```

### Checking your path

```bash
    echo $PATH
```

Returns.

> /home/alan/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

Each directory in the list is searched in order until the system finds the executable you’re trying to run. If your application's directory isn't in the PATH, you'll need to add it.

### Check the File Type

This is what I did to check the ``test`` binary file that I originally created.

Use the file command to confirm what type of file dotnetapp is:

```bash
    file $HOME/.local/bin/test
```

Output Examples:

> If it's a shell script: Bourne-Again shell script, ASCII text executable.     
> If it's a .NET app: ELF 64-bit LSB executable or something similar.

In this case it was a ELF binary executable file and runnable.

### Run the Program with Debugging

Try running the program directly to check for errors:

```bash
    $HOME/.local/bin/test
```

If the program doesn't run, it might be because:

>  The file is not a native Linux executable.       
> It requires the .NET runtime.

### Check for Dependencies

If the app is not self-contained (i.e., published without --self-contained), it will depend on the .NET runtime being installed. 

Verify the runtime is available:

```bash
    dotnet --info
```

In my case .Net Core runtime was available.

### Check Executability

Ensure the test file is executable and in the correct location:

```bash
    ls -l $HOME/.local/bin/test
```

### Name Collision Warning

Ensure there isn't another command or system program named test. To check, run:

```bash
    which test
```

If it points to something other than ``$HOME/.local/bin/test``, you’re likely hitting a system utility or alias.

This is where I realised that I had an issue with the binary file, ``test``.

### Name Collision with System Command

The name test is already a built-in command in most shells. You can verify this by running:

```bash
    type test
```

If the Output Shows:

> test is a shell builtin: Your command is being overridden by the shell's built-in test command.       
> /usr/bin/test or similar: Your command is being overridden by a system binary.

``test`` is a shell builtin and this is why my executable wasn't running.

## Running .Net Core 10 as a script

Create a ``.cs`` file named ``app.cs``.

```bash
#!/usr/bin/env dotnet-script

using System;
using System.IO;

Console.WriteLine("Hello World!");
```

Change the permissions:

```bash
    chmod 744 ./app.cs
```

This makes it executable.

Run from the current directory:

> ./app.cs

**Note:** you don't have to use the ``.cs`` extension.

If you don't want to change the file permissions you can run the ``app.cs`` file with:

 ```bash
    dotnet script ./app.cs
 ```

For more information see:

> [https://github.com/dotnet-script/dotnet-script](https://github.com/dotnet-script/dotnet-script).

Another way to run app.cs as a script is:

```bash
    dotnet run /.app.cs
```

**Note:** this will also run on Windows.
