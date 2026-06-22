---
name: SKILL_C_memory_management
description: Guidelines for proactive memory updates (MEM0) and handling memory conflicts or GC.
trigger: always_on
---

# MEM0 Memory Management and Proactive Learning Guidelines

# [Proactive Memory Update Rules]
- **Detect Learnable Context**: Actively monitor the conversation for long-term valuable facts, such as:
  - User's local system paths, active project paths, and environment preferences.
  - Active programming languages, preferred libraries, or databases for a project.
  - User's working style preferences (e.g., Concise Mode preference).
- **Proactive Registration**: When a new learnable fact is identified, immediately call `add_observations` or `create_entities` to persist it in the memory graph. Do not wait for the user to explicitly ask to save it.
- **Entity Name Standardization**: Always use standardized, clean, and unique entity names to prevent disconnected duplicate nodes (e.g., use "Google Drive Share" instead of "G Drive share" or "GDrive").

# [Information Conflict Prevention and Garbage Collection]
- **Conflict Detection**: Before adding a new observation, review the existing observations of the target entity using `read_graph` or `search_nodes`.
- **Active Pruning**: If a new observation conflicts with or supersedes an old one (e.g., port changes from 8000 to 3000, library upgrades, path changes), call `delete_observations` to remove the outdated observation before adding the new one.
- **Database Consistency**: Keep the memory graph synced with the SQLite database schemas. If a project-specific database schema changes, ensure the corresponding high-level metadata in the memory graph is updated.
