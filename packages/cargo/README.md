## Linux

Run `cargo install --list`

```shell
bat v0.25.0:
    bat
code2prompt v2.0.0:
    code2prompt
eza v0.20.17:
    eza
fd-find v10.2.0:
    fd
git-delta v0.18.2:
    delta
nu v0.102.0:
    nu
procs v0.14.9:
    procs
ripgrep v14.1.1:
    rg
tailspin v4.0.0:
    tspin
tokei v12.1.2:
    tokei
yazi-cli v25.2.11 (https://github.com/sxyazi/yazi.git#cf0d5767):
    ya
yazi-fm v25.2.11 (https://github.com/sxyazi/yazi.git#cf0d5767):
    yazi
zellij v0.41.2:
    zellij
```

Yet another method to export and import cargo-packages

- Export: `bash -c "cargo install --list | grep -E \"^[a-z0-9_-]+ v[0-9]\" | awk '{print \$1}' > cargo-packages.txt"`
- Import: `cat cargo-packages.txt | xargs -I {} cargo install {}`

## Windows

Most package could be installed using scoop

```shell
code2prompt v2.0.0:
    code2prompt.exe
```
