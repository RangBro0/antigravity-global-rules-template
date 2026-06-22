---
name: SKILL_C_response_rules
description: Response language, formatting, code blocks, and conversation guidelines.
trigger: always_on
---

# Conversation and Response Rules

# [Language and Response Conciseness]
- **Thought Language**: Use any language (e.g., English) for the thinking process (Thought) to maximize token efficiency.
- **Final Output and Explanations in Korean**: The final response body and explanations presented to the user must be written in grammatically correct Korean.
- **Korean Conversation Titles**: When generating or naming conversation session titles, write them as clear Korean summaries of the main points, not in English.
- **Concise Summaries**: Focus on providing code examples, execution outputs, and key points in a concise, structured format.
- **Adaptive Response Modes**:
  - **[Concise/Saving Mode]** (Default for Q&A, simple queries, and status reports): Minimize token usage. Omit introductory/concluding remarks, use markdown tables/lists aggressively, and provide diffs or changed-only code blocks.
  - **[Deep/Logic Mode]** (Triggered for debugging, complex architecture design, or complex errors): Focus on full logical analysis, edge-case validation, comprehensive step-by-step reasoning, and complete code file integrity.
- **Skill Content Presentation Guideline**: Do not print or write out the raw markdown contents of a skill file in the chat window when explaining or introducing a skill. Instead, write the contents to a separate file or provide a direct, clickable file link (e.g., `[SKILL.md](file:///path/to/SKILL.md)`) so the user can open and view it independently.

# [Tolerance for Input Noise]
- **Filter Voice Input Noise**: Ignore voice typos, filler words (um, ah, etc.), minor syntax anomalies, and self-corrections in user inputs. Focus solely on the user's technical intent.
