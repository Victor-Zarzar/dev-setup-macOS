#!/bin/bash

# ============================================
# macOS Development Environment Setup
# Main Entry Point
# ============================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$SCRIPT_DIR/lib"

source "$LIB_DIR/colors.sh"
source "$LIB_DIR/helpers.sh"
source "$LIB_DIR/prerequisites.sh"
source "$LIB_DIR/homebrew.sh"
source "$LIB_DIR/directories.sh"
source "$LIB_DIR/fonts.sh"
source "$LIB_DIR/shell-tools.sh"
source "$LIB_DIR/databases.sh"
source "$LIB_DIR/apps.sh"
source "$LIB_DIR/dev-tools.sh"
source "$LIB_DIR/python-tools.sh"
source "$LIB_DIR/flutter-tools.sh"
source "$LIB_DIR/git-config.sh"
source "$LIB_DIR/xcode-config.sh"

LOG_FILE="$HOME/dev_setup_macOS_$(date +%Y%m%d_%H%M%S).log"
TOTAL_INSTALLED=0

# ============================================
# Main Menu
# ============================================

show_menu() {
    clear
    print_header
    echo -e "  ${PURPLE}Available Options:${NC}"
    echo ""
    echo -e "  ${GREEN}1)${NC}  Run complete setup"
    echo -e "  ${GREEN}2)${NC}  Check prerequisites (Xcode License, Command Line)"
    echo -e "  ${GREEN}3)${NC}  Install Homebrew only"
    echo -e "  ${GREEN}4)${NC}  Setup directories"
    echo -e "  ${GREEN}5)${NC}  Install fonts (Nerd Fonts)"
    echo -e "  ${GREEN}6)${NC}  Install shell tools (Starship, Iterm2, Eza, Zoxide...)"
    echo -e "  ${GREEN}7)${NC}  Install databases (SQlite, Redis, MySQL, Supabase, Firebase)"
    echo -e "  ${GREEN}8)${NC}  Install applications (Localsend, Orion, Zed, Notion...)"
    echo -e "  ${GREEN}9)${NC}  Install development tools (Git, Nvm, Nmap, Mackup, Mas, OpenJDK21...)"
    echo -e "  ${GREEN}10)${NC} Install Python tools (Pyenv, VirtualEnv)"
    echo -e "  ${GREEN}11)${NC} Install Flutter tools (FVM)"
    echo -e "  ${GREEN}12)${NC} Configure Git"
    echo -e "  ${GREEN}13)${NC} Configure Xcode"
    echo -e "  ${GREEN}14)${NC} View installation log"
    echo -e "  ${GREEN}0)${NC}  Exit"
    echo ""
    echo -ne "  ${CYAN}→ Choose an option: ${NC}"
}

run_full_setup() {
    print_header
    echo -e "${YELLOW}Starting complete setup...${NC}\n"

    if ! check_prerequisites; then
        print_error "Prerequisites check failed. Aborting setup."
        return 1
    fi

    install_homebrew
    setup_directories
    install_fonts
    install_shell_tools
    install_databases
    install_apps
    install_development_tools
    install_python_tools
    install_flutter_tools
    configure_git
    configure_xcode

    echo ""
    print_section "Setup Summary"
    echo -e "${GREEN}Total packages installed:${NC} $TOTAL_INSTALLED"
    echo -e "${GREEN}Log file:${NC} $LOG_FILE"
    echo ""
    print_success "Setup complete!"
    print_warning "Please restart your terminal for all changes to take effect"
    echo ""

    log_action "Complete setup finished - Total packages: $TOTAL_INSTALLED"
}

# ============================================
# Main Loop
# ============================================

main() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is for macOS only!"
        exit 1
    fi

    touch "$LOG_FILE"
    log_action "Starting setup script"

    while true; do
        show_menu
        read -r option

        case $option in
            1) run_full_setup ;;
            2) check_prerequisites ;;
            3) install_homebrew ;;
            4) setup_directories ;;
            5) install_fonts ;;
            6) install_shell_tools ;;
            7) install_databases ;;
            8) install_apps ;;
            9) install_development_tools ;;
            10) install_python_tools ;;
            11) install_flutter_tools ;;
            12) configure_git ;;
            13) configure_xcode ;;
            14) cat "$LOG_FILE" | less ;;
            0)
                print_success "Goodbye!"
                log_action "Script finished"
                exit 0
                ;;
            *)
                print_error "Invalid option!"
                ;;
        esac

        echo ""
        read -p "Press ENTER to continue..."
    done
}

main
