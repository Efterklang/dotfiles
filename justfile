# Backup Vimium C settings from Downloads to dotfiles
backup-vimiumc:
  mv ~/Downloads/vimium_c-*.json ./application/chromium/configs/vimium_c/vimium_c.json

[working-directory('application/ghostty/shaders')]
update-ghostty-shaders:
  git pull
  cd {{justfile_directory()}} && git add application/ghostty/shaders
  cd {{justfile_directory()}} && git commit -m "chore(ghostty): update shaders submodule"
