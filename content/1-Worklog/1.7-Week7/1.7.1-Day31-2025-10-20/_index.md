---
title: "Day 31 - Vertical Slice Kickoff"
weight: 1
chapter: false
pre: "<b> 1.7.1. </b>"
---

**Date:** 2025-10-20 (Monday)  
**Status:** "Done"  

---

# **Lecture Notes**

## Project Context

### Ebook Demo – Vertical Slice 0

- **Goal:** deliver an end-to-end demo of the book-detail experience before scaling the full system.
- **Approach:** adopt a **Vertical Slice Architecture** so every slice is built as a complete feature instead of layer-by-layer.
- **Benefits:** immediate demos, earlier bug discovery, and tighter coordination between frontend and backend.

### Slice Architecture

```
User → Frontend → API → Database → Response → UI
```

- Each slice bundles UI, API contracts, backend logic, and demo data.
- Components can be swapped independently without breaking the rest of the system.

## Vertical Slice Architecture

### Core Principles

- Build features around the user journey instead of isolated layers.
- Keep the scope tight so each slice can **demo quickly** and gather feedback.
- Define slice ownership clearly to ease future extensions.

### Benefits

- Accelerates value delivery—you can show stakeholders right away.
- Lowers integration risk because every slice self-validates.
- Enables multiple slices to progress in parallel.

## Key Insights

- Vertical slices act as the foundation before expanding to additional features.
- Each slice needs a clear checklist (finished UI, validated contract, accurate backend responses).
- Treat every slice like a “mini product” with its own lifecycle to keep quality high.

---

# **Hands-On Labs**

- Define the scope of slice 0 (book-detail flow, minimum viable data).
- Draw the data-flow diagram and nail down the frontend/backend boundary.
- Standardize the demo checklist (contract, mock, UI, backend).
