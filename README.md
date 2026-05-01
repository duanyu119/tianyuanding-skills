# 天元鼎 TianYuanDing

> 把散落的信息"小妖怪"炼成结构化的"仙丹"——一套面向严肃业务工作者的 AI 私人知识系统框架。

---

## 这是什么

天元鼎是一个**可 fork 的个人知识系统模板 + 自动化 Skills 工具包**，帮助你搭建自己的私人事实数据库，让任何 AI 工具（Claude、ChatGPT、Gemini……）都能基于你的真实上下文工作。

灵感来自《哪吒之魔童闹海》中的天元鼎——各路小妖怪（散乱信息）被投入鼎中，炼化为标准化、高纯度的仙丹（结构化事实）。

**适合谁用：** 做分析文档、长周期项目管理、投资决策、跨领域权衡的人——你的痛点不是 AI 不够聪明，而是 AI 不记得事。

**不适合谁：** 如果你只需要 AI 帮你写邮件、做 PPT、生成图片——你不需要这个系统。

## 核心理念

```
信号海洋 → [手动筛选] → 妖怪收容所(01_raw) → [AI加工] → 炼丹车间(02_synthesis)
                                                              ↓
                                              [人工审批] → 仙丹成品库(03_baseline)
                                                              ↓
                                              [任何AI调用] → 消费层(AI工具)
```

三条铁律：
1. **原料不可篡改** — `01_raw/` 永不修改，保留完整证据链
2. **事实需审批写入** — `03_baseline/` 的每次变更必须本人确认
3. **AI 是工具不是主人** — AI 帮你烧火炼丹，但决定哪颗仙丹能出炉的是你

## 项目结构

```
天元鼎.skills/
├── README.md              ← 你在这里（中文）
├── README_EN.md           ← English version
├── template/              ← 四层目录模板（fork 后填你自己的内容）
│   ├── 00_system/         ← 系统治理规则
│   ├── 01_raw/            ← 原料层（永不修改）
│   ├── 02_synthesis/      ← 加工层（AI 工作产物）
│   ├── 03_baseline/       ← 知识层（核心：经审批的事实）
│   └── 99_workspace/      ← 临时工作区
├── skills/                ← Cowork 自动化 Skills（可直接安装）
│   ├── daily-brief/       ← 每日晨间提要
│   ├── weekly-sweep/      ← 每周维护扫描
│   ├── monthly-audit/     ← 每月深度审计
│   ├── git-backup/        ← 定时 Git 备份
│   └── dreaming/          ← 夜间回顾与记忆沉淀
└── docs/                  ← 架构文档
    ├── ARCHITECTURE.md    ← 四层架构详解
    ├── SETUP.md           ← 安装与配置指南
    └── FAQ.md             ← 常见问题
```

## 快速开始

### 1. Fork 并 clone

```bash
git clone https://github.com/duanyu119/tianyuanding-skills.git my-brain
cd my-brain
```

### 2. 初始化你的知识库

```bash
cp -r template/ ~/Documents/MyBrain/
cd ~/Documents/MyBrain/
git init && git add . && git commit -m "init: 天元鼎骨架"
```

### 3. 配置 AI 项目指令

把 `template/00_system/PROJECT_INSTRUCTIONS.md` 的内容复制到你的 AI 工具的项目设置中（Claude Desktop → Settings → Projects → 选择文件夹 → Project Instructions）。

### 4. 安装 Skills（可选）

将 `skills/` 下的文件夹复制到你的 Cowork skills 目录：

```bash
cp -r skills/* ~/.claude/skills/
```

### 5. 开始使用

从一个子领域开始。不要一次铺开所有领域。建议顺序：
1. 选一个你最痛的主题（比如：一个正在进行的复杂项目）
2. 扔 3-5 个相关原始文件到 `01_raw/`
3. 让 AI 帮你做第一次结构化提取
4. 审批后写入 `03_baseline/`
5. 跑通一轮 daily brief，体验效果

## 设计原则

| 原则 | 解释 |
|------|------|
| 本地优先 | 数据物理存在你自己的电脑上，不依赖任何云服务 |
| 厂商无关 | markdown + git，今天给 Claude 用，明天给 GPT 用都行 |
| 人在回路 | AI 提建议，人做决策。错误事实比空白破坏性大 100 倍 |
| 朴素稳定 | 不用 fancy 工具，20 年后还能打开 |
| 渐进式 | 先跑通一个子领域，再扩展。完美主义是最大的敌人 |
| 可审计 | 所有变更有历史，可回滚、可追溯 |

## 四层架构概述

详见 [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

| 层 | 目录 | AI 可写 | 人需审批 | 核心作用 |
|----|------|---------|----------|----------|
| 原料层 | `01_raw/` | 禁止 | — | 原始证据，永不修改 |
| 加工层 | `02_synthesis/` | 是 | 否 | AI 工作产物，可覆盖 |
| 知识层 | `03_baseline/` | 仅通过 proposal | 是 | 经审批的结构化事实 |
| 治理层 | `00_system/` | 是 | 否 | 系统规则和状态 |

## 维护节律

| 频率 | 耗时 | 做什么 | 对应 Skill |
|------|------|--------|-----------|
| 每天 | 5 分钟 | 读 daily brief，决定是否更新 | `daily-brief` |
| 每周 | 30 分钟 | 过期字段、新增原料、一致性检查 | `weekly-sweep` |
| 每月 | 1-2 小时 | 覆盖率、置信度审计、频率调整 | `monthly-audit` |
| 每季 | 半天 | 战略 review，架构调整 | 手动 |

## 与其他方案的区别

| 维度 | 天元鼎 | Notion/Obsidian | AI Memory | RAG 向量库 |
|------|--------|-----------------|-----------|-----------|
| 数据归属 | 本地文件，你拥有 | 云端/本地 | 锁在平台 | 需要基础设施 |
| AI 可读性 | 原生 markdown | 需 API/导出 | 不可导出 | 需要 embedding |
| 可审计 | git 完整历史 | 有限版本 | 无 | 无 |
| 维护成本 | 低（纯文本） | 中 | 零（但不可控） | 高 |
| 适合场景 | 严肃业务决策 | 个人笔记 | 聊天体验 | 大规模检索 |

## 许可证

MIT License — 自由使用、修改、分发。

## 致谢

本项目方法论受以下启发：PARA 方法（Tiago Forte）、Zettelkasten、审计学的"定期对账"逻辑、以及《哪吒之魔童闹海》的天元鼎。

---

> "炉子可以换，但你的原料库和炼丹手艺是带得走的。"
