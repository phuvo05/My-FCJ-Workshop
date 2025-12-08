---
title: "Ngày 50 - Thực hành fine-tuning"
weight: 5
chapter: false
pre: "<b> 1.10.5. </b>"
---

**Ngày:** 2025-11-14 (Thứ Sáu)  
**Trạng Thái:** "Hoàn thành"  

---

# Công thức fine-tuning

Tập trung vào các nút chỉnh: đóng băng tầng nào, lên lịch learning rate ra sao, và đánh giá setup transfer như thế nào.

## Đóng băng vs. train

- Đóng băng tầng thấp khi dữ liệu ít hoặc miền gần pre-train.
- Mở dần (từ trên xuống) nếu accuracy đứng yên.
- Thêm head đặc thù (classification/span QA/seq2seq) và bắt đầu từ đó.

## Hyperparameter cơ bản

- Learning rate: 1e-5 đến 3e-5 cho fine-tune toàn encoder; cao hơn nếu đa phần đóng băng.
- Warmup: ~5-10% số bước để ổn định giai đoạn đầu.
- Max sequence length: khớp tác vụ; chunk tài liệu dài cho QA.

## Vòng đánh giá

- Theo dõi loss + metric (EM/F1 cho QA, ROUGE cho tóm tắt, accuracy/F1 cho phân loại).
- Early stop theo dev; giữ checkpoint tốt nhất, không chỉ checkpoint cuối.
- So sánh baseline feature-based vs. fine-tune full trên một tập nhỏ.

## Khi triển khai

- Distill hoặc quantize nếu cần giảm độ trễ.
- Cache tokenizer và quy tắc cắt/truncate để tránh lệch train/serve.
- Log prompt/input để debug hành vi closed-book vs. có ngữ cảnh.

---

## Việc thực hành hôm nay

- Chạy (hoặc lập kế hoạch) grid nhỏ: learning rate, chiến lược đóng băng, max length.
- Đánh giá trên tập dev và ghi nhận EM/F1 hoặc ROUGE.
- Quyết định bước hậu huấn luyện: distillation, quantization, hoặc caching.
