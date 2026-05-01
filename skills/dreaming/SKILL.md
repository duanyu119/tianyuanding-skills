# Dreaming Skill（夜间回顾与记忆沉淀）

每日收盘时的回顾机制。扫描当天的变化，生成待沉淀的 proposal，不自动写入 baseline。

## 触发条件

- 用户说"dream"、"做梦"、"夜间回顾"、"review yesterday"
- 可配置为每晚定时触发

## 核心原则

**Dream 是建议层，不是事实层。**

Dream 可以做：
- 扫描今天的 raw 增量和 synthesis 新文件
- 生成 baseline proposal 候选
- 识别跨域关联和系统风险
- 推荐最值得用户关注的变更

Dream 不能做（未经用户批准）：
- 写入 `03_baseline/`
- 删除 `01_raw/` 文件
- 改变系统治理规则

## 执行步骤

1. **变更扫描**
   - `01_raw/` 今天新增了什么文件？
   - `02_synthesis/` 今天生成了什么报告？
   - `03_baseline/` 今天有什么被批准的变更？

2. **知识萃取**
   - 从今天的对话中，有哪些事实值得沉淀到 baseline？
   - 有哪些新的规则/偏好应该被系统记住？
   - 有哪些判断被更新或推翻？

3. **风险检测**
   - 新信息是否和现有 baseline 矛盾？
   - 是否有 T1 文件应该被更新但还没动？
   - 跨域是否出现新的关联信号？

4. **输出生成**

## 输出结构

```markdown
# Night Dream — YYYY-MM-DD

## 今日发生了什么

- [新增原料列表]
- [baseline 变更记录]
- [重要对话总结]

## 建议沉淀到 Baseline 的内容

### Proposal 候选 1: [标题]
- 目标文件：03_baseline/...
- 变更内容：...
- 证据：[源: ...]
- 风险等级：low/medium/high

### Proposal 候选 2: [标题]
- ...

## 系统风险

- [矛盾检测结果]
- [过期告警]

## 新规则/偏好候选

- [从今天的交互中识别到的新规则]

## 下一步动作

1. [最重要的事]
2. [次重要]
```

## 与 Proposal 机制的关系

Dream 生成的 proposal 候选存放在 `99_workspace/baseline_proposals/`。
用户第二天（或当晚）review 后，批准的内容通过正常 proposal 流程进入 baseline。

## 配置

```json
{
  "name": "dreaming",
  "schedule": "0 22 * * *",
  "description": "夜间回顾与记忆沉淀"
}
```
