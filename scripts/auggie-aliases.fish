# Augment MCP 便捷别名 (Fish Shell)
# 将此文件添加到 ~/.config/fish/config.fish：
# source ~/.claude/scripts/auggie-aliases.fish

# Auggie 健康检查
alias auggie-check='~/.claude/scripts/check-auggie-health.sh'

# 快速查看 MCP 状态
alias mcp-status='claude mcp list'

# 重新登录 Auggie
alias auggie-relogin='auggie logout; and auggie login'

# 查看 Auggie 账号
alias auggie-info='auggie account'

# 测试 Augment 集成
alias test-augment='claude --print "Do you have access to the Augment codebase retrieval tool? Answer in one sentence."'

# 打开 Augment 配置文档
alias auggie-docs='cat ~/.claude/AUGMENT_QUICK_REFERENCE.md'

# 打开完整文档
alias auggie-setup='cat ~/.claude/AUGMENT_MCP_SETUP.md'
