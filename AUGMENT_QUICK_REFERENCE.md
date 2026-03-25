# Augment MCP 快速参考

## 🚀 一键检查
```bash
~/.claude/scripts/check-auggie-health.sh
```

## 📍 关键文件位置

| 文件 | 路径 | 说明 |
|------|------|------|
| MCP 配置 | `~/.claude/mcp_settings.json` | Claude Code MCP 服务器配置 |
| Auggie 会话 | `~/.augment/session.json` | Auggie 登录会话（持久化） |
| Auggie 设置 | `~/.augment/settings.json` | Auggie CLI 配置 |
| 健康检查脚本 | `~/.claude/scripts/check-auggie-health.sh` | 验证配置状态 |
| 完整文档 | `~/.claude/AUGMENT_MCP_SETUP.md` | 详细配置文档 |

## 🔧 常用命令

### 检查状态
```bash
# 查看 MCP 服务器状态
claude mcp list

# 查看 Auggie 账号信息
auggie account

# 查看 Auggie 版本
auggie --version
```

### 重新配置
```bash
# 重新登录
auggie logout && auggie login

# 更新 Auggie
npm update -g @augmentcode/auggie

# 重新添加 MCP（如果需要）
claude mcp remove auggie
claude mcp add-json auggie --scope user '{"type":"stdio","command":"auggie","args":["--mcp","--mcp-auto-workspace"]}'
```

## 💡 使用技巧

### 在 Claude Code 中使用
启动 Claude Code 后，你可以直接问：
```
"使用 Augment 找到所有处理支付的代码"
"这个项目中的 API 端点在哪里定义？"
"找出所有数据库查询相关的文件"
```

### MCP 工具
- `mcp__auggie__codebase-retrieval`: 语义化代码搜索
  - 自动检测当前工作目录
  - 使用自然语言描述查询
  - 返回相关代码片段和位置

## ⚡ 故障排除

### MCP 未连接
1. 检查 auggie 是否登录：`auggie account`
2. 重启 Claude Code
3. 运行健康检查：`~/.claude/scripts/check-auggie-health.sh`

### 会话过期
```bash
auggie logout
auggie login
```

### MCP 配置丢失
```bash
claude mcp add-json auggie --scope user '{"type":"stdio","command":"auggie","args":["--mcp","--mcp-auto-workspace"]}'
```

---
💡 提示：配置是持久化的，重启电脑后依然有效！
