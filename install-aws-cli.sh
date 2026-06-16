#!/bin/bash

# IMPORTS
source ./modules.sh

CLI_PATH="${HOME_PATH}/awscliv2.zip"
KEY_PATH="${HOME_PATH}/.dotfiles/aws-cli.pub"
SIG_PATH="${HOME_PATH}/awscliv2.sig"

FN_PRINT_GREEN_BANNER "Installing AWS CLI"

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o ${CLI_PATH}

# There is no URL for the PUB key, its in docs. Verify again if it fails https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
gpg --import ${KEY_PATH}
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip.sig" -o ${SIG_PATH}
gpg --verify ${SIG_PATH} ${CLI_PATH} && FN_PRINT_YELLOW "SIGNATURE VERIFIED SUCCESSFULLY" || FN_ERR_EXIT "SIGNATURE INVALID"

FN_PRINT_GREEN_BANNER "Download Verified. Unzipping and Installing CLI"

unzip ${CLI_PATH} -d ${HOME_PATH}
sudo ${HOME_PATH}/aws/install

FN_PRINT_YELLOW "AWS CLI Installed, verifying version"
aws --version

FN_PRINT_YELLOW "CLEANING AWS FILES"
rm ${CLI_PATH}
rm ${SIG_PATH}

FN_PRINT_GREEN_BANNER "AWS CLI INSTALLED SUCCESSFULLY"
