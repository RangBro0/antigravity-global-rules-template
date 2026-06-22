---
name: SKILL_C_workflow_skill_creator
description: >
  Distills a completed user workflow, interaction, or resolved bug/solution into a reusable agent skill.
  Use when the user asks, or proactively when you (the agent) resolve a tricky bug or optimize a workflow.
---

# Workflow-to-Skill Distiller

Turns a completed workflow, interaction, or resolved solution into a reusable agent skill.

## Proactive Skill Suggestion (MANDATORY TRIGGER)

When you (the agent) are working on a task and successfully:
1. Identify and resolve a complex, recurring, or tricky bug,
2. Significantly optimize or improve an existing workflow, or
3. Create a useful helper script, utility, or process,

You **MUST** proactively ask the user:
> "I successfully resolved [the bug] / optimized [the workflow] / created [the script]. Would you like to package this solution/workflow into a reusable skill so that I or other agents can easily reuse it in the future?"

If the user agrees, proceed to Phase 1 (Brainstorming).

---

## Phase 1: Brainstorming

> [!IMPORTANT]
> When creating a new custom skill, the agent MUST first open and reference this `SKILL_C_workflow_skill_creator` file along with the global rules file [SKILL_C_custom_skills.md](file:///%USERPROFILE%/.gemini/config/plugins/custom-global-rules/skills/custom_global_rules/SKILL_C_custom_skills.md). Custom skills must be named using the `SKILL_C_[name]` format for user workflows, or `SKILL_A_[name]` for agent automation skills, and must register corresponding slash triggers.

Have a short, iterative conversation with the user to understand:
1. **Purpose & Scope:** What should the skill do? Proposed name?
2. **Inputs & Outputs:** What parameters does it take and what files does it generate?
3. **Dependencies:** Can we reuse existing skills? (Always reuse if possible).
4. **Code vs. Instruction:** 
   - If it involves programmatic work (APIs, file I/O, computations) ➔ CLI Script Pattern.
   - If it is purely reasoning/coordinating existing tools ➔ Instruction-only Pattern.

---

## Phase 2: Skill Design

Produce a design document (as an implementation plan) for user approval:
1. **Skill Name:** Must be named in `SKILL_C_[name]` format for custom workflows, or `SKILL_A_[name]` for agent automation. Follow [SKILL_C_custom_skills.md](file:///%USERPROFILE%/.gemini/config/plugins/custom-global-rules/skills/custom_global_rules/SKILL_C_custom_skills.md) rules.
2. **Call Trigger:** Register a slash trigger like `/SKILL_C_[name]` or `/SKILL_A_[name]` so that the user can easily invoke it.
3. **Directory Structure & Path:** (Default local `.agents/skills/` or global `~/.gemini/config/skills/`).
4. **Subcommands/Arguments:** Clear CLI interface description.
5. **Error & Rate Limiting Strategy:** Respect API guidelines (default 1 req/sec if undocumented).

---

## Phase 3: Implementation Guidelines

- **Use `uv run`:** Never call `python` or `python3` directly.
- **CLI Script Pattern:** Use `argparse` with subcommands. Output must be written to files (JSON format preferred), not stdout, to avoid token bloat and truncation.
- **API Error Handling:** Log retry attempts to stderr. Include response bodies on non-retriable HTTP errors (e.g. 400, 403) to help agents self-correct.
- **SKILL.md Structure:**
  ```markdown
  ---
  name: SKILL_C_{name} (or SKILL_A_{name})
  description: {description}
  ---
  # {Skill Title}
  ## Overview
  ## Dependencies
  ## Quick Start
  ## Utility Scripts (if CLI) / Workflow (if instruction-only)
  ## Common Mistakes
  ```

---

## Phase 4: Validation

1. **Test the skill manually** by prompting the agent with a query that triggers the new skill (e.g., typing `/SKILL_C_[name]`).
2. Verify that outputs match the expected results and are written to files correctly.
