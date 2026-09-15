#!/bin/bash

# ============================================
# Applications Installation
# ============================================

install_apps() {
    print_section "Installing Applications"

    local casks=(
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
        "onlyoffice:OnlyOffice"
        "protonvpn:ProtonVPN"
        "macs-fan-control:Macs Fan Control"
        "slack:Slack"
        "tunnelblick:Tunnelblick"
        "kap:Kap Screen Recorder"
        "responsively:Responsively"
        "figma:Figma App"
        "the-unarchiver:The Unarchiver"
        "balenaetcher:BalenaEtcher"
        "rectangle:Rectangle"
        "shottr:Shottr"
        "spotify:Spotify"
    )

    local formulas=(
        "kubectl:Kubernetes CLI"
        "minikube:Minikube"
        "k9s:k9s"
    )

    for app in "${casks[@]}"; do
        IFS=':' read -r cmd desc <<< "$app"

        if brew list --cask "$cmd" &> /dev/null; then
            print_info "$desc already installed"
        else
            run_command "brew install --cask $cmd" "$desc"
        fi
    done

    for app in "${formulas[@]}"; do
        IFS=':' read -r cmd desc <<< "$app"

        if brew list "$cmd" &> /dev/null; then
            print_info "$desc already installed"
        else
            run_command "brew install $cmd" "$desc"
        fi
    done
}
