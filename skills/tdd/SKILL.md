---
name: tdd
description: Test-Driven Development workflow. Use when the user asks to implement features with tests first, write tests, or follow TDD/Red-Green-Refactor methodology. Trigger phrases include "TDD", "test first", "write tests", "red green refactor".
---

# Test-Driven Development (TDD) Skill

Enforces a strict Red-Green-Refactor cycle for every implementation task.

## Workflow

### Phase 1: RED — Write Failing Tests First

1. Understand the requirement thoroughly before writing any code
2. Write the **minimum** test that defines the expected behavior
3. Run the test — confirm it **fails** with a clear, expected error
4. Do NOT write implementation code yet

### Phase 2: GREEN — Make Tests Pass

1. Write the **simplest** implementation that makes the failing test pass
2. No premature optimization, no extra features
3. Run the test — confirm it **passes**
4. If it still fails, fix the implementation (not the test, unless the test was wrong)

### Phase 3: REFACTOR — Clean Up

1. Improve code quality while keeping all tests green
2. Remove duplication, improve naming, simplify logic
3. Run all tests after each refactoring step
4. Never change behavior during refactoring

## Rules

- **Never skip the RED phase** — always see the test fail first
- **One behavior per test** — each test should verify exactly one thing
- **Tests are documentation** — test names should read as specifications
- **Small increments** — add one test at a time, make it pass, repeat
- **Run tests frequently** — after every change, not just at the end

## Test Naming Convention

```
test_<what>_<when>_<then>
```

Example: `test_calculate_total_with_discount_returns_reduced_price`

## When to Apply

- User says "TDD", "test-driven", "test first", "write tests first"
- User asks to implement a feature and mentions tests
- User asks to fix a bug (write a regression test first, then fix)

## Anti-Patterns to Avoid

- Writing implementation before tests
- Writing tests that pass immediately (skipping RED)
- Testing implementation details instead of behavior
- Writing too many tests at once before implementing
- Modifying tests to match broken implementation
