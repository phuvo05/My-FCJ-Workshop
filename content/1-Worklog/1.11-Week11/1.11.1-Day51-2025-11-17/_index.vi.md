---
title: "Ngày 51 - Tổng quan Lambda Managed Instances"
weight: 1
chapter: false
pre: "<b> 1.11.1. </b>"
---

**Ngày:** 2025-11-17 (Thứ Hai)  
**Trạng Thái:** "Kế hoạch"  

---

# Vì sao dùng LMI

LMI giữ trải nghiệm Lambda nhưng cho chọn họ máy EC2, tận dụng SP/RI, bỏ cold start và cho phép multi-concurrency trên mỗi instance.

## Khi nên dùng

- Lưu lượng cao, ổn định cần chi phí dự báo
- Nhu cầu compute/memory/network đặc thù
- Muốn áp dụng pricing EC2 cho hàm Lambda

## Khi ở lại Lambda mặc định

- Traffic đột biến, khó dự đoán
- Hàm ngắn, thưa cần scale-to-zero

## Lợi ích nhanh

- Giữ cách đóng gói/runtimes Lambda
- Không cold start, công suất ổn định
- Kiểm soát chi phí qua SP/RI

## Ghi chú từ CNS382

- Instance do AWS quản lý: thấy nhưng không SSH/chỉnh
- Lambda lo vòng đời, patch, routing
- Multi-concurrency thay đổi profile giá/hiệu năng
