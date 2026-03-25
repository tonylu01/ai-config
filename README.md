# ai-config

个人 Claude Code 配置文件备份。

## 目录结构

```
.
├── claude.md              # 全局指令（Execution Contract）
├── RTK.md                 # RTK token 优化工具说明
├── settings.json          # Claude Code 设置（hooks、statusline 等）
├── mcp_settings.example.json  # MCP 服务器配置模板（不含真实 token）
├── rules/                 # 行为规则
│   ├── agents.md          # Agent 编排规则
│   ├── coding-style.md
│   ├── development-workflow.md
│   ├── git-workflow.md
│   ├── hooks.md
│   ├── patterns.md
│   ├── performance.md
│   ├── security.md
│   └── testing.md
├── hooks/
│   └── rtk-rewrite.sh     # RTK 命令重写 hook
├── skills/                # 自定义技能
├── scripts/               # 辅助脚本
└── plugins/               # 插件配置
```

## 使用方式

1. 克隆到 `~/.claude`
2. 复制 `mcp_settings.example.json` 为 `mcp_settings.json`，填入真实 token
3. 根据需要调整 `settings.json` 中的路径

## 注意

- `mcp_settings.json` 含真实 token，已加入 `.gitignore`，请勿提交
- `history.jsonl`、`projects/`、`sessions/` 等运行时数据同样被排除
