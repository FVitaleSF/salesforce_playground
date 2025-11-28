
FROM node:20-bullseye


RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    ca-certificates \
    openjdk-17-jre-headless \
    && rm -rf /var/lib/apt/lists/*


RUN npm install --global @salesforce/cli


RUN sf plugins install sfdx-git-delta


WORKDIR /sf-ci-cd

CMD ["bash"]
