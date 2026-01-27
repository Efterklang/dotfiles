# Bun package manager aliases

# Install
alias bi = bun install
alias bia = bun install --frozen-lockfile
alias bida = bun install --dev

# Add packages
alias ba = bun add
alias bad = bun add -d
alias bau = bun add -u

# Remove packages
alias br = bun remove
alias bri = bun remove

alias bo = bun update

# Run scripts
alias bun-start = bun run start
alias bun-dev = bun run dev
alias bun-build = bun run build
alias bun-test = bun run test
alias bun-lint = bun run lint

# Build
alias bb = bun build

# Run package bin
alias bx = bunx

# Package manager
alias bp = bun pm
alias bpr = bun pm remove
alias bpls = bun pm ls
alias bpca = bun pm cache rm
alias bpv = bun pm version
alias bou = bun outdated

# Upgrade
alias bug = bun upgrade

# Global
alias bg = bun pm add -g
alias bgr = bun pm remove -g

# Lockfile
alias bl = bun pm install
alias bf = bun pm install --frozen-lockfile
