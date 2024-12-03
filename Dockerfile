FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]

## Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

RUN apt-get update && \
    apt-get -y install locales curl gnupg && \
    rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 || true

ENV LANG=en_US.UTF-8

RUN curl -fsSL https://apt.corretto.aws/corretto.key | gpg --dearmor -o /usr/share/keyrings/corretto-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/corretto-keyring.gpg] https://apt.corretto.aws stable main" | tee /etc/apt/sources.list.d/corretto.list

## Install dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
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
    tzdata && \
    rm -rf /var/lib/apt/lists/*

ENV OH_HOME="/opt/oh"
# https://developer.huawei.com/consumer/cn/download/
ARG OH_VERSION=5.0.5.300
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

# set RNOH_C_API_ARCH for React Native OpenHarmony
# https://gitee.com/openharmony-sig/ohos_react_native/blob/master/docs/zh-cn/%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA.md
ENV RNOH_C_API_ARCH=1

# Flutter OpenHarmony
# https://gitee.com/openharmony-sig/flutter_flutter
ARG FLUTTER_VERSION="3.7.12-ohos-1.0.2"
ENV FLUTTER_HOME="/usr/local/flutter-sdk"
# Download Flutter SDK
RUN mkdir -p $FLUTTER_HOME && \
    git clone -b $FLUTTER_VERSION https://gitee.com/openharmony-sig/flutter_flutter.git $FLUTTER_HOME
ENV PATH=$PATH:$FLUTTER_HOME/bin
ENV PUB_HOSTED_URL="https://pub.flutter-io.cn"
ENV FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
RUN flutter doctor -v

# Smoke test
RUN ohpm -v
