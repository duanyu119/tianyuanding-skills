# Daily Brief Skill

每日晨间提要生成器。扫描知识系统状态，输出当天需要关注的事项。

## 触发条件

- 定时任务每日早 7:00 触发
- 用户手动说"daily brief"、"今日提要"、"晨间 brief"

## 执行步骤

1. 读取 `00_system/generated/SYSTEM_STATUS.md`，判断系统状态
2. 读取 `03_baseline/INDEX.md`，获取所有 T1 文件列表
3. 逐个检查 T1 文件的 `next_review` 和 `last_updated` 字段
4. 扫描 `99_workspace/baseline_proposals/` 有无待审批 proposal
5. 检查 `02_synthesis/_daily/` 最近一次 brief 日期（避免重复生成）

## 输出结构

生成文件：`02_synthesis/_daily/YYYY-MM-DD_daily_brief.md`

```markdown
# Daily Brief — YYYY-MM-DD

## 系统状态

[green/yellow/red] — [原因]

## 今日关键

- [从 T1 baseline 提取的今日关键日期、截止时间、待办]

## 过期告警

- [last_updated 超过 tier 标准的文件列表]

## 待审批 Proposal

- [列出 99_workspace/baseline_proposals/ 中的 draft]

## 跨域提醒

- [如果发现跨文件矛盾或关联，在此提示]

## 建议动作

1. [最高优先级动作]
2. [次优先级]
```

## 配置

在 Cowork scheduled tasks 中创建：

```json
{
  "name": "daily-brief",
  "schedule": "0 7 * * *",
  "description": "生成每日晨间提要"
}
```

## 注意事项

- Brief 是建议层，不会修改任何 baseline 文件
- 如果发现口径矛盾，标注但不自动解决
- 如果系统 status 为 red，brief 首行必须醒目告知
