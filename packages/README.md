| Pkg Manager | Import                                                                      | Export                                                                     | Description                                            |
| ----------- | --------------------------------------------------------------------------- | -------------------------------------------------------------------------- | ------------------------------------------------------ |
| Homebrew    | `brew bundle dump --describe --force --file="./packages/homebrew/Brewfile"` | `brew bundle --file="./packages/homebrew/Brewfile"`                        | Homebrew package manager for macOS and Linux.          |
| Pacman      | `pacman -Qqe > ./packages/pacman/packages.txt`                              | `pacman -S --needed - < ./packages/pacman/packages.txt`                    | Pacman package manager for Arch Linux and derivatives. |
| Scoop       | `scoop export`                                                              | `scoop import "./packages/scoop/scoop-packages.json"`                      | Scoop package manager for Windows.                     |
| Apt-get     | `apt-mark showmanual > ./packages/apt-get/apt-packages.txt`                 | `cat ./packages/apt-get/apt-packages.txt \| xargs sudo apt-get install -y` | Apt package manager for Debian-based systems.          |


## Note

Install rclone using `sudo -v ; curl https://rclone.org/install.sh | sudo bash` instead of homebrew as `rclone mount` is not supported on MacOS when rclone is installed via Homebrew
