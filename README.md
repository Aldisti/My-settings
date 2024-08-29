
## Bash

Global configuration file is: `/etc/bash.bashrc`
User's configuration file is: `~/.bashrc`

### Prompt

> [!TIP]
> For more information about it look [here](https://phoenixnap.com/kb/change-bash-prompt-linux)

#### Colors

To color the text inside your prompt you can use the regular **escape codes**.
```bash
\\[\e[1;32m\\]
```

#### Path

To change the prompt of the shell you have to look for the **PS1** env variable inside your bashrc.

```bash
PS1='\\[\e[1;32m\\]\u@\s\\[\e[0m\\]:\\[\e[1;34m\\]\W\\[\e[0m\\]\$ '
                                                   ↑
```

This is the basic configuration of the prompt, except for the `\W`, that's my only change to bash's prompt.
In origin there was a `\w` that showed the full path to the current directory, but I changed it and now it shows only the current folder name.

#### Functions

To execute a **function** inside your prompt you can place it inside two backticks.
```bash
\u@\h:\w:`my_function`$
```

## Terminal 🖥️

### Readline

Global configuration file is in: `/etc/inputrc`
User's configuration file is in: `~/.inputrc`

#### Autocompletion case insensitive

To make readline autocomplete in a case insesitive manner, add or uncomment the lines below in the conf file.

```bash
set completion-ignore-case On
set show-all-if-ambiguous On
```

#### Partial history search

To make the **up** and **down** arrows search for partial commands, add or uncomment the lines below in the conf file.

```bash
"\e[A": history-search-backward
"\e[B": history-search-forward
```

> [!NOTE]
> The letters A and B could be inverted on your system/machine.

#### Command on new terminal

To run a command on a new terminal and than make it close when the command exits, do this.

```bash
gnome-terminal -- <command>
```

> [!IMPORTANT]
> This probably works only if you have GNOME installed.



## System

### Workspaces

To switch between your workspaces on different monitors, use this command.

```bash
gsettings set org.gnome.mutter workspaces-only-on-primary true
```

### Time ⏲️

On dual boot with Windows, if you want to keep both OS's time synced, do this.

```bash
timedatectl set-local-rtc 1 --adjust-system-clock
```
> [!IMPORTANT]
> This command works on the UTC+1 timezone, in other timezones it could be different.

### GPU

#### Managing your GPU

If you want to change your discrete GPU behaviour, use the command below.

```bash
sudo prime-select <nvidia|intel|on-demand|query>
```

- **nvidia**: only the discrete GPU will be used.
- **intel**: only the integrated GPU will be used.
- **on-demand**: it will switch automatically between the two GPUs.
- **query**: at the moment idk.

> [!NOTE]
> This command has been tested on a computer with an NVIDIA GPU.


## Others

### GDB

Global configuration file is: `/etc/gdb/gdbinit`
User's configuration file is: `~/.gdbinit`

#### Intel syntax

To make gdb use the **intel** syntax while debugging, add this line in the conf file.

```bash
set disassembly-flavor intel
```

### SSH 🔑

#### Jump Host connection

To connect to a nachine with ssh passing through a jump host authenticated with rsa.

```bash
ssh -i /path/to/priv_key -J jump_host_username@jump_host_ip machine_username@machine_ip
```

