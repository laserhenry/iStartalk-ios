公有云（Startalk APP）
=====
基于Startalk服务器及客户端，用户可建立属于自己的域,

注册账号、新建域、添加域用户、下载客户端、配置域导航，

仅需5步，您就可以拥有强大的im能力，

客户端下载[下载](https://uk.startalk.im/#/download)

客户端导航配置[配置导航](https://www.qtalk.app:8080/newapi/nck/qtalk_nav.qunar)

私有云（Startalk SDK）
=====
Startalk私有云是一种去中心化的部署方式，

用户或企业将Startalk后端代码完全部署在自己的服务器上，

选择SDK嵌入自己的APP中，

每个公司都是一个单独的节点，每个节点独立运营，数据只保存在节点中

## 介绍

QIMCommon是一套高性能的IM组件

## 集成环境
* 编译版本 : iOS SDK 9.0 及以上。
* 操作系统 : iOS 9.0 及以上。

## 集成说明

### Cocoapods 集成

我们建议你通过 [Cocoapods](https://cocoapods.org/) 来进行 `QIMCommon` 的集成,在 `Podfile` 中加入以下内容:

```shell
source 'https://github.com/startalkIM/libqimkit-ios-cook.git'
pod 'QIMCommon'
```

### 手动集成（不推荐！！！）

1. 下载QIMCommon文件夹内的所有内容
2. 将QIMCommon内的源文件，资源文件, 静态库添加（拖放）到你的工程
4. 链接以下系统依赖项
    * Foundation
    * CoreTelephony
    * AVFoundation
    * SystemConfiguration
    * AudioToolbox
    * UserNotifications
    * QuartzCore
    * CoreGraphics
    * Security
5. 链接以下第三方库
    * YYCache
    * YYModel
    * ProtocolBuffers
    * CocoaAsyncSocket
    * UICKeyChainStore
    * AvoidCrash
6. 链接QIMSDK依赖项
    * QIMOpenSSL
    * QIMKitVendor
    * QIMDataBase

## 历史版本:
你可以在当前仓库的 Release 进行QIMCommon历史版本下载。

## 问题反馈

-   app@startalk.im（邮件）
