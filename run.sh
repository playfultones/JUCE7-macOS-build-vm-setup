#!/usr/bin/env bash
## Template source: https://sharats.me/posts/shell-script-best-practices/

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo "Usage: ./run.sh [OPTIONS]

Options:
  -h, --help            Show this help message and exit
  --install-deps        Install dependencies before running the playbook.

Creates a macOS build VM for development and testing.

Depends on:
    Brew Packages:
        - Parallels Desktop
        - Ansible
        - sshpass
    Ansible Dependencies:
        - geerlingguy.mac (Collection)

Dependencies will be installed with Homebrew and ansible-galaxy if --install-deps is passed as an argument. You'll need to have Homebrew installed on your host system.
"
    exit
fi

cd "$(dirname "$0")"

main() {
    local install_deps=0

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --install-deps)
                install_deps=1
                shift
                ;;
            *)
                echo "Unknown option: $1"
                exit 1
                ;;
        esac
    done

    if [[ $install_deps -eq 1 ]]; then
        brew install --cask parallels
        brew install ansible sshpass
        ansible-galaxy install -r requirements.yml
    fi

    # Run Ansible playbook to install and configure the VM
    ansible-playbook main.yml
}

main "$@"