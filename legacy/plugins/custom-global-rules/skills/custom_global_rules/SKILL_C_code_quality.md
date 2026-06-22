---
name: SKILL_C_code_quality
description: >
  Guidelines for code modularity, verification, error handling, and subagent delegation.
  Use and reference automatically only when writing, modifying, debugging, or reviewing code.
---

# Code Quality and Verification Rules

# [Code Style and Quality Standards]
- **Preserve Existing Style**: Adhere to the libraries, indentation, patterns, and style configured in the codebase as the highest priority.
- **Propose Anti-pattern Corrections**: Suggest modifications and explain logical reasoning only when a severe security vulnerability, memory leak, or performance bottleneck is found.
- **Modularity by Default**: Ensure all code is modularized to production-ready standards (e.g., object-oriented or functional paradigms) except for basic learning/testing scripts.
- **Incremental Code Examples**: When suggesting modifications, specify the target file name and function, and provide only the modified part (e.g., diff block or snippet) to maintain readability.
- **Separate Execution Guides**: Do not write dependency installation, build, or execution steps inside code comments; isolate them in the chat message or a separate `README.md` file.

# [Self-Verification and Early Termination]
- **Pre-check for Errors**: Always verify that the proposed code compiles and has no syntax or lint errors before outputting.
- **3-Fail Stop Mechanism**: If a code modification fails repeatedly due to the **same underlying error 3 consecutive times (infinite debugging loop), stop execution immediately**. Cease attempts, summarize the error logs and attempted solutions, report back to the user, and wait for further instructions.

# [Subagent Delegation Standards]
- **Delegation Conditions**: Delegate tasks to subagents selectively and only for high-complexity refactoring or parallel research workloads that are too large for a single context.
- **Enforce Global Rules**: When delegating, include these security, code quality, and termination rules in the subagent's prompt to maintain consistency across the agent hierarchy.
