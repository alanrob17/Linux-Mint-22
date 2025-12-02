# Installing modern linux utilities

There are a number of Rust utilities that can be used in Linux or Windows. I will install and document these applications.

These are documented at Github - [Modern Unix utilities](https://github.com/ibraheemdev/modern-unix).

Rust is increasingly used to develop modern Unix applications and tools, often as replacements or enhancements for traditional C-based utilities. This trend is driven by Rust's focus on memory safety, performance, and concurrency, addressing common challenges faced in system programming.

Here are some examples of modern Unix applications and tools written in Rust:

## Core Utilities & Replacements

**ripgrep (rg)**: A faster and more feature-rich alternative to grep for searching regex patterns.

**fd**: A simpler and more intuitive alternative to find.

**sd**: An intuitive find-and-replace CLI, serving as a modern alternative to sed and awk.

**zoxide**: A smarter cd replacement that learns your navigation patterns.

**Dust**: A du alternative with improved visualization for disk usage.

**procs**: A ps replacement offering enhanced process information.

**bottom**: A top replacement with a modern terminal UI.

**rip**: An improved, safer, and user-friendly version of rm.

**xcp**: A faster and more user-friendly cp alternative with progress bars and parallel copying. 

### Other Notable Tools

**Broot**: A tree alternative with a better user experience for navigating file structures. 

**Tokei**: A utility for counting lines and statistics of code.

**Topgrade**: A utility to keep your system and tools updated.

**gping**: A ping replacement that visualizes ping times with a graph.

**miniserve**: A CLI tool to serve files and directories over HTTP. 

**macchina**: A fast, minimal, and customizable system information frontend.

**pastel**: A command-line tool for colour manipulation and analysis.

### Why Rust for Unix Applications?

Memory Safety: Rust's ownership system and borrow checker prevent common memory-related bugs, enhancing security and stability.

Performance: Rust offers performance comparable to C/C++, making it suitable for low-level system tools.

Concurrency: Rust's features for safe concurrency make it easier to write performant multi-threaded applications without data races.

Modern Tooling: Rust's ecosystem, including Cargo (package manager and build system), provides a streamlined development experience.

### Bat

#### Installation

``Linux``.

```bash
    sudo apt install bat
```

``Windows``.

**Note:** use the Administrator account to install all software through ``choco``.

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

On Linux I can create an alias for ``cat`` and it should work. This alias won't work on Windows.

```bash
    alias cat='batcat'
```

Now to test this out.

```bash
    cat Program.cs
```

Returns.

![BatCat output](assets/images/batcat-output.jpg "BatCat output")

This is BatCat running in DOS.

![DOS BatCat output](assets/images/batcat-output2.jpg "DOS BatCat output")

### Eza

``eza`` is a coloured replacement for ``ls``. It seems to have all of the options that ``ls`` has plus a lot of extras. Once again this works on a Windows PC.

Once again I can create an alias for ``eza``.

```bash
    alias ls='eza'
```

For consistency with Windows I have also created another alias.

```bash
    alias la='eza'
```

In Windows Powershell.

```bash
    new-item alias:la -value eza
```

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

### Glow

(Glow github page)[https://github.com/charmbracelet/glow].

#### Installation

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

#### Usage

```bash
    glow
```

This will give you a list of all markdown files in the directory and sub directories. Select one to view and you will be able to page through the markdown file.

To select a single file.

```bash
    glow -p linux-files.md
```

``-p`` will add the paging system you are using

**Word Wrapping**

  The  ``-w``  flag lets you set a maximum width at which the output will be  wrapped:

```bash
    glow -w 60
```

**Themes**

Glow also has themes.

```bash
    glow -p --style tokyo-night linux-notes.md
```

**Note:** you can use ``-s`` in place of ``--style``.

All current themes.

* light -- faulty on mine.
* dark -- default
* notty -- black and white
* dracula -- I like this
* pink -- pink headers
* tokyo-night -- nice

You can create your own.

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

#### How to Use zoxide

As with similar tools, ``zoxide`` has to first “learn” directories for its ranking algorithm. So, to begin, navigate to some directories just like you would with ``cd``, but using the ``z`` command instead.

You can use the following series of commands to do just that. The examples that follow in this guide use these commands as a baseline to show you how the zoxide algorithm operates:

```bash
z /etc/opt
z /etc/ssh
z /etc/ssh/ssh_config.d
z /usr/local/bin
z /var/log
```

Once you’ve taught zoxide your frequently visited directories, you can begin using abbreviated directory searches. For instance, to navigate into the ``/etc/ssh`` directory after using the above commands, you can enter ``z ssh``.

Notice that using ``z ssh`` command takes you to ``/etc/ssh``. However, try using the following command three or four times:

```bash
z config
```

After doing that, the next time you use the z ssh command, you are taken to the ``/etc/ssh/ssh_config.d`` directory. Why? Because ``zoxide`` has ranked it as your most frequent visited directory that matches the search query ssh.

You can use the following command to get back to ``/etc/ssh``. This works because the provided search terms more closely match the directory.

```bash
z etc ssh
```

``zoxide`` also supports partial search terms, as you can see above with config. You can also use this feature for something like the following command, which still gets you to ``/usr/local/bin``:

```bash
z lo b
```

Be aware that your ``zoxide`` search needs to include something of the destination directory. For instance, ``z`` var doesn’t get you to the ``/var/log directory``, but searches like ``z log`` or ``z var l`` do.

#### Interactive Searches with fzf

If you have ``fzf`` installed, ``zoxide`` can use it to let you select from a list of all directories it matches for a given search term or terms. For instance, the following command matches both ``/etc/ssh`` and ``/etc/ssh/ssh_config.d``, and so the interactive zoxide command gives you an option to select between the two directories:

```bash
zi ssh
```

Returns.

![Zoxide selection](assets/images/zoxide-interactive-selection.jpg "Zoxide selection")

Another example. From my home directory type.

```bash
	z D <SPACE><TAB>
```

Will print out.

![Zoxide with FZF](assets/images/z-with-fzf.jpg "Zoxide with FZF")

You can then move to ``Documents`` or ``Downloads``.
