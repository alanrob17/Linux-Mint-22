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

## Trim for SSD drives

``Trim`` can improve the efficiency and life of your SSD.

Check the status.

```bash
sudo systemctl status fstrim.timer
```

If it isn't running you can enable it.

```bash
sudo systemctl enable fstrim.timer
```

Start ``trim``.

```bash
sudo systemctl start fstrim.timer
```

Trim can tell the system to wipe blocks of data when they aren't being used. Unlike older drives SSD's need to lean blocks before they can write new data. Without ``trim`` the SSD doesn't know which blocks are free leading to slower write speeds over time as the drive fills up with stale data.

## Install Microsoft fonts

There are a number of applications that rely on Microsoft fonts. You can also use these fonts in Libre Office.

Use this command to Install them. It also installs codecs and other Ubuntu restricted files.

```bash
    sudo apt install ubuntu-restricted-extras
```

### Install Jetbrains mono fonts

```bash
    sudo apt install fonts-jetbrains-mono
```

You can use these in the terminal by changing the system font.

## Improve battery life on Laptops

Battery power settings - install on Samsung Ultra.

```bash
	sudo apt tlp
```

After installation TLP will start automatically and run in the background.

If it doesn't start you can start the daemon with.

```bash
	sudo tlp start
```

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

**Note:** you will have to change this if you are using ``.zsh`` as your shell.

## .local/bin

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

### .bash_aliases

Open up the ``.bash_aliases`` file in the Linux-Mint folder. copy these aliases into the root ``.bash_aliases`` file.

If you are using the ``.zsh`` shell copy the aliases into ``.zsh_aliases`` as well.

## Install shell scripts

Copy the ``shell_funcs.sh`` and ``wipe.sh`` scripts to the ``.config`` folder.

Set the execute permissions.

```bash
    chmod 774 ~/.config/shell_funcs.sh
    chmod 774 ~/.config/wipe.sh
```

## Install Cargo

I will install ``eza`` with Cargo.

Download and run ``rustup`` installer.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Follow the prompts (choose option 1 for default installation)

After installation, load cargo into your current shell:

```bash
    source $HOME/.cargo/env
```

Verify installation.

```bash
    rustc --version
    cargo --version
```

Update cargo if needed.

```bash
    rustup update
```

### Install Eza

``eza`` is a coloured replacement for ``ls``. It seems to have all of the options that ``ls`` has plus a lot of extras. Once again this works on a Windows PC.

Documentation.

(Eza community Github site)[https://github.com/eza-community/eza].

### Installation

```bash
cargo install eza --locked
```

Add to ``PATH`` if not already (it should be automatically).

```bash
which eza
```

## Install xcp

``xcp`` is a modern version of the ``cp`` copy command. It is a lot more user friendly than ``cp``.

Installing ``xcp`` on Linux Mint 22 is done through Cargo, Rust's package manager.

You can install ``xcp`` with.

```bash
	cargo install xcp
```

Installation Directory: The binary is typically installed in ``~/.cargo/bin/``. Make sure this directory is in your shell's PATH (the Rust installer usually sets this up automatically).

## Install Docker

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

> Github - <alanr@live.com.au>

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

## Install Chrome

This method is supposed to allow automatic updates.

**1.** Download the Google signing key

```bash
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
```

**2.** Add the official Google Chrome repository

```bash
sudo add-apt-repository "deb http://dl.google.com/linux/chrome/deb/ stable main"
```

**3.** Update your package list

```bash
sudo apt update
```

**4.** Install Google Chrome Stable

```bash
sudo apt install google-chrome-stable
```

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

**Note:** you need a license so extract the ``rarkey.rar`` file.

```bash
    unrar x rarkey.rar
```

 Move the ``rarreg.key`` to the root folder.

Now run this command.

```bash
    rar
```

This should register your version of ``rar``.

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
    sudo apt install stacer -y
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

#### Bash aliases

Add to ``.bash_aliases``.

```bash
    alias ls=eza
```

#### Usage

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

### zoxide

``zoxide`` is an alternative to the cd command, offering faster performance and smarter navigation capabilities. Like the tools mentioned below, much of the power of ``zoxide`` is in its directory ranking based on your usage. Its ranking algorithm can quickly match partial paths, even single search terms, with one of your most used directories.

#### Installation

```bash
	sudo apt update && sudo apt upgrade -y
```

Install with.

```bash
	sudo apt install zoxide
```

Have your shell initialize ``zoxide`` with each shell session. You can do so by adding the following line to the end of your ``~/.bashrc`` file.

**File: ~/.bashrc**

```bash
	#...
	eval "$(zoxide init bash)"
```

### Install zsh

I have been testing the ``zsh`` shell and have found that I prefer it to ``bash``.

I can change the ``bash`` shell for ``zsh`` with this command.

```bash
    sudo apt install zsh -y
```

The next thing to do is install ``OhMyZsh``.

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

When you install ``OhMyZsh`` it will ask you if you want to make it your default shell. Type ``y`` to allow this.

**Note:** you also have the option to replace the ``.zshrc`` file. If you accept this option it will do the replace and save the original ``.zshrc`` file as ``.zshrc.pre-oh-my-zshrc``. You will need this to add back your changes to the ``.zshrc`` file that you previously had in the original file.

#### .zsh aliases

You could load your aliases in the ``.zshrc`` file but a better idea is to add them to a file named ``.zshrc_aliases``. Now just add all of the aliases from your original ``.bash_aliases`` file.

You will need to add this line into your ``.zshrc`` file.

```bash
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
```

#### Make .zsh the default shell

```bash
    chsh -s /usr/bin/zsh
```

**Note:** you have to log out of Mint to get this to work. I would reboot to make sure.

To find the default shell.

```bash
    echo $SHELL
```

#### Plugins

Zsh allows you to add plugins to it ``.zshrc`` startup file. I have one plugin installed.

```bash
 plugins=(git)
```

This is where you can find a list of [zsh plugins](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins).

### Install fzf

Don't install ``fzf`` with the standard install command. It's important to note that the version provided by the Ubuntu package manager may not be the latest available. For the most up-to-date version with the latest features and bug fixes, it is recommended to install ``fzf`` directly from the GitHub repository using the following commands:

**Note:** Make sure this command is on 2 lines.

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

During the installation process, you will be prompted to enable key bindings, fuzzy completion, and update your shell configuration file; answering ``'y'`` for these options will set up the full functionality of fzf.

After installation, you may need to restart your shell or source your profile (e.g., ``source ~/.bashrc``) for the changes to take effect.

#### Key bindings

Once shell integration is set up, the following key bindings are available in your terminal.

**Ctrl+T**: Fuzzy find all files and subdirectories of the working directory and insert the selected items onto the command line.

**Ctrl+R**: Search through your shell command history using fuzzy matching. Pressing Ctrl+R again toggles sorting by relevance.

**Alt+C**: Fuzzy find all subdirectories and cd (change directory) into the selected one.

#### Installing Fuzzy Finder in the .zsh shell

Run this command to set up the key bindings.

```bash
    ~/.fzf/install
```

This will setup ``fzf`` and key bindings in the ``.zshrc`` setup file.

### Ripgrep

```bash
	sudo apt install ripgrep
```

#### Usage

rg --help

man ripgrep

rg -i Linux

rg -i Linux -g '*.md'

rg Main -C 2 -t cs

ls -R *.md | rg "README.md"

rg text alan.txt

rg -i Linux Documents/

rg -i -d 2 '\bPartition\b' -g *.md

## TLDR

The Linux ``tldr`` (Too Long; Didn't Read) application is a command-line tool providing simplified, community-driven cheat sheets for common Linux/Unix commands, acting as an easy-to-read alternative to lengthy man pages by focusing on practical examples. It helps users quickly understand commands like ls or tar with concise, ready-to-use examples, making it great for beginners and experienced users who need a fast reminder. 

### Install

```bash
    sudo apt install tldr
```

### Usage

- Print the tldr page for a specific command:

```bash
   tldr command
```

- Print the tldr page for a specific subcommand:

```bash
   tldr command subcommand
```

- Print the tldr page for a command in the given language (if available, otherwise fall back to English):

 ```bash
   tldr [-L|--language] language_code command
```

- Print the tldr page for a command from a specific platform:

```bash
   tldr [-p|--platform] android|cisco-ios|common|dos|freebsd|linux|netbsd|openbsd|osx|sunos|windows command
```

- Update the local cache of tldr pages:

```bash
   tldr [-u|--update]
```

- List all pages for the current platform and common:

```bash
   tldr [-l|--list]
```

- List all available subcommand pages for a command:

```bash
   tldr [-l|--list] | grep command | column
```

- Print the tldr page for a random command:

```bash
   tldr [-l|--list] | shuf [-n|--head-count] 1 | xargs tldr
```

## Glow

(Glow github page)[https://github.com/charmbracelet/glow].

### Installation

Linux.

```bash
    sudo mkdir -p /etc/apt/keyrings
```

Get the key.

```bash
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
```

.

```bash
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
```

Update the packages.

```bash
    sudo apt update 
```

Install.

```bash
    sudo apt install glow
```

Windows.

```bash
    choco install glow -y
```

### Usage

```bash
    glow
```

This will give you a list of all markdown files in the directory and sub directories. Select one to view and you will be able to page through the markdown file.

To select a single file.

```bash
    glow -p linux-files.md
```

``-p`` will add the paging system you are using

### Word Wrapping

  The  ``-w``  flag lets you set a maximum width at which the output will be  wrapped:

```bash
    glow -w 60
```

### Themes

Glow also has themes.

```bash
    glow -p -s tokyo-night linux-notes.md
```

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
