---
title: "Ngày 60 - Compute mới"
weight: 5
chapter: false
pre: "<b> 1.12.5. </b>"
---

**Ngày:** 2025-11-28 (Thứ Sáu)  
**Trạng Thái:** "Kế hoạch"  

---

# Graviton5 và Trainium3

- Graviton5: CPU thế hệ mới, giá/hiệu năng tốt hơn cho nhiều workload EC2
- Trainium3 UltraServers (3nm): throughput train/inference cao hơn, chi phí thấp hơn

## Phân tích phù hợp

- Dịch vụ nào chuyển sang Graviton5 (web/app, xử lý dữ liệu) và mức tiết kiệm kỳ vọng
- Bài train/inference nào hưởng lợi từ Trainium3 so với GPU/CPU hiện tại

## Việc cần làm

- Chọn 1–2 dịch vụ benchmark Graviton5; theo dõi perf/chi phí
- Lập POC Trainium3 cho một model mục tiêu; so throughput và ngân sách
- Cập nhật kế hoạch capacity với họ máy và giá mới
