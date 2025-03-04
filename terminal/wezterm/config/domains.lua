return {
    -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
    ssh_domains = {
        {
            name = 'Raspi-admin',
            remote_address = 'donkey',
            username = 'admin',
        },
    },

    -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
    unix_domains = {},

    -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
    wsl_domains = {
        {
            name = 'Arch',
            distribution = 'Arch',
        }
    },
}
