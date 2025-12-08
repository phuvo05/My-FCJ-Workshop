---
title: "Ngày 41 - Vấn Đề RNN & Tại Sao Cần Transformers"
weight: 1
chapter: false
pre: "<b> 1.9.1. </b>"
---

**Ngày:** 2025-11-03 (Thứ Hai)  
**Trạng Thái:** "Hoàn Thành"  

---

# **Vấn Đề với RNNs: Thắt Cổ Chai Xử Lý Tuần Tự**

RNNs đã thống trị NLP trong những năm qua, nhưng chúng có những hạn chế cơ bản mà transformers giải quyết. Hãy khám phá những vấn đề này.

## **Vấn Đề 1: Tính Toán Tuần Tự**

### Cách RNNs Xử Lý Thông Tin

RNNs phải xử lý đầu vào **từng bước một**, theo tuần tự:

**Ví Dụ Dịch (Tiếng Anh → Tiếng Pháp):**
```
Đầu vào: "I am happy"

Bước Thời Gian 1: Xử lý "I"
Bước Thời Gian 2: Xử lý "am" 
Bước Thời Gian 3: Xử lý "happy"
```

**Tác Động:**
- Nếu câu của bạn có 5 từ → cần 5 bước tuần tự
- Nếu câu của bạn có 1000 từ → cần 1000 bước tuần tự
- **Không thể song song hóa!** Phải đợi bước t-1 trước khi tính bước t

### Tại Sao Điều Này Quan Trọng

- GPU và TPU hiện đại được thiết kế cho **tính toán song song**
- RNNs tuần tự không thể tận dụng song song hóa này
- Huấn luyện trở nên **chậm hơn nhiều** so với cần thiết
- Chuỗi dài hơn = thời gian huấn luyện dài hơn theo hàm mũ

---

## **Vấn Đề 2: Vanishing Gradient Problem**

### Nguyên Nhân Gốc Rễ

Khi RNNs backpropagate qua nhiều time step, gradients được nhân lặp đi lặp lại:

**Luồng Gradient Qua T Bước:**
```
∂Loss/∂h₀ = ∂Loss/∂hₜ × (∂hₜ/∂hₜ₋₁) × (∂hₜ₋₁/∂hₜ₋₂) × ... × (∂h₁/∂h₀)
```

Nếu mỗi ∂hᵢ/∂hᵢ₋₁ < 1 (điều này thường xảy ra):
- Sau T phép nhân: gradient ≈ 0.5^100 ≈ 0 (với T=100)
- Gradient **biến mất thành không**
- Mô hình không thể học các phụ thuộc dài hạn

### Ví Dụ Cụ Thể

**Câu:** "The students who studied hard... passed the exam"

- Từ đầu "students" cần ảnh hưởng đến dự đoán "passed"
- Nhưng gradient đã biến mất khi tiếp cận "students"
- Mô hình không học được mối quan hệ này!

### Giải Pháp Hiện Tại

LSTMs và GRUs **giúp một chút** với gates, nhưng:
- Vẫn có vấn đề với chuỗi rất dài (>100-200 từ)
- Không thể hoàn toàn giải quyết vấn đề
- Vẫn yêu cầu xử lý tuần tự

---

## **Vấn Đề 3: Thắt Cổ Chai Thông Tin**

### Vấn Đề Nén Dữ Liệu

**Kiến Trúc Sequence-to-Sequence:**
```
Encoder: Word₁ → h₁ → h₂ → h₃ → hₜ (hidden state cuối cùng)
Decoder: hₜ → Word₁' → Word₂' → Word₃' → ...
```

**Thắt Cổ Chai:**
Tất cả thông tin từ toàn bộ chuỗi đầu vào được nén vào **một vector duy nhất** `hₜ` (hidden state cuối cùng).

### Tại Sao Điều Này Không Hoạt Động

**Ví Dụ Câu:** "The government of the United States of America announced..."

Khi mã hóa câu 8 từ này:
- Từ đầu tiên "The" được xử lý
- Thông tin chảy qua các state: h₁ → h₂ → h₃ → ... → h₈
- Bởi h₈, thông tin về "The" đã bị pha loãng/mất
- Chỉ h₈ được truyền đến decoder
- Decoder có thông tin ngữ cảnh hạn chế về các từ đầu

### Hậu Quả

- **Chuỗi dài mất thông tin**
- Ngữ cảnh quan trọng ở đầu bị pha loãng
- Mô hình gặp khó khăn với tài liệu dài
- Chất lượng dịch giảm cho các câu dài

---

## **Tóm Tắt: Tại Sao RNNs Có Những Vấn Đề Cơ Bản**

| Vấn Đề | Tác Động | Giải Pháp Hiện Tại |
|--------|----------|-------------------|
| **Xử Lý Tuần Tự** | Không thể song song hóa, đào tạo chậm | N/A - Cơ bản của thiết kế RNN |
| **Vanishing Gradients** | Không thể học phụ thuộc dài hạn | LSTM/GRU gates (sửa chữa một phần) |
| **Thắt Cổ Chai Thông Tin** | Thông tin sớm bị mất | Cơ chế Attention (sửa chữa một phần) |

---

# **Giải Pháp Transformer: "Attention is All You Need"**

Giới thiệu năm 2017 bởi các nhà nghiên cứu Google (Vaswani et al.), **transformers** hoàn toàn thay thế RNNs bằng các cơ chế attention.

## **Những Khác Biệt Chính**

| Khía Cạnh | RNNs | Transformers |
|-----------|------|--------------|
| **Xử Lý** | Tuần tự (từng từ một lần) | **Song Song** (tất cả từ cùng lúc) |
| **Phụ Thuộc** | Mỗi từ phụ thuộc vào state trước | Tất cả từ attend tới tất cả từ |
| **Tốc Độ Huấn Luyện** | Chậm (tuần tự) | **Nhanh** (song song) |
| **Chuỗi Dài** | Vanishing gradients | Không thắt cổ chai tuần tự |
| **Phụ Thuộc Dài Hạn** | Khó khăn | Dễ dàng (attention trực tiếp) |

## **Cách Transformers Hoạt Động (Tóm Tắt Ngắn)**

1. **Không RNN:** Loại bỏ hoàn toàn các hidden state tuần tự
2. **Attention Thuần:** Để mỗi từ "attend tới" tất cả các từ khác
3. **Positional Encoding:** Thêm thông tin vị trí vì chúng ta không có thứ tự tuần tự
4. **Xử Lý Song Song:** Xử lý toàn bộ chuỗi cùng lúc

**Ví Dụ:**
```
Câu: "I am happy"

Thay vì:
Bước 1: Xử lý "I" → h₁
Bước 2: Xử lý "am" với h₁ → h₂
Bước 3: Xử lý "happy" với h₂ → h₃

Transformer Làm:
Song Song: "I" attend tới {"I", "am", "happy"}
Song Song: "am" attend tới {"I", "am", "happy"}
Song Song: "happy" attend tới {"I", "am", "happy"}
Tất cả cùng lúc! 
```

---

## **Tại Sao Mọi Người Nói Về Transformers**

**Tốc Độ:** Có thể huấn luyện nhanh hơn trên GPU/TPU (song parallel)
**Khả Năng Mở Rộng:** Có thể xử lý chuỗi rất dài (không thắt cổ chai)
**Dài Hạn:** Attention trực tiếp giải quyết các vấn đề gradient
**Tính Linh Hoạt:** Hoạt động cho dịch, phân loại, QA, tóm tắt, chatbots...
**Hiệu Năng:** Đạt kết quả tiên tiến trên gần như mọi tác vụ NLP

---

## **Ứng Dụng của Transformers**

Transformers được sử dụng cho:

1. **Dịch** (Neural Machine Translation) - Chất lượng cao, nhanh
2. **Tóm Tắt Văn Bản** (Abstractive & Extractive)
3. **Named Entity Recognition** (NER) - Nhận dạng thực thể tốt hơn
4. **Hỏi Đáp** - Hiểu ngữ cảnh tốt hơn
5. **Chatbots & Trợ Lý Thoại**
6. **Phân Tích Cảm Xúc** - Hiểu cảm xúc/ý kiến
7. **Tự Động Hoàn Thành** - Đề xuất thông minh
8. **Phân Loại** - Phân loại văn bản vào các danh mục
9. **Trí Tuệ Thị Trường** - Phân tích cảm xúc thị trường

---

## **Các Mô Hình Transformer Tiên Tiến Nhất**

### **GPT-2** (Generative Pre-trained Transformer)
- Tạo bởi: OpenAI
- Loại: Decoder-only transformer
- Chuyên môn: Tạo văn bản
- Nổi tiếng vì: Tạo văn bản giống con người (thậm chí đánh lừa các nhà báo năm 2019!)

### **BERT** (Bidirectional Encoder Representations from Transformers)
- Tạo bởi: Google AI
- Loại: Encoder-only transformer
- Chuyên môn: Hiểu văn bản & đại diện
- Sử dụng: Phân loại, NER, QA

### **T5** (Text-to-Text Transfer Transformer)
- Tạo bởi: Google
- Loại: Full encoder-decoder (giống transformer gốc)
- Chuyên môn: Học đa tác vụ
- Rất linh hoạt: Một mô hình xử lý dịch, phân loại, QA, tóm tắt, hồi quy

---

