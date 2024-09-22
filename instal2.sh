#!/bin/bash
echo "Welcome to the t3rn ALE!"

sleep 1
rm run_executor.sh; wget -O run_executor.sh https://raw.githubusercontent.com/tyaga321/t3rns/main/run_executor.sh


cd $HOME
rm -rf executor
sudo apt -q update
sudo apt -qy upgrade


EXECUTOR_URL="https://github.com/t3rn/executor-release/releases/download/v0.21.0/executor-linux-v0.19.0.tar.gz"
EXECUTOR_FILE="executor-linux-v0.19.0.tar.gz"

echo "Downloading the Executor binary from $EXECUTOR_URL..."
curl -L -o $EXECUTOR_FILE $EXECUTOR_URL

if [ $? -ne 0 ]; then
    echo "Failed to download the Executor binary. Please check your internet connection and try again."
    exit 1
fi

echo "Extracting the binary..."
tar -xzvf $EXECUTOR_FILE
rm -rf $EXECUTOR_FILE
cd t3rn2/executor/executor/bin

echo "Binary downloaded and extracted successfully."
echo

export NODE_ENV=testnet
export LOG_LEVEL=debug
export LOG_PRETTY=false


read -s -p "Enter your Private Key from Metamask: " PRIVATE_KEY_LOCAL
export PRIVATE_KEY_LOCAL=$PRIVATE_KEY_LOCAL
echo -e "\nPrivate key has been set."
echo

export ENABLED_NETWORKS='arbitrum-sepolia,base-sepolia,blast-sepolia,optimism-sepolia,l1rn'



echo "Starting the Executor..."
cd
chmod +x run_executor.sh
./run_executor.sh
