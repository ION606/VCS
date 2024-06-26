# My remote sourcing system

## Running
## Option 1: The Script
just use `curl -fsSL -o ivcs.sh https://github.com/ION606/VCS/raw/main/init.sh && chmod +x ivcs.sh && sudo ./ivcs.sh`


## Option 2: Maually
1. install `sshpass ssh pv` using your package manager
2. clone `https://github.com/ION606/VCS.git`
3. move `ionsrc.desktop` to wherever your system stores .desktop files
4. move the rest of the files to `~/ionsrc/`

## Commands
format: `ionvcs <command> [args]`

| Command  | Args        | Description                     |
|----------|-------------|---------------------------------|
| clone    | \<repo-url>  | Clone a repository.            |
| user     | \<username>  | Get user information.          |
| init     | N/A         | Initialize a repository.        |
| login    | N/A         | Login to the system.            |
| push     | [-f]        | Push changes to the repository. |
