---
title: "Ngày 35 - Contract Testing & Retrospective"
weight: 5
chapter: false
pre: "<b> 1.7.5. </b>"
---

**Ngày:** 2025-10-24 (Thứ Sáu)  
**Trạng thái:** "Hoàn thành"  

---

# **Ghi chú Bài học**

## Contract Testing với Schemathesis

- Chạy `schemathesis run --checks all --workers 4 --url http://127.0.0.1:8000/openapi.yaml` để tạo bộ test tự động.
- Schemathesis sinh nhiều trường hợp ngẫu nhiên (happy path, edge case, thiếu field).
- Đảm bảo backend không trả sai schema khi frontend chuyển sang gọi API thật.

### Lợi ích

- Không cần viết tay test case phức tạp.  
- Giảm rủi ro mismatch sau refactor.  
- Hoạt động như quality gate trong CI pipeline.

## Sai sót & cách khắc phục

| Sai lầm | Nguyên nhân | Cách xử lý |
|--------|-------------|-----------|
| Tạo cả `error.tsx` và `not-found.tsx` | Thừa xử lý | Chỉ giữ `not-found.tsx` |
| Dùng `--base-url` trong Schemathesis | Sai câu lệnh | Dùng `--url` đúng chuẩn |
| Timeout khi đọc `/openapi.json` | CORS hoặc phản hồi chậm | Dùng file YAML trực tiếp |
| Over-engineer backend | Tách quá nhiều file sớm | Bắt đầu đơn giản, refactor sau |

## Workflow chuẩn đã được validate

```
1. Define Contract (OpenAPI)
2. Mock API (Prism)
3. Build Frontend với mock data
4. Implement Backend theo spec
5. Chuyển sang API thật
6. Contract Testing (Schemathesis)
```

- Hỗ trợ frontend và backend phát triển song song.
- Giảm xung đột, tăng tốc demo và giữ chất lượng ổn định.

## Key Insights

1. Contract-first giữ spec đồng bộ, giảm lỗi integration.  
2. Vertical slice cho phép release từng phần và lấy feedback sớm.  
3. Tự động hóa (Prism, Schemathesis) giảm effort test thủ công.  
4. Bắt đầu đơn giản, refactor dần khi nhu cầu mở rộng.

---

# **Labs thực hành**

- Chạy Schemathesis với spec mới nhất và ghi nhận kết quả.  
- Cập nhật README workflow để cả team tham khảo.  
- Chuẩn bị backlog cho vertical slice tiếp theo dựa trên feedback demo.
