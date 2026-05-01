# 安装指南 / Setup Guide

[中文](#中文) | [English](#english)

---

<a name="中文"></a>
## 中文

### 前置条件

- macOS / Windows / Linux
- Git 已安装（`git --version`）
- 一个 AI 工具（Claude Desktop 推荐，但非必须）
- GitHub 账号（用于备份，可选）

### Step 1：创建知识库

```bash
# 从模板创建
git clone https://github.com/duanyu119/tianyuanding-skills.git
cp -r tianyuanding-skills/template ~/Documents/MyBrain
cd ~/Documents/MyBrain
git init
git add .
git commit -m "init: 天元鼎骨架"
```

### Step 2：配置 AI 项目指令

1. 打开 Claude Desktop
2. Settings → Projects
3. 添加 `~/Documents/MyBrain` 文件夹
4. 在 Project Instructions 中粘贴 `00_system/PROJECT_INSTRUCTIONS.md` 的内容
5. 根据你的实际情况修改 `[占位符]`

### Step 3：开始第一个子领域

**不要一次铺开所有领域。** 选一个最痛的主题开始。

1. 在 `03_baseline/` 创建你的第一个 baseline 文件：

```bash
touch 03_baseline/my-project.md
```

2. 扔 3-5 个相关原始文件到 `01_raw/`：

```bash
cp ~/Downloads/project-proposal.pdf 01_raw/2026-05-01_团队_产品提案.pdf
cp ~/Downloads/meeting-notes.md 01_raw/2026-05-01_会议_产品评审.md
```

3. 让 AI 帮你做第一次结构化提取：

> "请读取 01_raw/ 中最新的两个文件，从中提炼结构化事实，生成 proposal 供我审批。"

4. 审批后写入 baseline。

### Step 4：配置 Git 备份（可选但强烈推荐）

1. 在 GitHub 创建**私仓**
2. 生成 Fine-grained PAT（需要 Contents: Read and write 权限）
3. 将 PAT 存入系统 Keychain（不要明文存储）：

```bash
# macOS
git credential-store --file ~/.git-credentials store <<EOF
protocol=https
host=github.com
username=YOUR_USERNAME
password=YOUR_PAT
EOF
```

4. 配置 remote：

```bash
cd ~/Documents/MyBrain
git remote add origin https://github.com/YOUR_USERNAME/my-brain.git
git push -u origin main
```

5. （可选）设置定时备份——参见 `skills/git-backup/SKILL.md`

### Step 5：安装 Skills（可选）

如果你使用 Claude Desktop Cowork：

```bash
cp -r tianyuanding-skills/skills/* ~/.claude/skills/
```

然后在 Cowork 中创建 scheduled tasks：
- daily-brief: `0 7 * * *`
- weekly-sweep: `0 21 * * 0`
- monthly-audit: `0 20 24-31 * 0`
- git-backup: `0 22 * * 5`

### Step 6：运行第一次 Daily Brief

在 AI 对话中说：

> "请按 daily-brief skill 的格式，生成今天的晨间提要。"

验证它能读到你的 baseline 文件并生成有意义的 brief。

---

### 常见问题

**Q：不用 Claude 可以吗？**
A：完全可以。核心是 markdown 文件结构，任何 AI 都能读。只是 Skills 自动化部分是为 Claude Cowork 设计的。

**Q：一定要 git 吗？**
A：不强制。但强烈推荐。没有 git 你就没有历史快照和回滚能力。对严肃业务来说，这是底线。

**Q：文件放 iCloud/OneDrive/Dropbox 行吗？**
A：可以。本地文件夹放哪个云盘同步都行。但 `.git` 目录建议放在云盘之外（避免同步冲突）。

**Q：多久能见效？**
A：第一周就能感受到差异——AI 基于你的 baseline 回答问题时，质量会显著提升。但维护节律需要 2-3 周养成习惯。

---

<a name="english"></a>
## English

### Prerequisites

- macOS / Windows / Linux
- Git installed (`git --version`)
- An AI tool (Claude Desktop recommended, not required)
- GitHub account (for backup, optional)

### Step 1: Create your knowledge base

```bash
git clone https://github.com/duanyu119/tianyuanding-skills.git
cp -r tianyuanding-skills/template ~/Documents/MyBrain
cd ~/Documents/MyBrain
git init && git add . && git commit -m "init: TianYuanDing skeleton"
```

### Step 2: Configure AI project instructions

1. Open Claude Desktop → Settings → Projects
2. Add `~/Documents/MyBrain` folder
3. Paste content from `00_system/PROJECT_INSTRUCTIONS.md` into Project Instructions
4. Customize the `[placeholders]` for your situation

### Step 3: Start with ONE domain

Pick your most painful topic. Drop 3-5 raw files into `01_raw/`. Ask AI to extract structured facts. Approve and write to baseline.

### Step 4: Git backup (optional but recommended)

Create a private GitHub repo, store PAT in system Keychain, configure remote, push.

### Step 5: Install Skills (optional)

Copy `skills/*` to `~/.claude/skills/` if using Claude Cowork.

### Step 6: Run first Daily Brief

Ask AI: "Generate today's daily brief based on the daily-brief skill format."

Verify it reads your baseline and produces meaningful output.
