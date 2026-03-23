#!/bin/bash

# ============================================
# Applications Installation
# ============================================

install_apps() {
    print_section "Installing Applications"

    local apps=(
        "localsend:LocalSend"
        "telegram:Telegram"
        "orion:Orion Browser"
        "google-chrome:Google Browser"
        "orbstack:OrbStack"
        "sublime-text:Sublime Text"
        "zed:Zed Editor"
        "android-studio:Android Studio"
        "discord:Discord"
        "notion:Notion"
        "spotify:Spotify"
        "onlyoffice:OnlyOffice"
        "omnidisksweeper:OmniDiskSweeper"
        "protonvpn:ProtonVPN"
        "crossover:CrossOver"
        "macs-fan-control:Macs Fan Control"
        "slack:Slack"
        "cloudflare-warp:Cloudflare WARP"
        "tunnelblick:Tunnelblick"
        "kap:Kap Screen Recorder"
        "responsively:Responsively"
        "figma:Figma App"
    )

    for app in "${apps[@]}"; do
        IFS=':' read -r cmd desc <<< "$app"

        if brew list --cask "$cmd" &> /dev/null; then
            print_info "$desc already installed"
        else
            run_command "brew install --cask $cmd" "$desc"
        fi
    done
}
