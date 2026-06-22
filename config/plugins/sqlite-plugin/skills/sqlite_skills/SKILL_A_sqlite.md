---
name: SKILL_A_sqlite
description: >
  Guidelines and instructions for using the tools exposed by the sqlite MCP server.
  Automatically loaded when performing tasks related to sqlite.
---

# SKILL_A_sqlite (MCP Tools Guide)

This skill document details the tools, parameters, and guidelines for using the `sqlite` Model Context Protocol (MCP) server within Antigravity.

## Available Tools

### `mcp_sqlite_append_insight` (or call_mcp_tool with ServerName: 'sqlite', ToolName: 'append_insight')
- **Description**: Add a business insight to the memo
- **Parameters**:
  - `insight` (string, Required): Business insight discovered from data analysis

### `mcp_sqlite_create_table` (or call_mcp_tool with ServerName: 'sqlite', ToolName: 'create_table')
- **Description**: Create a new table in the SQLite database
- **Parameters**:
  - `query` (string, Required): CREATE TABLE SQL statement

### `mcp_sqlite_describe_table` (or call_mcp_tool with ServerName: 'sqlite', ToolName: 'describe_table')
- **Description**: Get the schema information for a specific table
- **Parameters**:
  - `table_name` (string, Required): Name of the table to describe

### `mcp_sqlite_list_tables` (or call_mcp_tool with ServerName: 'sqlite', ToolName: 'list_tables')
- **Description**: List all tables in the SQLite database
- **Parameters**: None

### `mcp_sqlite_read_query` (or call_mcp_tool with ServerName: 'sqlite', ToolName: 'read_query')
- **Description**: Execute a SELECT query on the SQLite database
- **Parameters**:
  - `query` (string, Required): SELECT SQL query to execute

### `mcp_sqlite_write_query` (or call_mcp_tool with ServerName: 'sqlite', ToolName: 'write_query')
- **Description**: Execute an INSERT, UPDATE, or DELETE query on the SQLite database
- **Parameters**:
  - `query` (string, Required): SQL query to execute

## Best Practices & Guidelines

1. **Verify Parameters**: Double-check parameter names and types before invoking any tool. Missing required properties will cause errors.
2. **Minimize Output Bloat**: If a tool returns a large volume of data (e.g., file contents, search results), do NOT dump the entire payload to stdout. Instead, save the output to the scratch directory (`C:\Users\user\.gemini\antigravity\scratch`) and present only the summary to the user.
3. **Error Resilience**: If a tool call fails, log the error details, self-correct the parameters, and retry up to 3 times before reporting the error to the user.
4. **Security & Governance**: Respect all safety guidelines. Do not perform destructive actions (like deleting branches or repositories) without explicit user approval.
5. **User-Facing Artifacts in Korean**: When presenting artifacts, walkthroughs, or reports derived from these tools to the user, write them in Korean as per user policy.
