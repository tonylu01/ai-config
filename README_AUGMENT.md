📚 Augment Context Engine MCP - 文档索引
========================================

快速导航到所有 Augment MCP 相关文档和脚本。

## 📖 文档

1. **完成总结** ⭐ 从这里开始
   - 文件：`~/.claude/AUGMENT_COMPLETION.md`
   - 命令：`cat ~/.claude/AUGMENT_COMPLETION.md`
   - 内容：配置完成状态、验证方法、快速开始

2. **快速参考**
   - 文件：`~/.claude/AUGMENT_QUICK_REFERENCE.md`
   - 命令：`cat ~/.claude/AUGMENT_QUICK_REFERENCE.md`
   - 内容：常用命令、关键文件位置、故障排除

3. **详细配置指南**
   - 文件：`~/.claude/AUGMENT_MCP_SETUP.md`
   - 命令：`cat ~/.claude/AUGMENT_MCP_SETUP.md`
   - 内容：完整配置步骤、参数说明、维护方法

4. **文档索引（本文件）**
   - 文件：`~/.claude/README_AUGMENT.md`
   - 命令：`cat ~/.claude/README_AUGMENT.md`

## 🛠️ 脚本

1. **一键设置脚本**
   - 文件：`~/.claude/scripts/setup-augment-mcp.sh`
   - 命令：`~/.claude/scripts/setup-augment-mcp.sh`
   - 用途：新机器快速配置 Augment MCP

2. **健康检查脚本** ⭐ 推荐
   - 文件：`~/.claude/scripts/check-auggie-health.sh`
   - 命令：`~/.claude/scripts/check-auggie-health.sh`
   - 用途：验证 Auggie 和 MCP 状态

3. **Fish Shell 别名**
   - 文件：`~/.claude/scripts/auggie-aliases.fish`
   - 安装：`echo 'source ~/.claude/scripts/auggie-aliases.fish' >> ~/.config/fish/config.fish`
   - 用途：便捷命令别名（fish shell）

4. **Bash/Zsh 别名**
   - 文件：`~/.claude/scripts/auggie-aliases.sh`
   - 安装：`echo 'source ~/.claude/scripts/auggie-aliases.sh' >> ~/.zshrc`
   - 用途：便捷命令别名（bash/zsh）

## ⚙️ 配置文件

1. **MCP 服务器配置**
   - 文件：`~/.claude/mcp_settings.json`
   - 命令：`cat ~/.claude/mcp_settings.json`
   - 说明：Claude Code MCP 服务器配置

2. **Auggie 会话**
   - 文件：`~/.augment/session.json`
   - 命令：`cat ~/.augment/session.json`
   - 说明：Auggie 登录会话（持久化）

3. **Auggie 设置**
   - 文件：`~/.augment/settings.json`
   - 命令：`cat ~/.augment/settings.json`
   - 说明：Auggie CLI 用户设置

## 🚀 快速命令

```bash
# 查看完��总结
cat ~/.claude/AUGMENT_COMPLETION.md

# 健康检查
~/.claude/scripts/check-auggie-health.sh

# 查看 MCP 状态
claude mcp list

# 测试集成
claude --print "Do you have access to the Augment codebase retrieval tool?"

# 查看所有文档
ls -lh ~/.claude/AUGMENT*.md
```

## 📌 常见任务

### 初次配置
1. 安装 Auggie：`npm install -g @augmentcode/auggie@latest`
2. 登录：`auggie login`
3. 配置 MCP：`claude mcp add-json auggie --scope user '{"type":"stdio","command":"auggie","args":["--mcp","--mcp-auto-workspace"]}'`

### 日常使用
- 直接在 Claude Code 中使用自然语言查询代码库
- 无需手动操作，MCP 自动启动

### 故障排除
1. 运行：`~/.claude/scripts/check-auggie-health.sh`
2. 查看：`~/.claude/AUGMENT_QUICK_REFERENCE.md` 的故障排除章节

### 重新配置
- 新机器：运行 `~/.claude/scripts/setup-augment-mcp.sh`
- 会话过期：运行 `auggie logout && auggie login`

## 🎯 下一步

✅ 配置已完成！现在你可以：
1. 打开 Claude Code
2. 直接使用 Augment 搜索代码库
3. 享受语义化代码搜索的强大功能

---
最后更新：2026-02-07
