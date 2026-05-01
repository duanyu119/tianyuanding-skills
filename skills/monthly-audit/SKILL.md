# Monthly Audit Skill

每月末执行的深度审计。评估整个知识系统的健康度和覆盖率。

## 触发条件

- 定时任务每月最后一个周日 20:00 触发
- 用户手动说"monthly audit"、"月度审计"

## 执行步骤

### Phase 1：覆盖率评估

1. 统计 `03_baseline/` 总文件数和总字段数
2. 统计 `[需补全]` 占比 → baseline 覆盖率 = 已填/(已填+需补全)
3. 统计各 tier 文件数量分布
4. 与上月数据对比（如有历史 audit）

### Phase 2：置信度审计

5. 列出所有 `confidence: L` 或 `[判断: AI, low/speculative]` 的字段
6. 按影响度排序，建议哪些值得补强信源
7. 统计判断主体分布（用户/AI/团队/外部）

### Phase 3：变更频率分析

8. 统计过去 30 天 baseline 各字段变更次数
9. 高频变更字段 → 建议升级 tier（如 T2→T1）
10. 零变更字段 → 建议降级 tier（如 T1→T2）

### Phase 4：架构健康

11. 是否有 baseline 文件缺少 frontmatter
12. 是否有 baseline 文件没有任何 `[源: ...]` 引用
13. `01_raw/` 中有哪些文件从未被任何 baseline 引用

### Phase 5：建议

14. 生成"本月 Top 5 改进建议"
15. 更新 `00_system/generated/SYSTEM_STATUS.md`

## 输出结构

生成文件：`02_synthesis/_weekly/YYYY-MM_monthly_audit.md`

```markdown
# Monthly Audit — YYYY-MM

## 覆盖率

- 总 baseline 文件：X
- 总字段数：Y
- [需补全] 字段：Z
- **覆盖率：XX%**（上月：YY%）

## 置信度分布

| Confidence | 数量 | 占比 |
|-----------|------|------|
| high | ... | ... |
| medium | ... | ... |
| low | ... | ... |

## Tier 调整建议

| 文件 | 当前 Tier | 建议 | 原因 |
|------|----------|------|------|
| ... | T2 | → T1 | 过去 30 天变更 8 次 |

## 未引用原料

- [01_raw 中从未被 baseline 引用的文件列表]

## Top 5 改进建议

1. ...
2. ...
3. ...
4. ...
5. ...
```

## 配置

```json
{
  "name": "monthly-audit",
  "schedule": "0 20 24-31 * 0",
  "description": "每月末深度审计"
}
```
