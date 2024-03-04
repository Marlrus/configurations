#!/bin/bash

source ../modules.sh

FN_PRINT_GREEN_BANNER "AWS SAM CLI INSTALLATION/UPDATE"

gpg --import ./sam-primary-public-key.txt
gpg --import ./sam-signer-public-key.txt
gpg --fingerprint FE0ADDFA

FN_PRINT_GREEN_BANNER "Please verify that the fingerpint matches 37D8 BE16 0355 2DA7 BD6A  04D8 C7A0 5F43 FE0A DDFA (y/n)"

read FINGERPRINT_MATCH

if [[ $FINGERPRINT_MATCH == "n" || $FINGERPRINT_MATCH == "N" ]] 
then
  FN_PRINT_YELLOW "Corrupted Fingerprint. Exiting"
  exit 0
fi

SIG_FILE_NAME="aws-sam-cli-linux-x86_64.zip.sig"
wget -q --show-progress https://github.com/aws/aws-sam-cli/releases/latest/download/${SIG_FILE_NAME} -P ${HOME_PATH}/

FN_PRINT_GREEN_BANNER "SAM Signature Download complete"

ZIP_FILENAME="aws-sam-cli-linux-x86_64.zip"
wget -q --show-progress https://github.com/aws/aws-sam-cli/releases/latest/download/${ZIP_FILENAME} -P ${HOME_PATH}/

FN_PRINT_GREEN_BANNER "SAM Zip Download Completed"

gpg --verify ${HOME_PATH}/${SIG_FILE_NAME} ${HOME_PATH}/${ZIP_FILENAME}

FN_PRINT_GREEN_BANNER "Did the Signatures match with the message: Good Signature from \"AWS SAM CLI Team...\" (y/n)"
read SIGNATURE_MATCH

if [[ $SIGNATURE_MATCH == "n" || $SIGNATURE_MATCH == "N" ]] 
then
  FN_PRINT_YELLOW "Corrupted Download. Exiting"
  exit 0
fi

FN_PRINT_GREEN_BANNER "Proceeding to Install"

unzip ${HOME_PATH}/${ZIP_FILENAME} -d ${HOME_PATH}/sam-installation
sudo ${HOME_PATH}/sam-installation/install
where sam
sam --version

FN_PRINT_GREEN_BANNER "AWS SAM CLI INSTALLED/UPDATED, cleaning up downloaded files"

rm -rf ${HOME_PATH}/sam-installation
rm -rf ${HOME_PATH}/${SIG_FILE_NAME}
rm -rf ${HOME_PATH}/${ZIP_FILENAME}

FN_PRINT_GREEN_BANNER "AWS SAM CLI INSTALL/UPDATE COMPLETE"
