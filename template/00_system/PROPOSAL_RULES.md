# Proposal 规则

## 目的

Baseline 变更应先以 proposal 形式被复核，然后才能进入知识层。

Proposal 机制的目的不是增加摩擦，而是减少打断：AI 可以在工作中收集候选变更，之后按批次请用户批准。

## Proposal 位置

建议队列：`99_workspace/baseline_proposals/`

批准后归档到：`02_synthesis/_approved_proposals/YYYY-MM-DD_<topic>.md`

## 必须创建 Proposal 的情况

- 给 `03_baseline/` 增加、删除或实质改写任何事实
- 修改概率、confidence、风险优先级或策略建议
- 解决互相冲突的事实
- 新增 baseline 文件或改变分类结构

## 不需要 Proposal 的情况

- 错别字、格式清理（不改语义）
- 补充缺失的 `[源: ...]`
- 更新 `00_system/`、`02_synthesis/`
- 在 `99_workspace/` 写草稿

## Proposal 模板

```markdown
---
proposal_id: YYYYMMDD-topic-slug
created_at: YYYY-MM-DD
status: draft
target_files:
  - 03_baseline/path/file.md
change_type: add | update | delete | move
risk_level: low | medium | high
---

# Proposal: <short title>

## 为什么需要这次变更

一段话说明原因。

## 拟写入的变更

列出要新增或修改的精确事实。

## 证据

- [源: 01_raw/...]
- [源: 02_synthesis/...]

## 不确定性

- [需补全] ...

## 批准请求

`approve YYYYMMDD-topic-slug`
```

## 批准语言

明确批准：`approve <id>` / `批准 <id>` / `yes to <id>`

模糊回复（"looks good"、"ok"、"先这样"）→ 必须追问确认。

## 批量批准

低/中风险可合并：`approve batch: <id1>, <id2>, <id3>`

高风险（涉及法律、财务、关键决策）必须单独确认。
