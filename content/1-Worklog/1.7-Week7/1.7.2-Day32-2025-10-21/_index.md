---
title: "Day 32 - Contract-First & Mocking"
weight: 2
chapter: false
pre: "<b> 1.7.2. </b>"
---

**Date:** 2025-10-21 (Tuesday)  
**Status:** "Done"  

---

# **Lecture Notes**

## Contract-First Development

### 5-Step Workflow

1. Write the OpenAPI spec to define the contract.  
2. Share the spec as the **single source of truth** for both frontend and backend.  
3. Let the frontend build UI against mock data derived from the contract.  
4. Implement the backend API to match the schema (status codes, payloads).  
5. Run contract testing to confirm the backend adheres to the spec.

```yaml
paths:
  /books/{id}:
    get:
      summary: Get book detail
      responses:
        "200":
          $ref: "#/components/responses/BookDetail"
```

### Benefits

- Minimizes API mismatches because everyone references the same spec.
- Documentation, mock servers, and test scripts can be generated automatically.
- Makes it easy to review and version the API before real deployment.

### Insight

> Defining the contract before coding cuts ~80% of integration issues when teams work in parallel.

## Mock APIs with Prism

- Prism reads OpenAPI specs to return mock responses so the frontend can test UI early.
- Multiple scenarios (200, 404, 500) are supported by attaching examples to the spec.
- Keeps delivery on track even when the backend is unfinished or in refactor mode.

### When to Use It

- The first sprint of a vertical slice.  
- Need to showcase a flow without production data yet.  
- Want automated UI tests based on the contract.

## Operational Notes

- Run Prism on `localhost:4010` and point Next.js to the mock via `NEXT_PUBLIC_API_URL`.
- Mirror production CORS headers in the mock responses.
- Always commit the spec before mocking so everyone uses the same version.

---

# **Hands-On Labs**

- Define the OpenAPI spec for the `/books/{id}` endpoint.
- Launch the Prism mock server and verify the UI flow.
- Write a contract review checklist (status codes, schema, sample data).
