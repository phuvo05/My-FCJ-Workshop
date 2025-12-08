---
title: "Tuần 12 - Thông báo AWS re:Invent 2025"
weight: 12
chapter: false
pre: "<b> 1.12. </b>"
---

**Tuần:** 2025-11-24 đến 2025-11-28  
**Trạng thái:** "Kế hoạch"  

---

## Tổng quan Tuần 12

Tóm tắt re:Invent 2025: dòng Nova mới (speech-to-speech, đa phương thức, reasoning giá rẻ), Bedrock mở rộng (model open-weight, reinforcement fine-tuning), vector/AI hạ tầng (S3 Vectors GA), và phần cứng compute mới như Graviton5, Trainium3 UltraServers. Trọng tâm là lập kế hoạch áp dụng thực tế.

### Chủ đề chính

#### GenAI & Model
- Nova 2: Sonic (speech-to-speech), Lite (nhanh/rẻ), Omni (đa phương thức), Forge để huấn luyện frontier model tùy biến
- Nova Act cho agent UI ổn định; Bedrock AgentCore thêm policy/quality cho agent
- Bedrock bổ sung model open-weight (Mistral Large 3, Ministral 3) và reinforcement fine-tuning

#### Vector & Dữ liệu
- Amazon S3 Vectors GA: tới 2B vector/index, ~100ms truy vấn, chi phí thấp hơn DB chuyên dụng
- Clean Rooms sinh dữ liệu tổng hợp bảo vệ riêng tư cho ML cộng tác

#### Nền tảng AI Dev
- SageMaker AI với serverless MLflow; training checkpointless và elastic trên HyperPod

#### Compute & Hardware
- Graviton5 CPU giá/hiệu năng tốt hơn trên EC2
- Trainium3 UltraServers (3nm) cho train/inference nhanh và rẻ hơn

### Mục tiêu học tập

- Xác định launch AI/compute nào tác động tới workload hiện tại
- Lên pilot cho Nova và tính năng Bedrock mới
- Phác lộ trình chuyển sang S3 Vectors cho lưu trữ/search vector
- Đánh giá phù hợp Graviton5/Trainium3 cho mục tiêu cost/perf

---

## Lịch trong tuần

| Ngày | Trọng tâm | Chủ đề |
|-----|-----------|--------|
| 56 | Model mới | Nova 2 (Sonic, Lite, Omni), Forge, Nova Act |
| 57 | Bedrock & Agent | Model open-weight, reinforcement fine-tuning, AgentCore policy/quality |
| 58 | Vector & dữ liệu | S3 Vectors GA, Clean Rooms synthetic, kế hoạch scale/chi phí |
| 59 | SageMaker | Serverless MLflow, checkpointless & elastic training trên HyperPod |
| 60 | Compute mới | Graviton5, Trainium3 UltraServers, checklist fit/migration |

---

## Yêu cầu nền tảng

- Hiểu catalog Bedrock và khả năng agent
- Nắm kiến trúc vector search cơ bản
- Biết các họ EC2 và lựa chọn accelerator

## Bước tiếp theo

- Chọn 1 pilot cho Nova (speech/đa phương thức/reasoning) và lập kế hoạch đánh giá
- Lập POC chuyển sang S3 Vectors so với vector store hiện tại
- Đặt mục tiêu benchmark cho Graviton5/Trainium3 so với máy đang dùng
- Xác định yêu cầu governance/policy trước khi dùng AgentCore và Nova Act
