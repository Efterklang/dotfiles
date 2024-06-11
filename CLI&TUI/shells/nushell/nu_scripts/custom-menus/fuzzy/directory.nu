{
    name: fuzzy_dir
    modifier: control
    keycode: char_s
    mode: [emacs, vi_normal, vi_insert]
    event: {
        send: executehostcommand
<<<<<<< HEAD
        cmd: "commandline -a (
=======
        cmd: "commandline edit --append (
>>>>>>> 407a313bbb13bd5ce2de16768ab2ebec7c111657
            ls **/*
            | where type == dir
            | get name
            | input list --fuzzy
                $'Please choose a (ansi magenta)directory(ansi reset) to (ansi cyan_underline)insert(ansi reset):'
        )"
    }
}
