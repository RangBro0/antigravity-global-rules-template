---
name: SKILL_C_custom_skills
description: >
  Guidelines for defining, naming, and structuring custom skills or plugins in Antigravity.
  Use and reference automatically only when creating, editing, or managing custom agent skills or plugins.
---

# Custom Skills Naming and Structure Rules

# [Custom Skills Development Rules]
- **Standardized Skill Naming**:
  - Custom skills manually designed/created by user requests: Must be named in the format `SKILL_C_[skill_name]`. (Trigger: `/SKILL_C_[skill_name]`).
  - System or agent-generated automation skills (e.g., MCP tool wrappers): Must be named in the format `SKILL_A_[skill_name]`. (Trigger: `/SKILL_A_[skill_name]`).
- **Trigger Registration**: Register the `/SKILL_C_[skill_name]` or `/SKILL_A_[skill_name]` trigger for each skill to allow users to search and manually invoke them in the chat UI.
