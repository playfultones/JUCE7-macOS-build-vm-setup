# Sonoma build VM installer script

This script will help you create a macOS build VM for development and testing. It will install all the necessary dependencies and set up the VM for you. The guide expects you need Sonoma and Xcode 15.4, but in theory this should work with any macOS version and Xcode version.

## Prerequisites

> Note that this script requires a recent Mac with Apple silicon (M1 or newer) chip.

> Download links provided here are for the official Apple downloads.

### Download macOS Sonoma installer image
You can get it from [here](https://updates.cdn-apple.com/2024SummerFCS/fullrestores/062-52859/932E0A8F-6644-4759-82DA-F8FA8DEA806A/UniversalMac_14.6.1_23G93_Restore.ipsw).

### Download XCode 15.4
You can get it from [here](https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_15.4/Xcode_15.4.xip).

> Note that this requires an Apple Developer account.

### Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## Quick Start

An easy way to get started is to run the `run.sh` script. This script will install all the necessary dependencies and set up the VM for you.

```
Usage: ./run.sh [OPTIONS]

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
```

### Overriding default values

You can override any of the defaults configured in `default.config.yml` by creating a `config.yml` file and setting the overrides in that file. You can configure the VM's properties, such as the name, memory, CPU count, as well as which packages to install.

### Run the script

Once you have the prerequisites installed, you can run the script to set up the VM. The script will download and install the necessary dependencies, as well as set up the VM for you. Some of the steps may take a while, so be patient. Some of the steps will require user input, so be sure to read the prompts carefully.

```
chmod +x run.sh
./run.sh --install-deps
```

### Run the playbook

If you already have the dependencies installed, you can run the playbook directly. This will set up the VM for you without having to run the script.

```
ansible-playbook main.yml
```

## Overview of the playbook

The playbook is divided into several steps, each of which performs a specific task. The steps are as follows:

### Create macOS VM with Parallels and IPSW

In this step, we create a macOS VM using Parallels and the IPSW file downloaded in the prerequisites. The VM will be configured with the specified properties, such as name, memory, CPU count, and disk size.
We'll enable SSH access to the VM with user interaction.
The Xcode archive will be copied to the VM and installed. 

### Update macOS on VM

In this step, we update the macOS VM to the latest version. This is done by running the `softwareupdate` command on the VM. The VM will be restarted after the update is complete. This step requires user interaction.

### Install development environment

In this step, we install the development environment on the macOS VM. This includes installing Homebrew, and any necessary packages. The packages will be installed using Homebrew and Ansible. This is fully automated and does not require any user interaction.

### Create Snapshot of macOS VM

In this step, we create a snapshot of the macOS VM.

## Acknowledgements

This project is inspired by the work of [geerlingguy](https://github.com/geerlingguy) and uses some of his code as a reference. It's licensed under the MIT License.

```
Copyright (c) 2013 Michael Griffin
http://mwgriffin.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```