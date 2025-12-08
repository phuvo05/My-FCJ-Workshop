---
title: "Tuần 9 - Kiến Trúc & Triển Khai Transformer"
weight: 9
chapter: false
pre: "<b> 1.9. </b>"
---

**Tuần:** 2025-11-03 to 2025-11-07  
**Trạng Thái:** "Hoàn Thành"  

---

## Tóm Tắt Tuần 9

Tuần này khám phá kiến trúc **Transformer**, một mô hình cách mạng thay thế RNNs trong NLP. Chúng ta sẽ hiểu tại sao cần transformers, cách chúng hoạt động bên trong, và triển khai chúng từ đầu. Từ các cơ chế attention đến thiết kế encoder-decoder đầy đủ, tuần này kết nối lý thuyết và triển khai thực tế.

### Các Chủ Đề Chính

#### Hạn Chế của RNNs & Giới Thiệu Transformer
- Thắt cổ chai xử lý tuần tự trong RNNs
- Vấn đề Vanishing Gradient
- Thắt cổ chai thông tin với chuỗi dài
- Tại sao Attention là tất cả bạn cần

#### Kiến Trúc Transformer
- Cấu trúc Encoder-Decoder
- Lớp Multi-head Attention
- Positional Encoding
- Residual Connections & Layer Normalization
- Feed-forward Networks

#### Cơ Chế Attention
- Scale Dot-product Attention (cơ chế lõi)
- Self-attention (cùng một câu)
- Masked Attention (Decoder)
- Encoder-Decoder Attention
- Multi-head Attention để tính toán song song

#### Transformer Decoder & GPT2
- Positional Embeddings
- Decoder Block Implementation
- Feed-forward Layer Design
- Tính toán Xác suất Output

#### Ứng Dụng & Các Mô Hình
- GPT-2 (Generative Pre-trained Transformer)
- BERT (Bidirectional Encoder Representations)
- T5 (Text-to-Text Transfer Transformer)
- Ứng dụng: Dịch, Phân loại, QA, Tóm tắt, Phân tích Cảm xúc

### Mục Tiêu Học Tập

- ✅ Hiểu hạn chế của RNN và tại sao transformers giải quyết chúng
- ✅ Nắm bắt kiến trúc transformer hoàn chỉnh
- ✅ Triển khai các cơ chế attention từ đầu
- ✅ Xây dựng transformer decoder (kiểu GPT2)
- ✅ Nhận biết các ứng dụng transformer và các mô hình tiên tiến

---

## Chia Nhỏ Theo Ngày

| Ngày | Tập Trung | Chủ Đề |
|------|-----------|--------|
| 41 | Vấn Đề RNN | Xử lý tuần tự, Vanishing Gradients, Thắt cổ chai thông tin |
| 42 | Tổng Quan Kiến Trúc | Encoder-Decoder, Multi-head Attention, Positional Encoding |
| 43 | Lõi Attention | Công thức Scale Dot-product, Phép toán ma trận, Hiệu quả GPU |
| 44 | Các Loại Attention | Self-attention, Masked Attention, Encoder-Decoder Attention |
| 45 | Triển Khai Decoder | Kiến trúc GPT2, Các khối xây dựng, Hướng dẫn Code |

---

## Điều Kiện Tiên Quyết

- Hiểu biết sâu về RNNs, LSTMs, và attention từ Tuần 8
- Thoải mái với phép toán ma trận và đại số tuyến tính
- Kiến thức PyTorch hoặc TensorFlow rất hữu ích

## Các Bước Tiếp Theo

- Học bài báo "Attention is All You Need" (Vaswani et al., 2017)
- Triển khai các thành phần transformer từng bước
- Thử nghiệm với các mô hình được huấn luyện trước (BERT, GPT-2, T5)
