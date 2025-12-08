---
title: "Ngày 57 - Bedrock & AgentCore"
weight: 2
chapter: false
pre: "<b> 1.12.2. </b>"
---

**Ngày:** 2025-11-25 (Thứ Ba)  
**Trạng Thái:** "Kế hoạch"  

---

# Cập nhật Bedrock

- Thêm model open-weight managed (Mistral Large 3, Ministral 3 3B/8B/14B và đối tác khác)
- Reinforcement fine-tuning: tuning theo phản hồi, cải thiện độ chính xác lớn mà không cần bộ nhãn lớn

## AgentCore

- Thêm policy control và quality monitoring cho agent
- Cải thiện bộ nhớ và hội thoại tự nhiên để triển khai an toàn hơn

## Việc cần làm

- Chọn model để đánh giá (latency/chi phí/chất lượng so với hiện tại)
- Lên thử nghiệm RFT cho tác vụ mục tiêu; định nghĩa tín hiệu phản hồi
- Xác định guardrail/policy trước khi bật AgentCore production
