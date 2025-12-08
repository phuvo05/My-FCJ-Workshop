---
title: "Ngày 52 - Thiết lập Capacity Provider"
weight: 2
chapter: false
pre: "<b> 1.11.2. </b>"
---

**Ngày:** 2025-11-18 (Thứ Ba)  
**Trạng Thái:** "Kế hoạch"  

---

# Xây capacity provider

Bước 1 cho LMI: định nghĩa lớp instance (capacity provider) với VPC, role và lựa chọn loại máy.

## Thông tin bắt buộc

- IAM role cho phép Lambda launch/manage instance
- VPC config (subnet + SG) nơi instance LMI chạy

## Chọn loại máy

- Hỗ trợ: họ C/M/R đời mới (x86/AMD/Graviton), kích cỡ large+
- Tùy biến: allow/deny list loại máy; đặt kiến trúc ARM nếu cần
- EBS: mã hóa mặc định; có thể dùng KMS của bạn

## Lưu ý mạng

- Dàn subnet qua 3 AZ cho sẵn sàng
- Tất cả egress/log đi qua ENI của instance; không cấu hình VPC ở mức function
- Đóng inbound SG; đảm bảo đường ra tới dependency/CloudWatch

## Guardrail

- Giới hạn max vCPU để chặn bùng chi phí
- Có thêm tham số scale ở mức provider khi cần
