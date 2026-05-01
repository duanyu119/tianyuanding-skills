# FAQ / 常见问题

[中文](#中文) | [English](#english)

---

<a name="中文"></a>
## 中文

### 关于定位

**Q：这和 Obsidian / Notion / Logseq 有什么区别？**

那些是笔记工具，面向个人灵感记录和知识管理。天元鼎面向**严肃业务决策**——核心差异是：(1) 以 AI 消费为设计目标，结构化字段优先于自由叙述；(2) 强调可审计、可回滚、可信源核验；(3) 人在回路，AI 不能自动写入事实层。

**Q：这和 RAG / 向量数据库有什么区别？**

RAG 是"把所有文档扔进去，AI 自动检索"。天元鼎是"人工筛选 + AI 提取 + 人工审批"。RAG 适合海量文档的模糊搜索，天元鼎适合需要精确事实和可审计历史的场景。两者不冲突——你可以在天元鼎的 baseline 之上再加 RAG。

**Q：我不做投资/复杂项目管理，需要这个吗？**

如果你过去 6 个月里"找不到信息"或"信息错了"导致的严重后果少于 3 次——你不需要这个系统。ROI 是负的。

### 关于使用

**Q：我不会用 git 怎么办？**

git 的核心价值是"防丢失保险"。如果你完全不想碰 git，可以用 iCloud / OneDrive 的版本历史作为替代（虽然没有 git 强大）。但如果你做严肃业务，建议花 2 小时学会 `git init / add / commit / push` 这四个命令——AI 可以帮你全程配置。

**Q：baseline 文件要写多细？**

70% 填了就够。不要追求完美。标记 `[需补全]` 比编造要好 100 倍。

**Q：维护太累了怎么办？**

两个建议：(1) 砍 scope——只维护 T1，其他 tier 等你养成习惯后再加；(2) 用 daily brief 自动提醒——让系统推你，而不是靠自觉。

**Q：AI 生成的 proposal 错误率高怎么办？**

正常。这就是为什么有 proposal 机制——AI 错了不要紧，你在审批环节挡住就行。随着 baseline 越来越丰富，AI 的提取质量会提升（因为它有更多上下文参照）。

### 关于安全

**Q：敏感信息怎么处理？**

- 高敏感（合同条款、凭证、密码）：不要放进这个系统。用密码管理器或加密存储。
- 中敏感（项目进度、团队决策）：可以放，但仓库必须是私仓。
- 低敏感（公开信息、行业数据）：随便放。

**Q：iCloud 同步安全吗？**

iCloud 默认不是端到端加密（除非你开了 Advanced Data Protection）。对大多数人够用。如果你对安全性有极高要求，可以用本地加密卷或者不同步到云端。

---

<a name="english"></a>
## English

### About positioning

**Q: How is this different from Obsidian / Notion / Logseq?**

Those are note-taking tools for personal knowledge management. TianYuanDing is for **serious business decisions** — structured fields over free-form notes, auditable history, human-in-the-loop approval.

**Q: How is this different from RAG / vector databases?**

RAG is "dump everything, AI retrieves." TianYuanDing is "human-filtered → AI-extracted → human-approved." They're complementary, not competing.

**Q: Do I need this if I don't do complex project management?**

If "can't find info" or "info was wrong" caused fewer than 3 serious problems in the past 6 months — you probably don't need this.

### About usage

**Q: What if I don't know git?**

You only need 4 commands: `init`, `add`, `commit`, `push`. AI can configure the rest. Or skip git entirely and rely on cloud version history.

**Q: How detailed should baseline files be?**

70% filled is enough. `[needs completion]` markers are better than fabrication.

**Q: What if maintenance feels too heavy?**

(1) Reduce scope — only maintain T1. (2) Let daily brief push you — don't rely on willpower.
