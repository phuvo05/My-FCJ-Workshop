---
title: "Ngày 31 - Khởi động Vertical Slice"
weight: 1
chapter: false
pre: "<b> 1.7.1. </b>"
---

**Ngày:** 2025-10-20 (Thứ Hai)  
**Trạng thái:** "Hoàn thành"  

---

# **Ghi chú Bài học**

## Bối cảnh dự án

### Ebook Demo – Vertical Slice 0

- Mục tiêu: demo trọn vẹn luồng **xem chi tiết sách** end-to-end trước khi xây toàn bộ hệ thống.
- Cách tiếp cận: **Vertical Slice Architecture** để phát triển từng lát cắt hoàn chỉnh thay vì chia theo tầng kỹ thuật.
- Lợi ích: trình diễn sớm, phát hiện lỗi sớm, tạo nhịp phối hợp giữa frontend/backend.

### Kiến trúc slice

```
User → Frontend → API → Database → Response → UI
```

- Mỗi slice bao gồm UI, contract API, logic backend và dữ liệu giả phục vụ demo.
- Có thể thay thế từng thành phần độc lập mà không ảnh hưởng toàn bộ hệ thống.

## Vertical Slice Architecture

### Nguyên tắc chính

- Phát triển theo flow người dùng thay vì bóc tách theo tầng.
- Giữ scope nhỏ để **demo nhanh** và nhận feedback liên tục.
- Xác định rõ trách nhiệm của từng slice để dễ mở rộng.

### Lợi ích

- Tăng tốc đóng gói giá trị: có thể show cho stakeholder ngay.
- Giảm rủi ro tích hợp vì mỗi slice tự kiểm chứng được.
- Cho phép nhiều slice phát triển song song.

## Insight chính

- Vertical slice là nền tảng trước khi mở rộng feature khác.
- Mỗi slice cần checklist rõ (UI hoàn thiện, contract chuẩn, backend trả dữ liệu đúng).
- Xem slice như “mini product” với vòng đời riêng giúp giữ được chất lượng.

---

# **Labs thực hành**

- Xác định phạm vi slice 0 (luồng xem chi tiết sách, dữ liệu tối thiểu).
- Vẽ sơ đồ dòng dữ liệu và ranh giới giữa frontend/backend.
- Chuẩn hóa checklist demo (contract, mock, UI, backend).
