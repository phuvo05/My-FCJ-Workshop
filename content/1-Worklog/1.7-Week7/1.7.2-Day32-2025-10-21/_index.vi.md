---
title: "Ngày 32 - Contract-First & Mocking"
weight: 2
chapter: false
pre: "<b> 1.7.2. </b>"
---

**Ngày:** 2025-10-21 (Thứ Ba)  
**Trạng thái:** "Hoàn thành"  

---

# **Ghi chú Bài học**

## Contract-First Development

### Quy trình 5 bước

1. Viết OpenAPI spec để định nghĩa contract.  
2. Dùng spec làm **Single Source of Truth** cho cả frontend và backend.  
3. Frontend dựng UI với mock data dựa trên spec.  
4. Backend implement API bám sát schema (status code, payload).  
5. Chạy contract testing để chắc chắn backend tuân thủ spec.

```yaml
paths:
  /books/{id}:
    get:
      summary: Get book detail
      responses:
        "200":
          $ref: "#/components/responses/BookDetail"
```

### Lợi ích

- Giảm mismatch API vì mọi người xem cùng một spec.
- Documentation, mock server, test script có thể sinh tự động.
- Dễ review và versioning trước khi triển khai thật.

### Insight

> Viết contract trước code giúp giảm ~80% lỗi integration khi frontend/backend phát triển song song.

## Mock API với Prism

- Prism đọc OpenAPI để sinh response giả, cho phép frontend test UI sớm.
- Hỗ trợ nhiều scenario (200, 404, 500) bằng cách khai báo `example` trong spec.
- Giữ nhịp làm việc khi backend chưa xong hoặc đang refactor.

### Khi nên dùng

- Sprint đầu của vertical slice.  
- Cần demo flow nhưng chưa có dữ liệu thật.  
- Muốn viết test tự động cho UI dựa trên contract.

## Ghi chú vận hành

- Chạy Prism tại `localhost:4010`, cấu hình `NEXT_PUBLIC_API_URL` trỏ đến mock.
- Đảm bảo header CORS trong mock giống backend production.
- Luôn commit spec trước khi mock để mọi người dùng đúng version.

---

# **Labs thực hành**

- Tạo OpenAPI spec cho endpoint `/books/{id}`.  
- Khởi chạy Prism mock server và test luồng UI.  
- Viết checklist review contract (status code, schema, example data).
