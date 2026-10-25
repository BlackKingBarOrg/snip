# snip

顶栏右上角的截图按钮（`󰹑`）：左键点一下，在冻结的屏幕上拖出一个区域，松开后截图（PNG）
直接进剪贴板，右上角闪一下 "Add image to clipboard"（约 1.5 秒后消失）。不存文件，
不弹编辑器。Esc 或右键取消框选，取消时不提示。

框选、冻屏、光标处理用的是 Omarchy 自带的 `omarchy-capture-screenshot`（和 Print 键同一套），
`snip.sh` 只负责把结果放进剪贴板并弹提示。Omarchy 的通知最少显示 5 秒，所以提示是
`snip.sh` 自己用 `omarchy-shell notifications dismiss` 提前撤掉的；它仍会进通知历史。

## 安装

整个目录就是一个 Omarchy shell 插件（`ai.bkblab.snip`）：

```bash
ln -s "$PWD" ~/.config/omarchy/plugins/ai.bkblab.snip   # 在仓库目录里执行
omarchy-shell shell rescanPlugins
omarchy plugin enable ai.bkblab.snip --before omarchy.power
```

修改 QML 后要 `omarchy restart shell` 才会生效（shell 的文件监听不会跟进符号链接，
`rescanPlugins` 也不会重载）。改 `snip.sh` 不用重启。
从顶栏移除：`omarchy plugin disable ai.bkblab.snip`。
