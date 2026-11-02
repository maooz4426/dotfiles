---
name: code-review
description: Review a git diff, a branch, or a file for bugs, security problems, and design problems. Use when the user asks for a code review.
---

## Steps
1. Find the review target.
   - If the user names a branch or PR, run `git diff <default-branch>...<target>`.
   - Otherwise, run `git diff` and `git diff --staged`.
   - Get the default branch with `git remote show origin | grep 'HEAD branch'`. Do not assume `main`.
2. Read the changed files in full. Read the callers of changed functions.
3. Check each change against the list below.
4. Report only findings that you can explain with a concrete failure.

## Checklist
- Correctness: wrong logic, off-by-one errors, null or empty input, error paths.
- Security: injection, unsafe input, secrets in code, wrong permissions.
- Concurrency and state: race conditions, shared state, resource leaks.
- Compatibility: changed public interfaces, changed defaults.
- Tests: missing tests for changed behavior.

## Output format
List findings from most severe to least severe. Use this format for each finding:

- `[bug|security|design|nit]` `file_path:line` — one-sentence summary.
  - Failure: the input or state that causes the problem, and the wrong result.
  - Fix: a short suggestion.

Write "No findings" if you find nothing.

## Rules
- Do not edit files.
- Do not report style preferences as bugs.
- Do not report a finding that you cannot explain with a concrete failure.
