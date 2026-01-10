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

3. **Generate message**: Create a conventional commit message based on the changes using the format:
   - Determine type: `feat` , `fix` , `docs` , `style` , `refactor` , `test` , `chore`
   - Add optional scope in parentheses if applicable, for example, `doc(api)`
   - Write concise description (50 chars max)
   - Add body if explanation needed, separated by blank line, prefer to explain WHY something was done from an end user perspective instead of WHAT was done.
   - The output language should be English if not specified otherwise.
4. **Execute commit**: Run `git commit -m "generated message"`