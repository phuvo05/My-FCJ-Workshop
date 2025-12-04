---
title: "Ngày 33 - Next.js App Router"
weight: 3
chapter: false
pre: "<b> 1.7.3. </b>"
---

**Ngày:** 2025-10-22 (Thứ Tư)  
**Trạng thái:** "Hoàn thành"  

---

# **Ghi chú Bài học**

## Next.js 16 App Router

- Tận dụng **Server Components** để fetch data trực tiếp từ server và tránh bundle dư thừa.
- Route `/app/books/[id]/page.tsx` lo việc fetch dữ liệu, trả về UI đã render sẵn.
- `generateMetadata` giúp bổ sung meta SEO dựa trên dữ liệu sách.

```tsx
// app/books/[id]/page.tsx
import { getBook } from "@/lib/api";

export default async function BookDetail({ params }) {
  const book = await getBook(params.id);
  if (!book) return notFound();
  return <BookPage book={book} />;
}
```

### Xử lý lỗi & not-found

- Chỉ cần `not-found.tsx` cho trường hợp không tìm được sách → coi là flow dự kiến.
- Không dùng `error.tsx` để tránh xử lý trùng; các lỗi còn lại sẽ được log ở backend.
- Giữ UX đồng nhất: hiển thị CTA quay về danh sách và hotline hỗ trợ.

## Environment & Config

- Sử dụng biến môi trường rõ ràng: `NEXT_PUBLIC_API_URL` cho frontend, `API_URL` cho route handler.
- Luôn cập nhật `.env.example` khi thêm biến mới.
- Gom logic build URL vào helper `lib/api.ts` để tránh lặp code.

## Insight

- Server Components giảm đáng kể latency khi render trang chi tiết.
- App Router giúp cấu trúc thư mục rõ ràng, dễ mở rộng thêm slice mới.
- Khi dùng mock API, chỉ cần đổi base URL để fetch từ Prism.

---

# **Labs thực hành**

- Tạo `not-found.tsx` tùy biến với CTA điều hướng.  
- Viết helper `getBook(id)` tái sử dụng cho Server Components và tests.  
- Chạy `npm run lint && npm run build` để chắc cấu hình Next.js sạch.
