---
title: "Day 33 - Next.js App Router"
weight: 3
chapter: false
pre: "<b> 1.7.3. </b>"
---

**Date:** 2025-10-22 (Wednesday)  
**Status:** "Done"  

---

# **Lecture Notes**

## Next.js 16 App Router

- Leverage **Server Components** to fetch data directly on the server and avoid bloated bundles.
- The `/app/books/[id]/page.tsx` route handles data fetching and returns a pre-rendered UI.
- `generateMetadata` supplies SEO meta tags based on the book payload.

```tsx
// app/books/[id]/page.tsx
import { getBook } from "@/lib/api";

export default async function BookDetail({ params }) {
  const book = await getBook(params.id);
  if (!book) return notFound();
  return <BookPage book={book} />;
}
```

### Error & Not Found Handling

- Only `not-found.tsx` is needed for missing books—treat it as an expected branch.
- Skip `error.tsx` to avoid double handling; log unexpected issues on the backend.
- Keep UX consistent with a CTA back to the listing page plus a support hotline.

## Environment & Config

- Use explicit environment variables: `NEXT_PUBLIC_API_URL` for the frontend and `API_URL` for route handlers.
- Keep `.env.example` in sync whenever a new variable is introduced.
- Centralize URL construction in `lib/api.ts` to prevent duplication.

## Insight

- Server Components noticeably reduce latency when rendering detail pages.
- The App Router enforces a clear folder structure, making it easier to split new slices.
- When pointing to the mock API, fetch directly from Prism by swapping the base URL.

---

# **Hands-On Labs**

- Create a custom `not-found.tsx` with navigation CTAs.
- Implement a reusable `getBook(id)` helper for server components and tests.
- Run `npm run lint && npm run build` to ensure the Next.js configuration stays clean.
