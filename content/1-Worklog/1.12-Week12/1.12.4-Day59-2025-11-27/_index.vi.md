---
title: "Ngày 59 - Nền tảng SageMaker AI"
weight: 4
chapter: false
pre: "<b> 1.12.4. </b>"
---

**Ngày:** 2025-11-27 (Thứ Năm)  
**Trạng Thái:** "Kế hoạch"  

---

# Training serverless & resilient

- SageMaker AI serverless MLflow cho thử nghiệm nhanh (không cần hạ tầng, auto scale)
- HyperPod training thêm checkpointless recovery và elastic scaling theo tài nguyên

## Lợi ích

- Chu kỳ thử nghiệm nhanh hơn, không phải dựng cluster
- Giảm chi phí khôi phục lỗi; tận dụng tài nguyên không đồng nhất tốt hơn

## Việc cần làm

- Thiết lập workspace MLflow serverless cho thí nghiệm hiện tại
- Thử checkpointless/elastic training trên một model đại diện; ghi nhận chi phí/thời gian
- Cập nhật playbook MLOps với mode training và xử lý lỗi mới
