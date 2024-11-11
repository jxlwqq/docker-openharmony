# Docker OpenHarmony

OpenHarmony 5.0 容器镜像，基于 `ubuntu:22.04`：
* JDK 使用 `java-17-amazon-corretto-jdk`；
* commandline-tools 版本：`5.0.3.906`，由于下载过程需要 Auth 认证，暂时只能在 https://developer.huawei.com/consumer/cn/download/ 手动下载；
* 内置 json5，方便 jq 读取标准的 JSON 文本；
* 内置 pnpm@8.13.1，开箱即用，无需 hvigor 重复安装；

## 使用

## Changelog

## Todo

* 由于镜像大小超过了 14 GB，未来将尝试精简。

