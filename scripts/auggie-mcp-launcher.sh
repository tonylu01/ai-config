#!/bin/bash

# Auggie MCP 自动启动脚本
# 确保 auggie 已登录并启动 MCP 服务器

set -euo pipefail

# 检查 auggie 是否已登录
check_auggie_login() {
    if [ -f ~/.augment/session.json ]; then
        # 检查 session 文件是否有效（非空且包含有效 JSON）
        if [ -s ~/.augment/session.json ]; then
            return 0
        fi
    fi
    return 1
}

# 如果未登录，记录错误并退出
if ! check_auggie_login; then
    echo "❌ Auggie MCP Error: Not logged in." >&2
    echo "Please run: auggie login" >&2
    exit 1
fi

# 启动 auggie 作为 MCP 服务器（stdio 模式）
# auggie 需要以交互模式运行来提供 MCP 工具
exec auggie --print --dont-save-session 2>&1
