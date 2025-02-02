# TODO列表

记录一下打算做的一些功能，避免忘记了。

- [x] 增加软路由上线、下线自动监控功能。
- [x] 优化一些无意义的功能(`节点组切换模式`删掉、删除`启用黑名单模式`和`透明代理模式开关`、`更新版本`改为手动更新、clash面板更改为`http://<lan-ip>:9090/ui/yacd)
- [x] **增加**黑名单(匹配名单走代理,默认直连)、白名单(匹配名单直连,默认走代理)模式切换功能。
- [x] 优化 **添加节点**功能，支持URL订阅源批量添加，包括`base64`解析功能: 更新`uridecoder`程序实现。
- [x] 增加启动配置文件`config.yaml`校验功能: 内部脚本支持必要的config.yaml配置检验，如必要端口设置。
- [x] 增加上传自定义的config.yaml文件功能: 用户可以使用自己的订阅源proxy-providers,以及自己的代理组.
- [x] 增加备份与恢复配置功能: 方便使用者折腾,如果折腾失败了可以快速恢复到备份前状态.
- [x] 增加自定义**黑、白名单规则**界面配置功能: 想要单独设置某个网站使用代理或者直连(比如游戏网站、视频网站等)，这个功能就满足要求了.
- [x] 增加了**黑名单模式/白名单模式**选择: 黑名单模式时默认直连，白名单模式时默认走代理，匹配规则都来自于github分享。
- [x] 可视化编辑config.yaml文件及其包含的providers文件: v2.2.4版本支持。
- [ ] 增加ADS广告过滤规则。
- [ ] 支持vClash升级功能，页面加载时检测一次版本信息，如有新版本，提示在线升级功能。
- [ ] 增加IPv6支持：添加了开关选项。
- [ ] 支持挂载虚拟内存功能:无内存速度测试验证(适合不常使用虚拟内存情况,如果内存经常吃紧推荐买个MLC固态优盘)

---
