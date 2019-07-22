#!/usr/bin/env bash
# setup-basic-docker.sh

# Install pre-requisites and docker apt repository
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update

# Install docker, configure permissions, start
sudo apt-get install -y docker-ce

sudo usermod -aG docker $USER

sudo service docker start

# Install pre-requisites for docker-compose
sudo apt-get update
sudo apt-get install -y \
    git \
    jq

# Get latest release using github api
REPO=docker/compose
echo "Repository: $REPO"
GIT_JSON="$(curl --silent "https://api.github.com/repos/$REPO/releases/latest")"

# Extract the download URL by parsing JSON with the tool jq
# https://stedolan.github.io/jq/tutorial/
LATEST_RELEASE="$(echo $GIT_JSON | jq '. | {name: .name, release: .tag_name, date: .published_at, tarUrl: .tarball_url, zipUrl: .zipball_url} ' )"
RELEASE_TAG="$(echo $LATEST_RELEASE | jq -r '.release')"
echo "Release: $(echo $LATEST_RELEASE | jq -r '.name')"
echo "Version: $RELEASE_TAG"
echo "Published: $(echo $LATEST_RELEASE | jq -r '.date')"
echo "URL: $(echo $LATEST_RELEASE | jq -r '.tarUrl')"

# Download Docker-Compose
sudo curl -L https://github.com/$REPO/releases/download/$RELEASE_TAG/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

# Make application executable from the command line
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/$RELEASE_TAG/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
