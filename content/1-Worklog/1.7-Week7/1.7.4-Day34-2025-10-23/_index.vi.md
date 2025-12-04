---
title: "Ngày 34 - FastAPI Clean Architecture"
weight: 4
chapter: false
pre: "<b> 1.7.4. </b>"
---

**Ngày:** 2025-10-23 (Thứ Năm)  
**Trạng thái:** "Hoàn thành"  

---

# **Ghi chú Bài học**

## Tổng quan Clean Architecture

- Tách rõ phần cấu hình, model, route và core logic để dễ mở rộng/kiểm thử.
- Giữ `main.py` nhẹ: chỉ khởi tạo app, load config và mount router.
- Dùng Pydantic model để chuẩn hóa request/response, đảm bảo contract trùng OpenAPI.

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

## Cấu hình & Dependency

- `core/config.py` đọc biến môi trường, gom cấu hình CORS, API prefix, debug flag.
- Tận dụng dependency injection của FastAPI để truyền service vào router.
- Giúp thay datasource (in-memory → PostgreSQL) mà không đổi interface hàm.

## CORS & Độ ổn định API

- CORS chỉ mở cho origin cần thiết (`http://localhost:3000` trong giai đoạn dev).
- Bật `allow_methods=["GET"]` cho slice đầu tiên để giảm bề mặt tấn công.
- Đảm bảo `/openapi.json` luôn truy cập được nhằm phục vụ công cụ contract testing.

## Bắt đầu đơn giản, refactor sau

- Dùng repository in-memory để demo nhanh, sau đó mới thêm DB thật.
- Ghi chú TODO rõ ràng để không quên khi sang sprint mới.
- Logging tối giản, tập trung các lỗi quan trọng (timeout, data mismatch).

---

# **Labs thực hành**

- Refactor `main.py` chỉ còn khởi tạo app và register router.  
- Viết service `get_book_detail(id)` trả dữ liệu giả theo spec.  
- Cấu hình `CORSMiddleware` khớp URL của frontend mock/production.
