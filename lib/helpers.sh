#!/bin/bash

# ============================================
# Helper Functions
# ============================================

print_header() {
    local free_space
    free_space=$(df -h / | tail -1 | awk '{print $4}')
    local current_date
    current_date=$(date '+%Y-%m-%d %H:%M:%S')
    local username
    username=$(whoami)
    local macos_version
    macos_version=$(sw_vers -productVersion)

    echo -e "${GREEN}"
    echo '  ███████╗███████╗████████╗██╗   ██╗██████╗ '
    echo '  ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗'
    echo '  ███████╗█████╗     ██║   ██║   ██║██████╔╝'
    echo '  ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ '
    echo '  ███████║███████╗   ██║   ╚██████╔╝██║     '
    echo '  ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     '
    echo ''
    echo '  ███╗   ███╗ █████╗  ██████╗ ██████╗ ███████╗'
    echo '  ████╗ ████║██╔══██╗██╔════╝██╔═══██╗██╔════╝'
    echo '  ██╔████╔██║███████║██║     ██║   ██║███████╗'
    echo '  ██║╚██╔╝██║██╔══██║██║     ██║   ██║╚════██║'
    echo '  ██║ ╚═╝ ██║██║  ██║╚██████╗╚██████╔╝███████║'
    echo '  ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝'
    echo -e "${NC}"
    echo -e "  ${GREEN}──────────────────────────────────────────────────────────${NC}"
    echo -e "  ${GREEN}✦ User:${NC}        $username"
    echo -e "  ${GREEN}✦ macOS:${NC}       $macos_version"
    echo -e "  ${GREEN}✦ Free Space:${NC}  $free_space"
    echo -e "  ${GREEN}✦ Date:${NC}        $current_date"
    echo -e "  ${GREEN}──────────────────────────────────────────────────────────${NC}"
    echo ""
}

print_section() {
    echo ""
    echo -e "${PURPLE}━━━━ $1 ━━━━${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_executing() {
    echo -e "${CYAN}→${NC} $1"
}

log_action() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

run_command() {
    local cmd="$1"
    local description="$2"

    print_executing "$cmd"
    log_action "Executing: $cmd"

    if eval "$cmd" >> "$LOG_FILE" 2>&1; then
        print_success "${description:-Command completed}"
        ((TOTAL_INSTALLED++))
        return 0
    else
        print_error "${description:-Command failed}"
        log_action "ERROR: $cmd failed"
        return 1
    fi
}
