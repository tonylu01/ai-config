#!/bin/bash

# Auggie 健康检查脚本
# 检查 auggie 登录状态，如果未登录则提示

set -euo pipefail

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔍 检查 Auggie 状态..."

# 检查 auggie 是否已安装
if ! command -v auggie &> /dev/null; then
    echo -e "${RED}❌ Auggie CLI 未安装${NC}"
    echo "请运行: npm install -g @augmentcode/auggie@latest"
    exit 1
fi

echo -e "${GREEN}✓ Auggie CLI 已安装${NC}"
auggie --version

# 检查登录状态
if [ -f ~/.augment/session.json ] && [ -s ~/.augment/session.json ]; then
    echo -e "${GREEN}✓ Auggie 已登录${NC}"

    # 尝试验证会话是否有效
    if auggie account &> /dev/null; then
        echo -e "${GREEN}✓ 会话有效${NC}"
    else
        echo -e "${YELLOW}⚠️  会话可能已过期${NC}"
        echo "请运行: auggie login"
        exit 1
    fi
else
    echo -e "${RED}❌ Auggie 未登录${NC}"
    echo "请运行: auggie login"
    exit 1
fi

# 检查 MCP 配置
echo ""
echo "🔧 检查 Claude Code MCP 配置..."
if claude mcp list | grep -q "auggie"; then
    echo -e "${GREEN}✓ Auggie MCP 已配置${NC}"
else
    echo -e "${YELLOW}⚠️  Auggie MCP 未配置${NC}"
    echo "请运行: claude mcp add-json auggie --scope user '{\"type\":\"stdio\",\"command\":\"auggie\",\"args\":[\"--mcp\",\"--mcp-auto-workspace\"]}'"
    exit 1
fi

echo ""
echo -e "${GREEN}🎉 所有检查通过！Augment Context Engine 已就绪。${NC}"
