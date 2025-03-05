For Debian-based systems, a quick setup with `apt-get` package manager:

- Export: `apt-mark showmanual > apt-packages.txt`
- Import: `cat apt-packages.txt | xargs sudo apt-get install -y`