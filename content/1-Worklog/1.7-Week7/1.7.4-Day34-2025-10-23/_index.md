---
title: "Day 34 - FastAPI Clean Architecture"
weight: 4
chapter: false
pre: "<b> 1.7.4. </b>"
---

**Date:** 2025-10-23 (Thursday)  
**Status:** "Done"  

---

# **Lecture Notes**

## Clean Architecture Overview

- Separate config, models, routes, and core logic to simplify scaling.
- Keep `main.py` lightweight—only boot the app, load config, and mount routers.
- Use Pydantic models to standardize request/response shapes so the contract matches OpenAPI.

```
backend/
├── main.py
├── core/
│   └── config.py
├── models/
│   └── book.py
├── routes/
│   └── books.py
└── services/
    └── books.py
```

## Configuration & Dependencies

- `core/config.py` reads environment variables and centralizes CORS, API prefixes, and debug flags.
- Use FastAPI’s dependency injection to pass the service layer into routers.
- Enables swapping data sources (in-memory → PostgreSQL) without changing function contracts.

## CORS & API Stability

- Restrict CORS to required origins (`http://localhost:3000` during development).
- Allow only `GET` for the first slice to shrink the attack surface.
- Keep `/openapi.json` accessible so contract-testing tools can pull the spec.

## Start Simple, Refactor Later

- Begin with an in-memory repository for fast demos, then add a real database.
- Document TODOs clearly to avoid losing them between sprints.
- Keep logging minimal and focus on critical faults (timeouts, data mismatches).

---

# **Hands-On Labs**

- Refactor `main.py` so it only handles app bootstrapping and router registration.
- Build the `get_book_detail(id)` service layer using spec-driven fake data.
- Configure `CORSMiddleware` to match the frontend mock and production URLs.
