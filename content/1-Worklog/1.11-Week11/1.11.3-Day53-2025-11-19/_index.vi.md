---
title: "Ngày 53 - Hàm chạy trên LMI"
weight: 3
chapter: false
pre: "<b> 1.11.3. </b>"
---

**Ngày:** 2025-11-19 (Thứ Tư)  
**Trạng Thái:** "Kế hoạch"  

---

# Tạo và publish hàm

Tạo hàm như thường, gắn capacity provider và publish version để khởi tạo instance.

## Tính năng hỗ trợ

- Đóng gói: ZIP hoặc OCI
- Runtime: Java, Python, Node, .NET
- Layers, extensions, function URL, response streaming, durable functions
- Timeout 15 phút (dài hơn nếu dùng durable)

## Thiết lập tài nguyên

- Memory/CPU ảnh hưởng lựa chọn instance
- Có multi-concurrency mỗi instance; cân đối throughput/chi phí
- Nhiều hàm có thể dùng chung một provider (pool dùng chung)

## Quy trình

1) Tạo capacity provider (VPC, role, rule chọn máy)
2) Tạo function kèm ARN provider
3) Publish version để Lambda tạo instance và deploy execution environment
