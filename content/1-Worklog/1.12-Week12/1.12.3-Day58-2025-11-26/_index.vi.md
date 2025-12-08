---
title: "Ngày 58 - Vector & dữ liệu riêng tư"
weight: 3
chapter: false
pre: "<b> 1.12.3. </b>"
---

**Ngày:** 2025-11-26 (Thứ Tư)  
**Trạng Thái:** "Kế hoạch"  

---

# Lưu trữ vector & dữ liệu tổng hợp

- Amazon S3 Vectors GA: tới 2B vector/index, ~100ms truy vấn, chi phí thấp hơn DB chuyên dụng
- Clean Rooms sinh dữ liệu tổng hợp an toàn cho ML cộng tác

## Cân nhắc di chuyển

- Kích thước index vs. store hiện tại; sharding và đặt vùng
- Mục tiêu độ trễ truy vấn, ước tính chi phí so với vector DB đang dùng
- Mẫu truy cập và bảo mật khi chia sẻ dữ liệu

## Việc cần làm

- Thiết kế POC chuyển một bộ vector sang S3 Vectors; đo hiệu năng/chi phí
- Xác định dataset cần synthetic để dùng chung
- Đặt chính sách lưu trữ/mã hóa và truy cập cho dữ liệu vector
