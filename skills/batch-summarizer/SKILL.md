---
name: batch-summarizer
description: 批量总结书籍、PDF、网页。支持 Gemini/Ollama/SiliconFlow 免费后端，多 Key 轮换，渐进式/Map-Reduce/视觉模式。触发词：总结、summarize、摘要、读书笔记、batch summary。
---

# Batch Summarizer Skill

批量总结书籍和网页的多 Agent 工具，全部使用免费 LLM 后端。

## 脚本位置

```
/Users/luyajun/git_files/trading_strategy/batch_summarizer.py
Python: /opt/miniconda3/envs/myenv/bin/python
依赖: httpx, pdfplumber (已安装)
```

## 架构

```
FetcherAgent (并发获取)     SummarizerAgent (4种模式)     ReportAgent (Markdown + PDF)
URL → Jina Reader           single     — 短文直接塞      每篇 → slug.md + slug.pdf
PDF → pdfplumber             progressive — 顺序滚动压缩    索引 → index.md
ePub → ebooklib              mapreduce  — 并行分块合成
Text → 直接读取              vision     — 逐页发图(Gemini)
```

## 免费后端

| 后端 | 上下文 | 多模态 | 配额 | 环境变量 |
|------|--------|--------|------|---------|
| **gemini** (默认) | 1M tokens | --vision | 15 RPM/key, 多 Key 倍增 | `GEMINI_API_KEY` |
| **ollama** | 取决于模型 | — | 无限 (本地) | — |
| **siliconflow** | ~128K | — | 免费额度 | `SILICONFLOW_API_KEY` |
| **hybrid** | Ollama map + Gemini reduce | --vision | Map 无限, Reduce 15 RPM/key | 两者都需要 |

## 常用命令

```bash
# 总结网页列表
/opt/miniconda3/envs/myenv/bin/python /Users/luyajun/git_files/trading_strategy/batch_summarizer.py \
  --urls <urls.txt> --output <output_dir>

# 总结 PDF 目录
/opt/miniconda3/envs/myenv/bin/python /Users/luyajun/git_files/trading_strategy/batch_summarizer.py \
  --pdfs <dir> --output <output_dir>

# 单个文件
/opt/miniconda3/envs/myenv/bin/python /Users/luyajun/git_files/trading_strategy/batch_summarizer.py \
  --file <file.pdf> --output <output_dir>

# 超长书籍 — 渐进式摘要 (最省配额, 每步 1 次调用)
/opt/miniconda3/envs/myenv/bin/python /Users/luyajun/git_files/trading_strategy/batch_summarizer.py \
  --file <book.pdf> --mode progressive --output <output_dir>

# 多 Key 高吞吐 + Map-Reduce 并行
/opt/miniconda3/envs/myenv/bin/python /Users/luyajun/git_files/trading_strategy/batch_summarizer.py \
  --pdfs <dir> --mode mapreduce --api-key k1,k2,k3 --output <output_dir>

# 混合后端 (Ollama Map 无限量 + Gemini Reduce 高质量)
/opt/miniconda3/envs/myenv/bin/python /Users/luyajun/git_files/trading_strategy/batch_summarizer.py \
  --pdfs <dir> --backend hybrid --ollama-model qwen3:14b --output <output_dir>

# 扫描版 PDF 视觉模式 (Gemini 多模态)
/opt/miniconda3/envs/myenv/bin/python /Users/luyajun/git_files/trading_strategy/batch_summarizer.py \
  --file <scan.pdf> --vision --output <output_dir>

# Ollama 完全离线
/opt/miniconda3/envs/myenv/bin/python /Users/luyajun/git_files/trading_strategy/batch_summarizer.py \
  --pdfs <dir> --backend ollama --model gemma3:12b --output <output_dir>
```

## 多 Key 配置 (突破 Gemini 15 RPM 限制)

```bash
# 方法 A: 逗号分隔
export GEMINI_API_KEY=key1,key2,key3

# 方法 B: 编号变量
export GEMINI_API_KEY=key1
export GEMINI_API_KEY_2=key2
export GEMINI_API_KEY_3=key3

# 方法 C: CLI
--api-key key1,key2,key3
```

N 个 Key = N × 15 RPM, 信号量 = N × 3 并发。

## 摘要模式选择 (--mode)

| 模式 | 适用场景 | API 调用 | 并行 |
|------|---------|---------|------|
| **auto** (默认) | 自动: 短文→single, 长文→progressive | 最优 | 视情况 |
| **single** | 短文/论文/大多数书籍 (<200万字符, ~500页) | 1 次 | 否 |
| **progressive** | 超长书籍, 严格限流 | N+1 次 (顺序) | 否 |
| **mapreduce** | 多 Key 高吞吐, 批量处理 | N+1 次 (并行) | 是 |

> **实战发现**: Gemini Flash 的 1M token 上下文足以一次性装入大多数书籍 (500 页 / ~50 万字符 / ~15 万 tokens)。
> 优先尝试 single 模式，仅在超过 200 万字符时才需要 progressive/mapreduce。

## 摘要风格 (--style)

| 风格 | 说明 |
|------|------|
| **detailed** (默认) | 核心摘要 + 分条要点 + 关键词标签 (中文) |
| **bnotes** | 英文条目笔记, 加粗术语 (cognitivetech 项目验证) |
| **concise** | 300 字以内精简摘要 (中文) |
| **research** | 研究视角: 论点/方法/发现/局限/标签 |
| **analyst** | 专业书籍分析师模式 — 逐章深度分析: 摘要/核心教义/关键引用/案例/行动建议/思维转变/反思问题 + 全书综合 (Reddit 爆款 prompt) |
| **chapter** | 逐章结构化总结 (中文) — 全书主题 + 每章: 核心思想/论据案例/深思问题/关键收获 + 全书总结 |

## 关键特性

- **断点续传**: 自动跳过 output 目录中已有的摘要, `--force` 强制重新处理
- **多格式**: PDF / ePub / TXT / MD / 网页 URL
- **URL 获取**: Jina Reader (免费, 无需 API key)
- **限流保护**: 每个 Key 独立令牌桶 + 429 指数退避
- **安全过滤**: 检测 Gemini 的 safety block 并 warning

## PDF 导出 (--pdf)

添加 `--pdf` 自动将每份摘要转为排版精美的 PDF (XeLaTeX + xeCJK 中文支持)。

```bash
# 总结并同时生成 PDF
/opt/miniconda3/envs/myenv/bin/python /Users/luyajun/git_files/trading_strategy/batch_summarizer.py \
  --file <book.pdf> --style analyst --pdf --output <output_dir>
```

- 需要 `xelatex` (已安装于 /usr/local/bin/xelatex, TinyTeX)
- 自动处理中文、标题层级、加粗、列表
- Markdown → LaTeX 转换内置，无需 pandoc

## 输出格式

```
<output_dir>/
├── index.md              # 索引: 成功/失败列表
├── <slug_1>.md           # 单篇摘要 (含来源、字数、分块数元信息)
├── <slug_1>.pdf          # PDF 版 (--pdf 时生成)
├── <slug_2>.md
└── ...
```

## 自定义 Prompt（超出内置 6 种风格的特殊需求）

内置风格已覆盖大多数场景（含逐章总结）。更特殊的需求可直接用 Python API 调用 Gemini：

```python
import httpx, pdfplumber, asyncio

GEMINI_KEY = "your-key"
URL = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key={GEMINI_KEY}"

def extract_pdf(path):
    with pdfplumber.open(path) as pdf:
        return "\n".join(p.extract_text() or "" for p in pdf.pages)

async def summarize_book(text, custom_prompt):
    async with httpx.AsyncClient(timeout=300) as c:
        r = await c.post(URL, json={
            "contents": [{"parts": [{"text": custom_prompt + "\n\n" + text}]}],
            "generationConfig": {"maxOutputTokens": 32768}
        })
        return r.json()["candidates"][0]["content"]["parts"][0]["text"]

text = extract_pdf("book.pdf")
prompt = "请逐章总结这本书，每章包含：章节名、核心论点、关键实验/案例、结论。用中文。"
result = asyncio.run(summarize_book(text, prompt))
```

> **关键参数**: `maxOutputTokens` 必须设为 **32768**（默认 8192 会在长书总结时截断输出）。

## 决策指南

| 用户需求 | 推荐命令 |
|---------|---------|
| 总结一篇论文 | `--file paper.pdf` (默认 auto+single) |
| 总结一本 500 页的书 | `--file book.pdf --style chapter` (逐章结构化, 中文) |
| 深度书籍分析 (英文风格) | `--file book.pdf --style analyst` (Reddit 爆款 prompt) |
| 读书笔记 + PDF 导出 | `--file book.pdf --style chapter --pdf` |
| 批量总结 20 个 PDF | `--pdfs ./dir/ --mode mapreduce --api-key k1,k2,k3` |
| 完全离线 | `--backend ollama --model gemma3:12b` |
| 扫描版 PDF (无文字层) | `--file scan.pdf --vision` |
| 总结网页列表 | `--urls urls.txt` |
| 最高质量 + 无限量 | `--backend hybrid --ollama-model qwen3:14b` |

## 实战性能基准

| 书籍 | 页数 | 字符数 | ~Token | 风格 | 耗时 | 输出 |
|------|------|--------|--------|------|------|------|
| 思考，快与慢 | 386 | 377K | ~150K | detailed | 98s | 16,920 字 |
| 思考，快与慢 | 386 | 377K | ~150K | chapter | 325s | 49,632 字, 39 页 PDF |

- Gemini 2.5 Flash 的 1M token 上下文可一次性处理大多数书籍
- `maxOutputTokens=32768` 是关键参数，默认 8192 会截断长输出
- 中文书籍 token/字符比约 1:2.5
- chapter/analyst 风格输出更长 (3x)，Gemini 需要更多思考时间 (~325s vs ~98s)
- httpx 超时已设为 600s 以适配大书处理

## 注意事项

- Gemini API Key 免费申请: https://aistudio.google.com/apikey
- `maxOutputTokens` 已设为 32768; 如输出仍被截断, 检查此参数
- 部分网站屏蔽 Jina Reader (如 Investopedia), 会返回 451 错误, 建议换源或本地下载
- Vision 模式需额外安装: `pip install pdf2image` + poppler
- ePub 需额外安装: `pip install ebooklib beautifulsoup4`
- Ollama 需本地安装并运行: https://ollama.com
