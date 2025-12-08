---
title: "Ngày 55 - Scaling & vận hành"
weight: 5
chapter: false
pre: "<b> 1.11.5. </b>"
---

**Ngày:** 2025-11-21 (Thứ Sáu)  
**Trạng Thái:** "Kế hoạch"  

---

# Scaling và kiểm soát chi phí

Lên kế hoạch scale ở mức instance và multi-concurrency cho traffic ổn định nhưng giới hạn chi phí.

## Guardrail scale

- Giới hạn max vCPU cho capacity provider
- Chọn họ máy theo workload (compute/memory/network)
- Traffic ổn định: ưu tiên máy lớn + multi-concurrency; nếu quá biến động, cân nhắc ở lại Lambda mặc định

## Chi phí & giá

- Áp dụng Savings Plan/Reserved Instance cho công suất LMI
- Theo dõi sử dụng so với cam kết; điều chỉnh mix instance khi cần

## Checklist rollout

- Capacity provider đúng role/VPC/allowlist máy
- Function version đã publish; đường warm OK (không cold start)
- CloudWatch truy cập được; cảnh báo lỗi/độ trễ/concurrency
- Chạy benchmark so sánh LMI vs. Lambda mặc định cho workload của bạn
