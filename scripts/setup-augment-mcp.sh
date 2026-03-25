#!/bin/bash

# Augment Context Engine MCP - 一键设置脚本
# 用于在新机器或重新配置时快速设置 Augment MCP

set -euo pipefail

echo "🚀 Augment Context Engine MCP 自动配置"
echo "========================================"
echo ""

# 检查 Node.js 和 npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm 未安装，请先安装 Node.js"
    exit 1
fi

# 1. 安装或更新 Auggie CLI
echo "📦 步骤 1/4: 安装/更新 Auggie CLI..."
npm install -g @augmentcode/auggie@latest
echo "✓ Auggie CLI 安装完成"
echo ""

# 2. 检查登录状态
echo "🔐 步骤 2/4: 检查登录状态..."
if [ -f ~/.augment/session.json ] && [ -s ~/.augment/session.json ]; then
    echo "✓ Auggie 已登录"
else
    echo "⚠️  需要登录 Augment"
    echo "请在新窗口中运行: auggie login"
    echo "登录完成后按回车继续..."
    read -r
fi
echo ""

# 3. 配置 MCP 服务器
echo "🔧 步骤 3/4: 配置 Claude Code MCP..."
claude mcp add-json auggie --scope user '{"type":"stdio","command":"auggie","args":["--mcp","--mcp-auto-workspace"]}' || echo "⚠️  MCP 可能已配置"
echo "✓ MCP 配置完成"
echo ""

# 4. 验证配置
echo "🧪 步骤 4/4: 验证配置..."
if claude mcp list | grep -q "auggie"; then
    echo "✓ MCP 配置验证成功"
else
    echo "❌ MCP 配置验证失败"
    exit 1
fi
echo ""

# 5. 测试集成
echo "🎯 测试 Augment 集成..."
claude --print "Do you have access to the Augment codebase retrieval tool? Answer in one sentence." || echo "⚠️  测试失败，请检查配置"
echo ""

echo "✨ 配置完成！"
echo ""
echo "📚 快速参考："
echo "  - 完整文档: cat ~/.claude/AUGMENT_MCP_SETUP.md"
echo "  - 快速参考: cat ~/.claude/AUGMENT_QUICK_REFERENCE.md"
echo "  - 健康检查: ~/.claude/scripts/check-auggie-health.sh"
echo ""
echo "💡 添加别名到你的 shell（可选）："
echo "  Fish: echo 'source ~/.claude/scripts/auggie-aliases.fish' >> ~/.config/fish/config.fish"
echo "  Bash/Zsh: echo 'source ~/.claude/scripts/auggie-aliases.sh' >> ~/.zshrc"
