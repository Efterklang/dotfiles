---
name: markdown-codeblock
description: Use when the user wants to highlight code in markdown files, including inline code highlighting with {lang} prefix syntax, code blocks with language fences and titles, and transformer marks for diffs, highlights, focus, errors, and warnings. Always read this skill file when inserting code blocks or inline code in markdown.
---

# Shiki Code Highlighting for Markdown Blogs

## Inline Code Syntax

Apply to code wrapped in **single backticks**:

```md
`{python} print("Hello")`
`{javascript} console.log("x")`
`{html} <div></div>`
`{rust} fn main() {}`
`{shell} echo "hi"`
```

**Do NOT** use `{lang}` prefix on triple-backtick code blocks.

## Code Blocks

Use language name in opening fence. Optionally add filename after language:

```python
def greet(name):
    return f"Hello, {name}!"
```

```typescript hello.ts
const add = (a: number, b: number): number => a + b;
```

### Nested Code Blocks

The default number of backticks for code blocks is 3. When there are nested code blocks inside the content, the outer code block's backticks increase by one per nesting level. If there are multiple layers of nesting, continue adding backticks accordingly.

For example, if the inner content contains triple backticks, use 4 backticks for the outer wrapper:

````md
```typescript
// Your code example here that might contain ``` in it
```
````

If the inner content has 4 backticks, use 5 for the outer, and so on.

## Transformer Marks

Add marks in comments after `#`. Use marks to draw attention or add semantic meaning:

| Mark | When to Use |
| --- | --- |
| `# [!code --]` | Show code removal (before → after comparisons) |
| `# [!code ++]` | Show code addition (before → after comparisons) |
| `# [!code highlight]` | Emphasize important or key lines |
| `# [!code word:term]` | Highlight specific identifier, keyword, or term |
| `# [!code focus]` | De-emphasize surrounding code, focus on one section |
| `# [!code error]` | Mark lines with errors, invalid code, or exceptions |
| `# [!code warning]` | Mark lines with warnings, deprecations, or cautions |

### Diff (Before → After)

```rust
let x = 5; // [!code --]
let x = 10; // [!code ++]
```

### Line Highlight (Key Lines)

```python
def calculate(items):
    total = 0
    for item in items:  # [!code highlight]
        total += item.price
    return total  # [!code highlight]
```

### Word Highlight (Specific Terms)

```typescript
// [!code word:interface]
interface User {
  id: number;  // [!code word:id]
  name: string;  // [!code word:name]
}
```

### Focus (Main Topic)

```go
// [!code focus]
func (s *Service) Process() error {
    return s.validate()
}

func (s *Service) validate() error {
    // validation logic
}
```

### Error (Problematic Code)

```javascript
const result = JSON.parse(userInput); // [!code error]

try {
    await riskyOperation(); // [!code error]
} catch (e) {
    handleError(e); // [!code warning]
}
```
