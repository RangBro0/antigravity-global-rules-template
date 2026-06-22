---
name: SKILL_C_project_context_management
description: Guidelines for managing project-specific context using local files instead of bloating the global MEM0 graph.
trigger: always_on
---

# Project Context Isolation and Efficiency Guidelines

# [Global Graph vs Local Context Division]
- **Minimal Global Metadata**: Only store high-level metadata (project name, core purpose, primary repository URL, active local folder path) in the global MEM0 memory graph.
- **Detailed Local Context**: Keep all low-level detailed context inside the project's root folder using standard files:
  - `README.md`: Overall project specifications, architecture, APIs, and manual setup.
  - `.antigravity/context.json` (optional): Technical details (exact node/npm versions, local ports, database tables, build scripts, current tasks) designed specifically for agent consumption.

# [Context Loading Rules]
- **Proactive Context Scanning**: When starting work on a specific project directory, the agent must search for and read the local `README.md` or `.antigravity/context.json` before performing other tasks.
- **Session-bound Context**: Load detailed project parameters into the current conversation session memory only. Do not persist deep local details to the global MEM0 graph.
- **Context Refresh**: Update the local project context files (`README.md` or `.antigravity/context.json`) whenever significant structural changes (e.g., adding database columns, changing API routes) are made to the project.
