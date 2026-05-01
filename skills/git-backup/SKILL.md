# Git Backup Skill

定时自动 commit + push 到 GitHub 私仓。防丢失安全网。

## 触发条件

- 定时任务每周五 22:00 触发
- 用户手动说"backup"、"push"、"备份"

## 前置条件

1. 知识库目录已 `git init`
2. GitHub 私仓已创建并设为 remote
3. PAT 已存入系统 Keychain（不要明文存储）

## 执行脚本

```python
#!/usr/bin/env python3
"""
天元鼎 — 自动 Git 备份脚本
用法：python3 git_backup.py /path/to/your/brain
"""

import subprocess
import sys
import os
from datetime import datetime

def run(cmd, cwd=None):
    result = subprocess.run(cmd, shell=True, cwd=cwd, 
                          capture_output=True, text=True)
    return result.returncode, result.stdout.strip(), result.stderr.strip()

def main():
    if len(sys.argv) < 2:
        print("用法: python3 git_backup.py /path/to/your/brain")
        sys.exit(1)
    
    brain_path = sys.argv[1]
    
    if not os.path.isdir(os.path.join(brain_path, '.git')):
        print(f"错误: {brain_path} 不是 git 仓库")
        sys.exit(1)
    
    # Step 1: Check status
    code, out, _ = run("git status --short", cwd=brain_path)
    if not out:
        print("✅ 无变更，跳过")
        sys.exit(0)
    
    # Step 2: Add all changes
    run("git add -A", cwd=brain_path)
    
    # Step 3: Commit
    date_str = datetime.now().strftime("%Y-%m-%d %H:%M")
    msg = f"auto-backup: {date_str}"
    code, out, err = run(f'git commit -m "{msg}"', cwd=brain_path)
    if code != 0:
        print(f"⚠️ commit 失败: {err}")
        sys.exit(1)
    print(f"✅ committed: {msg}")
    
    # Step 4: Push
    code, out, err = run("git push origin main", cwd=brain_path)
    if code == 0:
        print("✅ push 成功")
    else:
        print(f"❌ push 失败: {err}")
        # Retry once
        code, out, err = run("git push origin main", cwd=brain_path)
        if code == 0:
            print("✅ 重试 push 成功")
        else:
            print(f"❌ 重试仍失败，请手动检查网络或凭证")
            sys.exit(1)

if __name__ == "__main__":
    main()
```

## macOS 定时任务配置

### 方案 A：Cowork Scheduled Task

```json
{
  "name": "git-backup",
  "schedule": "0 22 * * 5",
  "description": "每周五自动 Git 备份"
}
```

### 方案 B：macOS LaunchAgent（不依赖 Cowork）

创建 `~/Library/LaunchAgents/com.tianyuanding.backup.plist`：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.tianyuanding.backup</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python3</string>
        <string>/path/to/git_backup.py</string>
        <string>/path/to/your/brain</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Weekday</key>
        <integer>5</integer>
        <key>Hour</key>
        <integer>22</integer>
    </dict>
</dict>
</plist>
```

加载：`launchctl load ~/Library/LaunchAgents/com.tianyuanding.backup.plist`

## 安全提醒

- **PAT 不要明文存在知识库目录内**（用 Keychain 或密码管理器）
- 在 `.gitignore` 中排除：`*.pat`、`*.token`、`*credential*`
- 仓库必须是**私仓**（你的知识库不该公开）
