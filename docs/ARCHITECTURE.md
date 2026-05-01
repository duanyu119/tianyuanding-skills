# 架构文档 / Architecture

[中文](#中文) | [English](#english)

---

<a name="中文"></a>
## 中文

### 核心隐喻：天元鼎

《哪吒之魔童闹海》中，天元鼎是一座巨型炼丹炉——散落各处的小妖怪被投入其中，经过淬炼变成标准化的仙丹。

你的信息流就是那些小妖怪：一封邮件里埋在第 31 页的一句措辞变更，一段两小时会议录音里散落的十几个关键判断，一份审计报告里和上次差了 3% 的数字。单独看没什么用，格式不统一，散落各处。

天元鼎（本系统）的作用：把这些杂乱原材料吃进去，经过结构化提取、信源标注、交叉验证、冲突检测，输出干净可靠的"仙丹"——即结构化事实。

### 四层架构

```
┌─────────────────────────────────────────────┐
│           消费层（任何 AI 工具）               │
│    Claude / ChatGPT / Gemini / 未来工具       │
└──────────────────────┬──────────────────────┘
                       │ 读取
┌──────────────────────▼──────────────────────┐
│         03_baseline（知识层 / 仙丹成品库）      │
│  经审批的结构化事实 · 带信源 · 带时间戳 · 可审计  │
└──────────────────────┬──────────────────────┘
                       │ proposal 审批
┌──────────────────────▼──────────────────────┐
│         02_synthesis（加工层 / 炼丹车间）       │
│  AI 生成的分析、备忘、对标报告 · 可覆盖         │
└──────────────────────┬──────────────────────┘
                       │ AI 提取
┌──────────────────────▼──────────────────────┐
│         01_raw（原料层 / 妖怪收容所）           │
│  原始文件 · 永不修改 · 完整证据链               │
└─────────────────────────────────────────────┘
```

### 层间关系

| 层 | 可写入 | 可修改 | 可删除 | 核心约束 |
|----|--------|--------|--------|---------|
| 01_raw | 只增不改 | 禁止 | 禁止 | 一旦入库永不动 |
| 02_synthesis | AI 自由写 | AI 自由改 | 可以 | 工作产物，非真相 |
| 03_baseline | 仅 proposal | 仅批准后 | 仅批准后 | 唯一事实来源 |
| 00_system | AI 可写 | AI 可改 | 慎重 | 治理规则 |

### Proposal 机制

```
AI 发现需更新 baseline
       ↓
在 99_workspace/baseline_proposals/ 创建 proposal
       ↓
用户 review（可合并/修改/拒绝）
       ↓
用户说 "approve <id>"
       ↓
写入 03_baseline/ + 归档到 02_synthesis/_approved_proposals/
```

为什么不让 AI 直接写？**因为错误事实比空白的破坏性大 100 倍。** AI 可能误读、过度推断、混淆信源。一旦错误事实进入 baseline，所有基于它的后续决策都被污染。

### Tier 分层（维护频率）

| Tier | 频率 | 过期标准 | 适用内容 |
|------|------|---------|---------|
| T1 | 每周 | 7天 | 当前主推项目、紧急决策 |
| T2 | 每月 | 30天 | 财务、团队、战略 |
| T3 | 每季 | 90天 | 投资 thesis、长期目标 |
| T4 | 每年 | 365天 | 身份、家庭规划 |

分层的意义：**不需要维护所有事实**。T1 保持鲜活，T4 一年看一次就够。把精力集中在高频变化的领域。

### 判断标注

Baseline 同时承载事实和判断。区分方式：

- 事实：`[源: 01_raw/2026-01-15_report.pdf]` — 可溯源验证
- 判断：`[判断: 张总, high]` — 标注谁说的、多确定

这让你在 6 个月后能回溯："当时这个结论是基于什么判断？那个判断还成立吗？"

### 为什么选 markdown + git

| 特性 | 价值 |
|------|------|
| markdown | 人和 AI 都能读的最大公约数 |
| 本地文件 | 不依赖任何云服务，20 年后还能打开 |
| git | 历史快照 + 变更追溯 + 意外恢复 |
| 厂商无关 | 今天 Claude，明天 GPT，后天随便什么 |

---

<a name="english"></a>
## English

### Core Metaphor: The Celestial Cauldron

In *Ne Zha 2*, the TianYuanDing is a massive alchemical cauldron — scattered imps are thrown in and refined into standardized elixir pills.

Your information flow is those imps: a wording change buried on page 31 of a lawyer's email, a dozen key judgments scattered across a 2-hour meeting transcript, a number that's off by 3% from the last audit report. Individually useless, scattered everywhere, no common format.

The TianYuanDing (this system) takes these chaotic raw materials, runs them through structured extraction, source annotation, cross-validation, and conflict detection, and outputs clean, reliable "elixir pills" — structured facts.

### Four-Layer Architecture

```
┌─────────────────────────────────────────────┐
│         Consumer Layer (Any AI Tool)          │
│    Claude / ChatGPT / Gemini / Future tools   │
└──────────────────────┬──────────────────────┘
                       │ reads
┌──────────────────────▼──────────────────────┐
│      03_baseline (Knowledge / Elixir Vault)   │
│  Approved structured facts · sourced · dated  │
└──────────────────────┬──────────────────────┘
                       │ proposal approval
┌──────────────────────▼──────────────────────┐
│    02_synthesis (Processing / Alchemy Workshop)│
│  AI-generated analysis · overwritable          │
└──────────────────────┬──────────────────────┘
                       │ AI extraction
┌──────────────────────▼──────────────────────┐
│        01_raw (Raw Layer / Imp Storage)        │
│  Original files · immutable · evidence chain   │
└─────────────────────────────────────────────┘
```

### Why markdown + git

| Feature | Value |
|---------|-------|
| markdown | Lowest common denominator readable by humans and AI |
| local files | No cloud dependency, still works in 20 years |
| git | History snapshots + change tracking + disaster recovery |
| vendor-agnostic | Claude today, GPT tomorrow, anything next year |

### Proposal Mechanism

AI cannot write directly to `03_baseline/`. All changes go through a proposal → review → approve flow. Because **wrong facts are 100x more destructive than blanks**.

### Tier System

| Tier | Cadence | Stale after | Content type |
|------|---------|-------------|-------------|
| T1 | Weekly | 7 days | Active projects, urgent decisions |
| T2 | Monthly | 30 days | Finance, team, strategy |
| T3 | Quarterly | 90 days | Investment thesis, long-term goals |
| T4 | Annual | 365 days | Identity, family, life planning |
