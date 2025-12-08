---
title: "Tuần 11 - Lambda Managed Instances & ghi chú re:Invent"
weight: 11
chapter: false
pre: "<b> 1.11. </b>"
---

**Tuần:** 2025-11-17 đến 2025-11-21  
**Trạng thái:** "Kế hoạch"  

---

## Tổng quan Tuần 11

Tóm tắt session AWS re:Invent 2025 (CNS382) về Lambda Managed Instances (LMI): chạy hàm Lambda trên EC2 do Lambda quản lý, giữ nguyên trải nghiệm serverless nhưng chọn được loại máy, giá EC2, và loại bỏ cold start. Trọng tâm: khi nào chọn LMI vs. Lambda mặc định, cách cấu hình capacity provider, và lưu ý test/ops cho workload lưu lượng ổn định.

### Chủ đề chính

#### Vì sao LMI
- Giữ trải nghiệm Lambda nhưng tự chọn họ máy EC2 và tận dụng Savings Plan/Reserved Instance
- Không cold start, hỗ trợ multi-concurrency trên instance
- Dễ dự báo chi phí với traffic ổn định

#### Kiến trúc & Thiết lập
- Capacity Provider: cấu hình VPC, loại máy (C/M/R, x86/Graviton), guardrail scaling
- Quy trình: tạo capacity provider -> tạo function gắn provider -> publish version để khởi tạo instance
- Vòng đời do Lambda quản lý: patch OS/runtime, routing/auto scaling; thấy instance nhưng không can thiệp được

#### Mạng & Bảo mật
- Toàn bộ egress đi qua ENI của instance trong VPC provider; không cấu hình VPC ở mức function
- Đóng inbound SG; đảm bảo đường ra tới dependency/CloudWatch (Internet hoặc PrivateLink)
- Mặc định mã hóa EBS, có thể dùng KMS của bạn

#### Tính năng hàm & Scaling
- Hỗ trợ ZIP/OCI; runtime Java/Python/Node/.NET; layers, extensions, function URL, response streaming, durable functions
- Memory/CPU quyết định chọn instance; có thể giới hạn/loại trừ loại máy
- Guardrail scaling ở mức instance (vd max vCPU) để kiểm soát chi phí

#### Phù hợp & Đánh đổi
- Dùng LMI cho workload lưu lượng cao, ổn định, hoặc cần compute/memory/network đặc thù
- Giữ Lambda mặc định cho traffic đột biến, ngắn
- Multi-concurrency + billing kiểu EC2 thay đổi bức tranh cost/perf

### Mục tiêu học tập

- Nêu khi nào chọn LMI thay vì Lambda mặc định
- Cấu hình capacity provider (VPC, role, loại máy, guardrail)
- Mô tả mô hình mạng và đường log của LMI
- Ghép tính năng Lambda (đóng gói, runtime, URL, streaming, durable) với LMI
- Đặt giới hạn scale/chi phí và chọn họ máy phù hợp workload

---

## Lịch trong tuần

| Ngày | Trọng tâm | Chủ đề |
|-----|-----------|--------|
| 51 | Tổng quan & use case | Lợi ích LMI, tận dụng giá EC2, khi nào không dùng |
| 52 | Capacity Provider | VPC, IAM operator role, shortlist loại máy, KMS, guardrail |
| 53 | Hàm trên LMI | Đóng gói/runtime, ánh xạ memory/CPU, multi-concurrency, publish version |
| 54 | Mạng & quan sát | Đường egress, CloudWatch, SG, logging, monitoring |
| 55 | Scaling & vận hành | Max vCPU, kế hoạch traffic ổn định, kiểm soát chi phí, checklist rollout |

---

## Yêu cầu nền tảng

- Nắm trải nghiệm Lambda và transformer từ tuần trước
- Kiến thức cơ bản EC2/VPC, IAM, CloudWatch
- Hiểu Savings Plan/Reserved Instance cho EC2

## Bước tiếp theo

- Phác capacity provider cho workload mục tiêu (VPC, shortlist instance, guardrail)
- Lập kế hoạch benchmark LMI vs. Lambda mặc định theo traffic mẫu
- Vẽ đường giám sát/log (CloudWatch endpoint, PrivateLink nếu cần)
- Quyết định dùng SP/RI và mục tiêu multi-concurrency cho từng hàm
