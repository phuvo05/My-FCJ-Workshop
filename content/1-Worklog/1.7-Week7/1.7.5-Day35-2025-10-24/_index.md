---
title: "Day 35 - Contract Testing & Retrospective"
weight: 5
chapter: false
pre: "<b> 1.7.5. </b>"
---

**Date:** 2025-10-24 (Friday)  
**Status:** "Done"  

---

# **Lecture Notes**

## Contract Testing with Schemathesis

- Run `schemathesis run --checks all --workers 4 --url http://127.0.0.1:8000/openapi.yaml` to auto-generate tests.
- Schemathesis explores random scenarios (happy paths, edge cases, missing fields).
- Ensures the backend doesn’t break the schema when the frontend switches to the real API.

### Benefits

- Eliminates the need to handcraft complex test cases.
- Reduces mismatch risk after refactors.
- Acts as a quality gate inside the CI pipeline.

## Mistakes & Fixes

| Mistake                               | Root Cause        | Fix                               |
| ------------------------------------- | ----------------- | ---------------------------------- |
| Added both `error.tsx` and `not-found.tsx` | Redundant handling | Keep only `not-found.tsx`          |
| Used `--base-url` in Schemathesis     | Wrong CLI option  | Use the correct `--url` flag       |
| Timeout on `/openapi.json`            | CORS or slow resp | Point Schemathesis to the YAML file |
| Over-engineered backend               | Too many files early | Start simple and refactor later  |

## Validated Workflow

```
1. Define Contract (OpenAPI)
2. Mock API (Prism)
3. Build Frontend with mock data
4. Implement Backend according to the spec
5. Switch to the real API
6. Contract Testing (Schemathesis)
```

- Enables frontend and backend teams to work in parallel.
- Reduces conflicts, accelerates demos, and keeps quality stable.

## Key Insights

1. Contract-first development keeps specs aligned and shrinks integration bugs.  
2. Vertical slices make it possible to release in increments and gather early feedback.  
3. Automation (Prism, Schemathesis) cuts manual testing effort.  
4. Start simple and refactor gradually as scope grows.

---

# **Hands-On Labs**

- Run Schemathesis with the latest spec and capture the results.
- Refresh the README workflow so the whole team can follow it.
- Prepare the backlog for the next vertical slice based on demo feedback.
