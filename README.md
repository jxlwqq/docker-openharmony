# Docker OpenHarmony

OpenHarmony 5.0 容器镜像，基于 `ubuntu:22.04`：
* JDK 使用 `java-17-amazon-corretto-jdk`；
* commandline-tools 版本：`5.0.5.310`，由于下载过程需要 Auth 认证，暂时只能在 [华为开发者联盟-下载中心](https://developer.huawei.com/consumer/cn/download/) 手动下载；
* 支持 OpenHarmony React Native 和 OpenHarmony Flutter 工程；
* 内置 json5，可将 json5 转换为 json，方便 jq 操作；
* 内置 pnpm@8.13.1，开箱即用，无需 hvigor 重复安装；

## 使用

```bash
docker pull jxlwqq/openharmony:5.0.5.310

docker run -it --rm jxlwqq/openharmony:5.0.5.310 ohpm -v
```

## Todo

* 由于镜像大小超过了 15 GB，未来将尝试精简。

## 参考

* [Command Line Tools 获取命令行工具](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-commandline-get-V5)
* [Command Line Tools 搭建流水线](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-command-line-building-app-V5)
* [DevEco Studio 无网络环境配置指导](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-no-network-V5)
* [ohos react native 环境搭建](https://gitee.com/openharmony-sig/ohos_react_native/blob/master/docs/zh-cn/%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA.md)
* [ohos flutter 环境搭建](https://gitee.com/openharmony-sig/flutter_flutter#%E7%8E%AF%E5%A2%83%E4%BE%9D%E8%B5%96)

