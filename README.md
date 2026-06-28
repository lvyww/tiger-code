# tiger-code

虎码输入法官方码表。

本仓库目前只维护字词版码表，方便优先推动 Fcitx5 / Fcitx5 Android 等平台集成。

## 文件

- `tables/tiger.txt`: Fcitx5 table 源码表
- `tables/tiger.conf.in`: Fcitx5 table 输入法配置
- `scripts/build-fcitx5.sh`: 使用 `libime_tabledict` 编译检查码表

## 构建检查

需要安装 `libime_tabledict`。

```bash
./scripts/build-fcitx5.sh
```

脚本会生成临时的 `tiger.main.dict` 并立即删除，用于确认源码表可被 Fcitx5/libime 正常编译。

## 授权

虎码码表数据以 CC0-1.0 发布，方便开源和商业输入法平台集成。

“虎码”名称、标识和相关品牌不随码表数据授权自动授予。
