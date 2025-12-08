---
title: "Ngày 54 - Mạng & quan sát"
weight: 4
chapter: false
pre: "<b> 1.11.4. </b>"
---

**Ngày:** 2025-11-20 (Thứ Năm)  
**Trạng Thái:** "Kế hoạch"  

---

# Đường đi lưu lượng và log

Mọi traffic từ LMI đi qua ENI của instance trong VPC provider; cần thiết kế kết nối và monitoring phù hợp.

## Egress & đích

- Dependency phải truy cập được từ VPC provider (NAT/Transit/Peering/PrivateLink)
- Log CloudWatch cũng đi qua ENI; mở đường tới endpoint (public hoặc PrivateLink)

## Security Group

- Không cần inbound; giữ inbound đóng
- Outbound phải cover dependency và CloudWatch

## Quan sát

- Log CloudWatch như thường, miễn có đường kết nối
- Theo dõi metric instance (EC2 billing, vCPU) + Lambda (invokes, errors)

## Lưu ý

- Bỏ qua cấu hình VPC ở mức function cho LMI
- Giới hạn băng thông/ENI theo loại instance vẫn áp dụng
