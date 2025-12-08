---
title: "Ngày 42 - Tổng Quan Kiến Trúc Transformer"
weight: 2
chapter: false
pre: "<b> 1.9.2. </b>"
---

**Ngày:** 2025-11-04 (Thứ Ba)  
**Trạng Thái:** "Hoàn Thành"  

---

# **Kiến Trúc Transformer: Bức Tranh Toàn Cảnh**

Mô hình transformer được giới thiệu trong bài báo "Attention is All You Need" đã cách mạng hóa NLP. Hãy hiểu cấu trúc hoàn chỉnh của nó.

---

# **Kiến Trúc Cấp Cao**

```
CỬA VÀO CHUỖI
      ↓
[Tokenization & Embedding]
      ↓
[Thêm Positional Encoding]
      ↓
┌─────────────────────────────────┐
│  ENCODER (N layers)             │
│  ├─ Multi-Head Attention        │
│  ├─ Layer Normalization         │
│  ├─ Feed-Forward Network        │
│  └─ Residual Connections        │
└─────────────────────────────────┘
      ↓
[Context Vectors từ Encoder]
      ↓
┌─────────────────────────────────┐
│  DECODER (N layers)             │
│  ├─ Masked Multi-Head Attention │
│  ├─ Encoder-Decoder Attention   │
│  ├─ Feed-Forward Network        │
│  └─ Layer Normalization         │
└─────────────────────────────────┘
      ↓
[Linear Layer + Softmax]
      ↓
ĐẦU RA XÁC SUẤT
```

---

# **Thành Phần 1: Word Embeddings**

Mỗi từ được chuyển đổi thành một vector dày đặc (thường là 512-1024 chiều).

**Ví Dụ:**
```
Từ: "happy"
Embedding: [0.2, -0.5, 0.8, ..., 0.1]  // 512 giá trị
```

---

# **Thành Phần 2: Positional Encoding**

**Vấn Đề:** Transformers không có thứ tự tuần tự được tích hợp sẵn (không giống RNNs). Vì vậy chúng ta phải thêm thông tin vị trí một cách rõ ràng.

**Giải Pháp:** Thêm các vector positional encoding vào embeddings.

**Công Thức:**
```
PE(pos, 2i) = sin(pos / 10000^(2i/d_model))
PE(pos, 2i+1) = cos(pos / 10000^(2i/d_model))

Trong đó:
- pos = vị trí trong chuỗi (0, 1, 2, ...)
- i = chỉ số chiều
- d_model = chiều embedding (512, 1024, v.v.)
```

**Ý Tưởng:**
- Vị trí 0: "I" nhận PE₀
- Vị trí 1: "am" nhận PE₁
- Vị trí 2: "happy" nhận PE₂

**Ví Dụ:**
```
Embedding("I") = [0.2, -0.5, 0.8, ..., 0.1]
PE(pos=0) = [0.0, 1.0, 0.0, 1.0, ..., 0.5]
Final = [0.2, 0.5, 0.8, 1.0, ..., 0.6]
```

---

# **Thành Phần 3: Multi-Head Attention**

Thay vì một cơ chế attention, chúng ta có **h "đầu" khác nhau** chạy song song.

**Khái Niệm:**
```
Đầu vào: Query (Q), Key (K), Value (V) matrices

Đầu 1: ScaledDotProductAttention(Q₁, K₁, V₁)
Đầu 2: ScaledDotProductAttention(Q₂, K₂, V₂)
...
Đầu h: ScaledDotProductAttention(Qₕ, Kₕ, Vₕ)

Đầu ra = Concatenate(Head₁, Head₂, ..., Headₕ)
```

**Tại Sao Nhiều Đầu?**
- Đầu 1 có thể học mối quan hệ "chủ ngữ-động từ"
- Đầu 2 có thể học mối quan hệ "tính từ-danh từ"
- Đầu 3 có thể học mối quan hệ "đại từ-tham chiếu"
- Cùng nhau: Hiểu biết ngữ cảnh phong phú

**Cấu Hình Điển Hình:**
- Số lượng đầu: 8-16
- Chiều trên mỗi đầu: 64 (nếu tổng = 512, thì 512/8 = 64)

---

# **Thành Phần 4: Residual Connections & Layer Normalization**

### Residual Connections
```
Đầu ra = Đầu vào + Attention(Đầu vào)
```

Điều này giúp luồng gradient trong suốt huấn luyện và cho phép mạng lưới đi sâu hơn.

### Layer Normalization
```
Normalized = (x - mean) / sqrt(variance + epsilon)
```

Ổn định huấn luyện và tăng tốc độ hội tụ.

---

# **Thành Phần 5: Feed-Forward Network**

Sau attention, có một mạng feed-forward 2 lớp đơn giản:

```
Đầu ra = ReLU(Linear₁(x)) → Linear₂
```

Các chiều điển hình:
```
Đầu vào: [batch_size, seq_length, 512]
       ↓ Linear₁ (512 → 2048)
     [batch_size, seq_length, 2048]
       ↓ ReLU (non-linear)
     [batch_size, seq_length, 2048]
       ↓ Linear₂ (2048 → 512)
     [batch_size, seq_length, 512]
```

Điều này mở rộng rồi co lại, cho phép các phép biến đổi phi tuyến.

---

# **Encoder: Chế Độ Xem Chi Tiết**

**Lớp Encoder Duy Nhất:**
```
Đầu vào (x)
  ↓
[Multi-Head Self-Attention]
  ↓
[+ Residual Connection với đầu vào]
  ↓
[Layer Normalization]
  ↓
[Feed-Forward Network]
  ↓
[+ Residual Connection]
  ↓
[Layer Normalization]
  ↓
Đầu ra
```

**Điểm Chính:** Trong encoder, **mỗi từ attend tới TẤT CẢ các từ** (bao gồm cả chính nó) trong cùng một câu.

**Encoder cho:** Đại diện ngữ cảnh của mỗi từ, xem xét tất cả các từ khác.

---

# **Decoder: Chế Độ Xem Chi Tiết**

Decoder tương tự nhưng với **masking**:

```
Đầu vào (shifted right by 1)
  ↓
[Masked Multi-Head Self-Attention]  ← Chỉ có thể attend vào các vị trí trước
  ↓
[+ Residual + LayerNorm]
  ↓
[Encoder-Decoder Attention]  ← Attend vào đầu ra encoder
  ↓
[+ Residual + LayerNorm]
  ↓
[Feed-Forward Network]
  ↓
[+ Residual + LayerNorm]
  ↓
Đầu ra
```

**Ba Cơ Chế Attention trong Decoder:**

1. **Masked Self-Attention:**
   - Queries, Keys, Values từ decoder
   - Mỗi vị trí chỉ có thể attend tới **các vị trí trước đó**
   - Ngăn chặn rò rỉ thông tin (decoder không thấy các từ tương lai)

2. **Encoder-Decoder Attention:**
   - Queries từ decoder
   - Keys, Values từ encoder
   - Decoder có thể attend tới bất kỳ vị trí encoder nào

3. **Feed-Forward:**
   - Mạng 2 lớp giống như encoder

---

# **Kết Hợp Tất Cả: Transformer Đầy Đủ**

### Giai Đoạn Huấn Luyện

```
Đầu vào: "Je suis heureux" (Tiếng Pháp)
Mục Tiêu: "I am happy" (Tiếng Anh)

Đầu vào Encoder:
  - Tokenize: [Je, suis, heureux]
  - Embed mỗi token
  - Thêm positional encoding
  - Xử lý qua N lớp encoder
  → Đầu ra: C (context vectors)

Đầu vào Decoder:
  - Mục tiêu shifted right: [<START>, I, am]
  - Embed mỗi token
  - Thêm positional encoding
  - Xử lý qua N lớp decoder
    - Sử dụng masked self-attention
    - Sử dụng encoder-decoder attention trên C
  → Đầu ra logits cho mỗi vị trí

Mất mát: So sánh dự đoán "am happy" với thực tế "am happy"
Backprop: Cập nhật tất cả các trọng số
```

### Giai Đoạn Suy Luận

```
Đầu vào Encoder: [Je, suis, heureux]
→ Đầu ra: C (context vectors)

Decoder:
Bước 1: Bắt đầu với [<START>]
        Dự đoán từ tiếp theo: "I"
Bước 2: [<START>, I] 
        Dự đoán từ tiếp theo: "am"
Bước 3: [<START>, I, am]
        Dự đoán từ tiếp theo: "happy"
Bước 4: [<START>, I, am, happy]
        Dự đoán từ tiếp theo: <END>

Đầu ra: "I am happy"
```

---

# **Tóm Tắt: Tại Sao Kiến Trúc Này Hoạt Động**

| Tính Năng | Lợi Ích |
|----------|---------|
| **Không RNN** | Hoàn toàn có thể song song hóa - huấn luyện trên GPU hiệu quả |
| **Self-Attention trong Encoder** | Mỗi từ nhận ngữ cảnh từ TẤT CẢ các từ khác |
| **Masked Attention trong Decoder** | Không thể nhìn thấy tương lai - huấn luyện với tạo hình autoregressive |
| **Positional Encoding** | Bảo tồn thứ tự từ mà không xử lý tuần tự RNN |
| **Multi-Head Attention** | Học nhiều loại mối quan hệ đồng thời |
| **Residual Connections** | Luồng gradient - cho phép huấn luyện mạng sâu |
| **Layer Normalization** | Ổn định - hội tụ nhanh hơn |

---

# **Các Đổi Mới Chính**

1. **Song Song Hóa:** O(1) độ sâu thay vì O(n) cho RNNs
2. **Phụ Thuộc Dài Hạn:** Attention có thể kết nối trực tiếp bất kỳ hai vị trí nào
3. **Khả Năng Mở Rộng:** Có thể tăng kích thước mô hình với cải thiện dự đoán
4. **Transfer Learning:** Các transformer được huấn luyện trước (BERT, GPT) hoạt động trên các tác vụ


