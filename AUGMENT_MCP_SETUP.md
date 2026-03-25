# Augment Context Engine MCP - 固化配置指南

## 📋 概述
此文档记录了如何在 Claude Code 中永久集成 Augment Context Engine MCP，确保每次启动都自动可用。

## ✅ 已完成的配置

### 1. 安装 Auggie CLI
```bash
npm install -g @augmentcode/auggie@latest
```
当前版本：`0.15.0`

### 2. 登录 Augment
```bash
auggie login
```
- 登录信息存储在：`~/.augment/session.json`
- 只需登录一次，会话信息会持久保存

### 3. 配置 MCP 服务器（已完成）
```bash
claude mcp add-json auggie --scope user '{"type":"stdio","command":"auggie","args":["--mcp","--mcp-auto-workspace"]}'
```

配置文件位置：`~/.claude/mcp_settings.json`

### 4. 验证集成
```bash
claude --print "Do you have access to the Augment codebase retrieval tool? Answer in one sentence."
```

## 🔧 配置详情

### MCP 服务器配置
```json
{
  "mcpServers": {
    "auggie": {
      "command": "auggie",
      "args": ["--mcp", "--mcp-auto-workspace"],
      "env": {}
    }
  }
}
```

### 参数说明
- `--mcp`: 启用 MCP 服务器模式
- `--mcp-auto-workspace`: 自动检测当前工作区作为搜索范围

## 🚀 使用方式

### 在 Claude Code 中使用
一旦配置完成，Claude Code 会自动启动 Augment MCP 服务器。你可以直接使用以下工具：

- `mcp__auggie__codebase-retrieval`: 语义化代码搜索工具

### 示例查询
```
"在代码库中找到处理用户认证的函数"
"查找所有测试文件"
"这个项目如何连接数据库？"
```

## 🔍 检查状态

### 查看 MCP 服务器列表
```bash
claude mcp list
```

### 查看登录状态
```bash
auggie account
```

### 检查会话文件
```bash
cat ~/.augment/session.json
```

## 🛠️ 维护

### 重新登录
如果 session 过期：
```bash
auggie logout
auggie login
```

### 更新 Auggie CLI
```bash
npm update -g @augmentcode/auggie
```

### 移除 MCP 配置
```bash
claude mcp remove auggie
```

## 📝 注意事项

1. **会话持久化**：auggie 的登录会话会自动保存，无需每次重新登录
2. **自动启动**：Claude Code 启动时会自动启动配置的 MCP 服务器
3. **工作区自动检测**：使用 `--mcp-auto-workspace` 参数，会自动将当前目录作为搜索范围
4. **作用域**：使用 `--scope user` 配置，所有项目都可以使用此 MCP

## 🎯 固化流程总结

配置完成后，流程已完全固化：

1. ✅ Auggie CLI 已全局安装
2. ✅ Augment 账号已登录（会话持久保存）
3. ✅ MCP 配置已添加到用户级别
4. ✅ Claude Code 启动时自动加载 MCP 服务器

**无需任何手动操作，每次使用 Claude Code 都会自动可用 Augment Context Engine！**

## 📚 相关链接

- [Augment 官方文档](https://docs.augmentcode.com)
- [Claude Code MCP 文档](https://github.com/anthropics/claude-code)

---
配置时间：2026-02-07
最后更新：2026-02-07
