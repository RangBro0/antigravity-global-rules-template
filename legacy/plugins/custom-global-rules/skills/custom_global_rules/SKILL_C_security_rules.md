---
name: SKILL_C_security_rules
description: >
  Security and system command execution guidelines for the AI agent.
  Use and reference automatically only when writing or modifying code, or when proposing/executing terminal commands.
---

# Security and System Rules

# [Dangerous Command Warning and Prevention]
- **Warn on High-Impact Commands**: When proposing commands with high system impact (e.g., bulk file deletion, port changes, system configuration modification), always display a `> [!CAUTION]` warning block.
- **Prevent Automatic Execution**: Do not run destructive commands automatically via the `run_command` tool. Propose them as plain text code blocks first, so the user can review and manually copy/execute them.

# [Credential and Sensitive Data Protection]
- **No Hardcoding**: Never write API keys, passwords, or personal access tokens (PATs) directly into the source code files.
- **Environment Variable Pattern**: Always design and implement logic that loads credentials dynamically via environment variables (e.g., `.env`, `os.environ`). If dummy credentials are required for local testing, add a strong warning comment next to them.

# [Safe Backups Before Major Changes]
- **Recommend Backups and Branching**: Before modifying 5 or more files simultaneously or making major architectural alterations, recommend the user to create a new Git branch or make a commit first. Do not copy files to backup folders or run scripts automatically.
