# Docker OpenHarmony

OpenHarmony 5.0 容器镜像，基于 `ubuntu:22.04`：
* JDK 使用 `java-17-amazon-corretto-jdk`；
* commandline-tools 版本：`5.0.3.906`，由于下载过程需要 Auth 认证，暂时只能在 https://developer.huawei.com/consumer/cn/download/ 手动下载；
* 内置 json5，可将 json5 转换为 json，方便 jq 操作；
* 内置 pnpm@8.13.1，开箱即用，无需 hvigor 重复安装；

## 使用

## Changelog

## Todo

* 由于镜像大小超过了 14 GB，未来将尝试精简。

## 参考

* [Command Line Tools 获取命令行工具](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-commandline-get-V5)
* [Command Line Tools 搭建流水线](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-command-line-building-app-V5)
* [DevEco Studio 无网络环境配置指导](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-no-network-V5)

