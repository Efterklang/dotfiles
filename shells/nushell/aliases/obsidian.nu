source ../utils/confirm.nu

def _create_soft_link [source: string, target: string] {
    print $"Creating symlink from ($source) to ($target)"

    # Remove target if it already exists
    if ($target | path exists) {
        print $"Removing existing ($target)"
        ^rm -rf $target
    }

    ln -sf $source $target
    print $"✅ Created symlink: ($target) -> ($source)"
}

def _enable_community_plugins [plugin_name: string ] {
    let plugins_file = "./.obsidian/community-plugins.json"
    if not ($plugins_file | path exists) {
        print "❌ community-plugins.json not found!"
        return
    }
    let is_enabled =  (jq $"contains\(["($plugin_name)"]\)" $plugins_file) == "true"

    if $is_enabled {
        print $"✅ Plugin ($plugin_name) is already enabled."
    } else {
        print $"Enabling plugin ($plugin_name)..."
        let updated_plugins = (jq $". + [\"($plugin_name)\"]" $plugins_file)
        $updated_plugins | save -f $plugins_file
        print $"✅ Plugin ($plugin_name) enabled."
    }
}

let global_setting_home = $"($env.HOME)/Projects/dotfiles/application/obsidian"

# hotkeys
alias ob-key = _create_soft_link $"($global_setting_home)/hotkeys.json" "./.obsidian/hotkeys.json"
# themes
def ob-theme [] {
    # use AnuPpuccin theme
    if (confirm_action "💠 Use AnuPpuccin theme? (y/N): ") {
        _create_soft_link $"($global_setting_home)/themes/AnuPpuccin" "./.obsidian/themes/AnuPpuccin"
        _create_soft_link $"($global_setting_home)/appearance.json" "./.obsidian/appearance.json"
        mkdir "./.obsidian/snippets"
        _create_soft_link $"($global_setting_home)/snippets/obsidian.css" "./.obsidian/snippets/obsidian.css"
    }
}
# plugins
def ob-plugins [] {
    let plugin_list = [
        "floating-toc",
        "obsidian-style-settings",
        "obsidian-better-command-palette",
        "obsidian-linter",
        "shiki-highlighter"
    ]

    for plugin in $plugin_list {
        if (confirm_action $"💠 Install and enable plugin ($plugin)? \(y/N\): ") {
            _create_soft_link $"($global_setting_home)/plugins/($plugin)" $"./.obsidian/plugins/($plugin)"
            _enable_community_plugins $"($plugin)"
        }
    }
}