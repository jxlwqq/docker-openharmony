FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]

## Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

RUN apt-get update && apt-get -y install locales curl gnupg

RUN locale-gen en_US.UTF-8 || true

ENV LANG=en_US.UTF-8

RUN curl -fsSL https://apt.corretto.aws/corretto.key | gpg --dearmor -o /usr/share/keyrings/corretto-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/corretto-keyring.gpg] https://apt.corretto.aws stable main" | tee /etc/apt/sources.list.d/corretto.list

## Install dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
    java-17-amazon-corretto-jdk \
    wget \
    git \
    build-essential \
    zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libgl1-mesa-dev \
    unzip \
    ssh \
    jq \
    tzdata

## Clean dependencies
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

ENV OH_HOME="/opt/oh/sdk"
# https://developer.huawei.com/consumer/cn/download/
ARG OH_VERSION=5.0.3.906
COPY commandline-tools-linux-x64-${OH_VERSION}.zip /tmp/commandline-tools-linux-x64-${OH_VERSION}.zip
RUN mkdir -p ${OH_HOME} && \
    unzip /tmp/commandline-tools-linux-x64-${OH_VERSION}.zip -d ${OH_HOME} && \
    rm /tmp/commandline-tools-linux-x64-${OH_VERSION}.zip
ENV PATH=${OH_HOME}/command-line-tools/bin:${OH_HOME}/command-line-tools/tool/node/bin:${OH_HOME}/command-line-tools/sdk/default/openharmony/toolchains:${PATH}

# install json5, Convert JSON5 to JSON
RUN npm install -g json5

# Install pnpm in $HOME/.hvigor/wrapper/tools
# Hvigor will install pnpm in $HOME/.hvigor/wrapper/tools
# In order to use it out of the box, we need to install pnpm in advance
# https://gitee.com/openharmony/docs/issues/IB1EKS
ARG PNPM_VERSION=8.13.1
RUN mkdir -p $HOME/.hvigor/wrapper/tools && \
    echo "{\"dependencies\":{\"pnpm\":\"^${PNPM_VERSION}\"}}" > $HOME/.hvigor/wrapper/tools/package.json && \
    cd $HOME/.hvigor/wrapper/tools && \
    npm install

# Disable git safe directory check as this is causing GHA to fail on GH Runners
RUN git config --global --add safe.directory '*'

# smoke test
RUN ohpm -v
