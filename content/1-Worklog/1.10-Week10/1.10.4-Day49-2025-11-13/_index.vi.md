---
title: "Ngày 49 - T5 đa nhiệm dạng text-to-text"
weight: 4
chapter: false
pre: "<b> 1.10.4. </b>"
---

**Ngày:** 2025-11-13 (Thứ Năm)  
**Trạng Thái:** "Hoàn thành"  

---

# Một mô hình, nhiều tác vụ

T5 coi mọi thứ là text-to-text, nên cùng một mô hình xử lý QA, tóm tắt, dịch, phân loại thông qua prompt.

## Prompt hóa tác vụ

- Ví dụ:
  - `question: When is Pi Day? context: ... -> March 14`
  - `summarize: <bài viết>`
  - `translate English to German: <câu>`
- Định dạng thống nhất giúp mô hình chia sẻ biểu diễn giữa các nhiệm vụ.

## Quy mô dữ liệu

- Pre-train trên C4 (~800 GB) so với Wikipedia (~13 GB).
- Corpora lớn, sạch giúp tổng quát hóa tốt hơn.

## Lợi ích đa nhiệm

- Encoder-decoder dùng chung, chuyển giao giữa tác vụ tốt hơn.
- Cải thiện bài toán ít dữ liệu nhờ tín hiệu chéo tác vụ.

## Ghi chú thực tế

- Kiểm soát độ dài output bằng decoder max_length và repetition penalty.
- Với QA, prompt rõ ràng phần question và context.
- Fine-tune đa nhiệm: cân bằng tỉ lệ batch tránh một task lấn át.

---

## Việc thực hành hôm nay

- Soạn prompt cho QA và tóm tắt của bạn.
- Chọn kích thước model theo GPU (T5-small/base/large).
- Lập kế hoạch pha trộn tác vụ (tỉ lệ mỗi task) khi fine-tune.
