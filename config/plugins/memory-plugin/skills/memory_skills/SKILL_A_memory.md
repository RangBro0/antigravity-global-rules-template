---
name: SKILL_A_memory
description: >
  Guidelines and instructions for using the tools exposed by the memory MCP server.
  Automatically loaded when performing tasks related to memory.
---

# SKILL_A_memory (MCP Tools Guide)

This skill document details the tools, parameters, and guidelines for using the `memory` Model Context Protocol (MCP) server within Antigravity.

## Available Tools

### `mcp_memory_add_observations` (or call_mcp_tool with ServerName: 'memory', ToolName: 'add_observations')
- **Description**: Add new observations to existing entities in the knowledge graph
- **Parameters**:
  - `observations` (array, Required): 

### `mcp_memory_create_entities` (or call_mcp_tool with ServerName: 'memory', ToolName: 'create_entities')
- **Description**: Create multiple new entities in the knowledge graph
- **Parameters**:
  - `entities` (array, Required): 

### `mcp_memory_create_relations` (or call_mcp_tool with ServerName: 'memory', ToolName: 'create_relations')
- **Description**: Create multiple new relations between entities in the knowledge graph. Relations should be in active voice
- **Parameters**:
  - `relations` (array, Required): 

### `mcp_memory_delete_entities` (or call_mcp_tool with ServerName: 'memory', ToolName: 'delete_entities')
- **Description**: Delete multiple entities and their associated relations from the knowledge graph
- **Parameters**:
  - `entityNames` (array, Required): An array of entity names to delete

### `mcp_memory_delete_observations` (or call_mcp_tool with ServerName: 'memory', ToolName: 'delete_observations')
- **Description**: Delete specific observations from entities in the knowledge graph
- **Parameters**:
  - `deletions` (array, Required): 

### `mcp_memory_delete_relations` (or call_mcp_tool with ServerName: 'memory', ToolName: 'delete_relations')
- **Description**: Delete multiple relations from the knowledge graph
- **Parameters**:
  - `relations` (array, Required): An array of relations to delete

### `mcp_memory_open_nodes` (or call_mcp_tool with ServerName: 'memory', ToolName: 'open_nodes')
- **Description**: Open specific nodes in the knowledge graph by their names
- **Parameters**:
  - `names` (array, Required): An array of entity names to retrieve

### `mcp_memory_read_graph` (or call_mcp_tool with ServerName: 'memory', ToolName: 'read_graph')
- **Description**: Read the entire knowledge graph
- **Parameters**: None

### `mcp_memory_search_nodes` (or call_mcp_tool with ServerName: 'memory', ToolName: 'search_nodes')
- **Description**: Search for nodes in the knowledge graph based on a query
- **Parameters**:
  - `query` (string, Required): The search query to match against entity names, types, and observation content

## Best Practices & Guidelines

1. **Verify Parameters**: Double-check parameter names and types before invoking any tool. Missing required properties will cause errors.
2. **Minimize Output Bloat**: If a tool returns a large volume of data (e.g., file contents, search results), do NOT dump the entire payload to stdout. Instead, save the output to the scratch directory (`C:\Users\user\.gemini\antigravity\scratch`) and present only the summary to the user.
3. **Error Resilience**: If a tool call fails, log the error details, self-correct the parameters, and retry up to 3 times before reporting the error to the user.
4. **Security & Governance**: Respect all safety guidelines. Do not perform destructive actions (like deleting branches or repositories) without explicit user approval.
5. **User-Facing Artifacts in Korean**: When presenting artifacts, walkthroughs, or reports derived from these tools to the user, write them in Korean as per user policy.
