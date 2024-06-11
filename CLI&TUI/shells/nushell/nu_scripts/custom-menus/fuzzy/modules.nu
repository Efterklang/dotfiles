{
    name: fuzzy_module
    modifier: control
    keycode: char_u
    mode: [emacs, vi_normal, vi_insert]
    event: {
        send: executehostcommand
        cmd: '
<<<<<<< HEAD
            commandline --replace "use "
            commandline --insert (
=======
            commandline edit --replace "use "
            commandline edit --insert (
>>>>>>> 407a313bbb13bd5ce2de16768ab2ebec7c111657
                $env.NU_LIB_DIRS
                | each {|dir|
                    ls ($dir | path join "**" "*.nu")
                    | get name
                    | str replace $dir ""
                    | str trim -c "/"
                }
                | flatten
                | input list --fuzzy
                    $"Please choose a (ansi magenta)module(ansi reset) to (ansi cyan_underline)load(ansi reset):"
            )
        '
    }
}
