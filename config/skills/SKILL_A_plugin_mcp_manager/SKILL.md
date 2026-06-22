---
name: SKILL_A_plugin_mcp_manager
description: Guidelines for managing MCP server connections, custom plugins, and skill synchronization. Use when adding, removing, or syncing MCP tools.
trigger: always_on
---

# SKILL_A_plugin_mcp_manager

This skill guides the agent in managing Model Context Protocol (MCP) servers and packaging them as custom plugins with auto-generated English skill guides (`SKILL.md`).

## Prefix Conventions
- **User-requested custom skills**: Must start with `SKILL_C_` (e.g., `SKILL_C_<name>`).
- **Agent-generated/system skills**: Must start with `SKILL_A_` (e.g., `SKILL_A_plugin_mcp_manager`, `SKILL_A_github`).

## Prerequisites
- Automation script is located at: `%USERPROFILE%\.gemini\antigravity\scratch\mcp_plugin_connector.py`

## Core Commands
Always execute the connector script using python. Run commands from the scratch directory.

1. **Sync all MCP servers to plugins/skills**:
   ```powershell
   python %USERPROFILE%\.gemini\antigravity\scratch\mcp_plugin_connector.py sync
   ```
   *Action*: Scans `mcp_config.json`, reads tool schemas in `%USERPROFILE%\.gemini\antigravity\mcp\<serverName>`, and creates or updates a plugin under `%USERPROFILE%\.gemini\config\plugins\<serverName>-plugin` containing the auto-generated English skill guide named `SKILL_A_<serverName>.md`.

2. **Add or update an MCP server**:
   ```powershell
   python %USERPROFILE%\.gemini\antigravity\scratch\mcp_plugin_connector.py add --name <serverName> --command <command> --args <args...> --env KEY=VALUE KEY2=VALUE2
   ```
   *Action*: Updates `mcp_config.json` and automatically builds/syncs the plugin and skill folders.

3. **Remove an MCP server**:
   ```powershell
   python %USERPROFILE%\.gemini\antigravity\scratch\mcp_plugin_connector.py remove --name <serverName>
   ```
   *Action*: Removes the server configuration from `mcp_config.json`.

4. **List all registered MCP servers**:
   ```powershell
   python %USERPROFILE%\.gemini\antigravity\scratch\mcp_plugin_connector.py list
   ```

## Workflow Guide
- **Auto-Detecting Project Databases**:
  - When starting work in a new workspace or project directory, proactively scan the workspace for SQLite database files (`.db`, `.sqlite`, `.sqlite3`).
  - If a database file is found, proactively ask the user in chat if they would like to register it as a project-specific SQLite MCP server (e.g., `sqlite-<projectName>`) pointing to that file.
- **When user requests adding a new MCP server**:
  1. Determine the necessary executable, arguments, and environment variables (like API keys or paths).
  2. Run the `add` command to add the server and compile its plugins/skills.
  3. Inform the user of the success and explain that the new tools are now active and wrapped with an English skill guide named `SKILL_A_<serverName>`.
- **When updating tool schemas or setting up the environment**:
  - Run the `sync` command to ensure all `SKILL_A_<serverName>.md` documents are rebuilt and kept up-to-date.
- **Enforcing Naming Conventions**:
  - Any plugin created must follow the name format `<serverName>-plugin`.
  - The skill frontmatter inside `<serverName>-plugin/skills/<serverName>_skills/SKILL_A_<serverName>.md` must use `SKILL_A_<serverName>` as the name and must be written entirely in English.
- **Enforcing Output Language**:
  - All user-facing artifacts, progress lists (such as `task.md` or `walkthrough.md`), summaries, and reports generated while executing these skills must be written in **Korean**, regardless of the skill file's internal language (English).
