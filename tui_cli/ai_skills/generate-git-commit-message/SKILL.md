---
name: generate-git-commit-message
description: Generate and execute git commit messages for the current repository based on staged changes. Use when you need to commit staged files with an automatically generated conventional commit message.
---

# Generate git commit message for current repo

## Overview

This skill automates the process of generating a conventional commit message based on staged changes in a git repository and executes the commit.

## Workflow

Follow these steps to generate and execute a commit:

1. **Check staged changes**: Run `git status` to verify there are staged files. If no staged changes, inform the user.

2. **Analyze changes**: Run `git --no-pager diff --cached` to examine the staged modifications.

3. **Generate message**: Create a conventional commit message based on the changes:
   - Determine type: `feat` (new feature), `fix` (bug fix), `docs` (documentation), `style` (formatting), `refactor` (code restructuring), `test` (testing), `chore` (maintenance)
   - Add optional scope in parentheses if applicable (e.g., component name)
   - Write concise description (50 chars max)
   - Add body if explanation needed, separated by blank line

4. **Execute commit**: Run `git commit -m "generated message"`

## Examples

- For adding a new user authentication feature: `feat: implement user authentication`
- For fixing a login bug: `fix: resolve login validation error`
- For updating documentation: `docs: update API reference`
