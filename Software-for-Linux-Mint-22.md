# Linux Mint 22 setup

## Setup your Firewall

assets/firewall-settings.png

Change **status** to ON.

## Driver Manager

You need to occasionally check the Driver Manager dialog to see if there are any drivers that can be changed from installed to recommended drivers.

## Install Preload

You can speed up the startup times  of your apps by installing ``preload``.

```bash
    sudo apt install preload
```

Preload will load applications like Firefox quicker.

## File Manager changes

In File Manager click on the ``Edit`` tab and select Behavior.

In the section, **Executable Text Files** select *View executable text files when they are opened*.

This stops the display dialog from appearing when you click on an executable text file from Windows.

## Install .bashrc and .bash_aliases

I have a directory named ``linux-scripts``. Navigate to this directory and run these commands.

Copy these files to the home directory.

```bash
    cp ./colours.sh /home/alanr
```

And.

```bash
    cp ./gc.sh /home/alanr
```

And.

```bash
    cp .bash_aliases /home/alanr
```

With my ``.bashrc`` file I need to add these lines to the bottom of the file.

```bash
# Colour  man page output
export PAGER=most

# Vertical format for docker ps
export FORMAT="ID\t{{.ID}}\nNAME\t{{.Names}}\nIMAGE\t{{.Image}}\nPORTS\t{{.Ports}}\nCOMMAND\t{{.Command}}\nCREA
TED\t{{.CreatedAt}}\nSTATUS\t{{.Status}}\n"

# Run my shell scripts
# if [ -f ~/.config/shell_funcs.sh ]; then
   . ~/.config/shell_funcs.sh
# fi

# Add to $PATH
export PATH=$HOME/.local/bin:$PATH

export MANPATH=":/usr/shar/man"

eval "$(zoxide init bash)"

# delete these files on wsl ubuntu
find . -type f -name '*:Zone.Identifier*' -delete
find . -type f -name '*:mshield' -delete

# Set up fzf key bindings and fuzzy completion
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
set FZF_DEFAULT_OPTS "--layout=reverse --border=bold --border=rounded --margin=3% --color=dark"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
```

Make sure ``/home/alanr/.local/bin`` exists.

## Install most

```bash
    sudo apt-get install most -y
```

Exit your terminal and restart it. Type this command.

```bash
    man ls
```

This opens the man page for ``ls``. If you installed the ``.bashrc`` and ``most`` correctly you should see colour text for the ``ls`` command. This tells you that your changes are working correctly.

Now type, ``gh man``. You should see a list of ``man`` pages you have opened up. This tells you that ``.bash_aliases`` has been installed correctly.

## Installing Docker

Do an update.

```bash
   sudo apt update -y
```

Then install Docker.

```bash
   sudo apt install docker* -y
```

### Manage Docker as a non-root user

[https://docs.docker.com/engine/install/linux-postinstall/](https://docs.docker.com/engine/install/linux-postinstall/)

Create the docker group.

```bash
    sudo groupadd docker
```

Add your user to the docker group.

```bash
    sudo usermod -aG docker $USER
```

Reboot your system.

To test (you shouldn't have to use root privileges).

```bash
    docker run hello-world
```

If successful you will get this message.

> Hello from Docker!
> This message shows that your installation appears to be working correctly.
> ...

Test that Docker Compose is working.

```bash
    docker compose version
```

## Install Azure Data Studio

[Azure Data Studio link](https://azuredatastudio-update.azurewebsites.net/latest/linux-deb-x64/stable).

From your home folder run this.

```bash
    sudo dpkg -i ./Downloads/azuredatastudio-linux-<version string>.deb
```

My package was.

```bash
    sudo dpkg -i ./Downloads/azuredatastudio-linux-1.49.0.deb
```

This installs Azure Data Studio.

You may have to install the folowing dependancies.

```bash
    sudo apt-get install libunwind8
```

To run.

> azuredatastudio

## Install Visual Studio Code

Install from this link.

```bash
    https://go.microsoft.com/fwlink/?LinkID=760868
```

In Downloads.

```bash
    sudo apt install ./code_1.92.1-1723066302_amd64.deb
```

My Visual Studio Account.

> Microsoft - <alanr@live.com.au>

## Install .Net Core

Add the Microsoft package signing key to your list of trusted keys and add the package repository.

```bash
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

sudo dpkg -i packages-microsoft-prod.deb

rm packages-microsoft-prod.deb
```

Then do an update.

```bash
    sudo apt-get update    
```

Then install .Net.

```bash
    sudo apt-get install -y dotnet-sdk-9.0
```

This will install the .Net core runtime and the SDK.

## Install Brave browser

```bash
sudo apt install curl
```

```bash
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
```

```bash
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
```

```bash
sudo apt update
```

```bash
sudo apt install brave-browser
```

## Install WinRar

```bash
    sudo apt-get install rar unrar
```

**Note:** you need a license so copy the license.rar file and open in the current directory with.

### Extracting files

```bash
    unrar x license.rar
```

To extract to another directory.

```bash
    unrar e license.rar /home/alanr/Downloads
```

Listing all files in a rar file.

```bash
    rar l myfiles.rar
```

### Testing rar files

```bash
    unrar t myfiles.rar
```

### Copy files to a rar file

```bash
    rar a mytextfiles.rar *.txt
```

To update or add files to the existing archive file, use the ``rar u`` command, which allows you to add files to an existing RAR archive or update files within the archive.

```bash
    rar u myfiles.rar hello.py
```

## Installing Nord VPN

Install with this command.

```bash
    sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
```

Add user to nordvpn group.

```bash
    sudo usermod -aG nordvpn $USER
```

Login.

Reboot Linux.

When you want to use Nord VPN.

```bash
    nordvpn connect
```

## Replace APT

There are faster installers than APT. Nala is a good option because it is coloured and faster than APT. To install.

```bash
    sudo apt install nala -y
```

## Speed up your installs

Use ``Fetch``. First setup the repository.

```bash
    sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
```

Once this is added to your repository list you can install ``Fetch``.

```bash
    sudo nala fetch
```

This will create a list of the fastest servers for you. From this list ``Fast`` will select the fastest repository servers for you. Select the top 10 from the list with.

> 1,2,3,4,5,6,7,8,9,10

This will show you the list and ask for confirmation.

![Nala mirrors](assets/images/mirrors.jpg "Nala mirrors")

You will find that you install software much faster than with APT.

## Improve RAM usage

When you have used 60% of your RAM your swapspace will be used to store memory. This is slower than RAM.

You can check your settings with.

```bash
    cat /proc/sys/vm/swappiness
```

Returns.

> 60

You can change your threshold to 10 to speed up your machine.

```bash
    sudo nano /etc/sysctl.con
```

Go to the bottom of this file and add this line.

```bash
    vm.swappiness=10
```

## Install Stacer

Stacer is a really impressive system checker.

```bash
    sudo nala stacer -y
```

## Installing utilities

There are a number of Rust utilities that can be used in Linux or Windows. I will install and document these applications.

These are documented at Github - [Modern Unix utilities](https://github.com/ibraheemdev/modern-unix).

### Bat

#### Installation

``Linux``.

```bash
    sudo apt install bat
```

``Windows``.

```bash
    choco install bat
```

``BatCat`` is a replacement for ``Cat`` with an impressive coloured output.

**Note:** we can't use ``bat`` as a shortcut because it conflicts with a system application.

#### Create an alias

To get around the name conflict we create an alias and add it to ``.bash_aliases``.

```bash
    alias bc='batcat'
```

Now to test this out.

```bash
    bc Program.cs
```

Returns.

![BatCat output](assets/images/batcat-output.jpg "BatCat output")

This is BatCat running in DOS.

![DOS BatCat output](assets/images/batcat-output2.jpg "DOS BatCat output")

### Eza

``eza`` is a coloured replacement for ``ls``. It seems to have all of the options that ``ls`` has plus a lot of extras. Once again this works on a Windows PC.

Documentation.

(Eza community Github site)[https://github.com/eza-community/eza].

Standard usage.

```bash
    eza
```

Or.

```bash
    eza -la
```

Returns.

![eza output](assets/images/eza-output.jpg "eza output")

It gets more interesting here.

```bash
    eza -lT
```

![Tree view](assets/images/tree-view.jpg "Tree view")

This command can be used to provide a similar output to my Windows ``search`` command that limits the search to 2 directory levels.

```bash
    eza -TL 2
```

Windows output.

![Eza tree view](assets/images/eza-tree-view.jpg "Eza tree view")

### fd

The ``fd`` command is a file system utility, serving as a modern, faster, and more user-friendly alternative to the traditional ``find`` command in Linux. It offers a simpler syntax and sensible defaults for common use cases.

#### Installation

Linux.

```bash
    sudo apt install fd-find
```

Create an alias to use this command as ``fd`` in ``.bash_aliases``.

```bash
    alias fd='fdfind'
```

#### Usage

fd PATTERN

``fd`` is case insensitive

```bash
    fd program.cs
```

Returns.

> Documents/Program.cs

Search in a specific directory.

```bash
    fd Program.cs Documents/
```

**Note:** you can use -i for case insensitive searches.

Searching for multiple files with the same extension.

```bash
    fd -g *.cs
```

Returns.

> Documents/Program.cs

**Note:** -g is for file globbing and this allows you to do wildcard searches.

Only search in the current directory

```bash
    fd -gd 2 *.cs
```

Returns.

> Documents/Program.cs

Search for files with an extension.

```bash
    fd -e sh
```

Returns.

> colours.sh        
> gc.sh     
> status.sh

To list all files in a specific directory, use the wild card symbol **.** as the search pattern.

```bash
    fd . Documents/
```

Returns.

> Documents/Program.cs      
> Documents/file.txt

There are a huge number options with the ``fd`` command.

## Change the hostname

Change the hostname in this file. My current name is **Lion** and I want to change the case to **lion**.

```bash
    sudo nano /etc/hostname
```

Change all references to the hostname in this file.

```bash
    sudo nano /etc/hosts
```

Now, you need to tell the operating system that the host name has changed and the PC has been renamed.

```bash
    sudo hostname lion
```

I would reboot after this step.

Now my terminal window reflects my new hostname.

> alanr@lion:~$
