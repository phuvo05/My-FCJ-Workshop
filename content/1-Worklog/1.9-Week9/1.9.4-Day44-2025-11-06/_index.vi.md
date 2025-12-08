---
title: "Ngày 44 - Các Loại Attention: Self, Masked, Encoder-Decoder"
weight: 4
chapter: false
pre: "<b> 1.9.4. </b>"
---

**Ngày:** 2025-11-06 (Thứ Năm)  
**Trạng Thái:** "Hoàn Thành"  

---

# **Ba Loại Attention trong Transformers**

Transformer sử dụng attention theo ba cách khác nhau. Hiểu biết từng cách là rất quan trọng.

---

# **Loại 1: Self-Attention (Encoder)**

**Định Nghĩa:** Mỗi vị trí attend tới **tất cả các vị trí trong chuỗi tương tự**.

**Trường Hợp Sử Dụng:** Trong encoder, chúng ta muốn mỗi từ hiểu bối cảnh của nó bằng cách nhìn vào tất cả các từ khác.

**Ví Dụ:**
```
Câu: "The cat sat on the mat"

Cho từ "cat":
- Attend tới "The": 0.15 (mạo từ)
- Attend tới "cat": 0.40 (chính nó)
- Attend tới "sat": 0.20 (động từ)
- Attend tới "on": 0.10
- Attend tới "the": 0.08
- Attend tới "mat": 0.07

Kết quả: Ngữ cảnh "cat" = kết hợp có trọng số của cả 6 từ
```

**Tại Sao Hữu Ích:**
- Nắm bắt ngữ cảnh câu đầy đủ
- Có thể xác định các mối quan hệ (chủ ngữ-động từ, tính từ-danh từ, v.v.)
- Mỗi từ nhận thông tin từ toàn bộ câu

**Triển Khai:**
```
Q = K = V = Đầu vào  (cùng một nguồn!)

attention(Q, K, V) = softmax(Q×K^T / √d_k) × V
```

Vì Q, K, V đến từ cùng một nơi, nó được gọi là "self-attention".

---

# **Loại 2: Masked Self-Attention (Decoder)**

**Vấn Đề:** Trong quá trình huấn luyện, nếu decoder có thể "nhìn thấy" các từ tương lai, nó gian lận!

**Ví Dụ - Vấn Đề:**
```
Tác Vụ: Dịch "Je suis heureux" → "I am happy"

Huấn Luyện:
Bước 1: Dự đoán "am" bằng cách sử dụng... "am" (nó có thể nhìn thấy câu trả lời!)
Bước 2: Dự đoán "happy" bằng cách sử dụng "I am happy" (biết câu trả lời!)
Bước 3: Dự đoán "happy" đã xong (gian lận!)

Kết Quả: Mô hình huấn luyện hoàn hảo nhưng thất bại vào thời gian kiểm tra!
```

**Giải Pháp:** Che (ẩn) các vị trí tương lai trong quá trình self-attention.

**Masked Self-Attention:**
```
Thay vì:             Chúng ta làm:
[0.30, 0.33, 0.37]   [0.30, -∞, -∞]
[0.26, 0.37, 0.37] → [0.26, 0.37, -∞]
[0.25, 0.36, 0.39]   [0.25, 0.36, 0.39]

Sau softmax:
[1.00, 0.00, 0.00]
[0.30, 0.70, 0.00]
[0.25, 0.36, 0.39]

(chuẩn hóa)
```

**Ma Trận Mask:**
```
Mask = [1, 0, 0]
       [1, 1, 0]
       [1, 1, 1]

Hoặc: -∞ cho các vị trí được che
```

**Hiệu Ứng:**
```
Vị Trí 0: Attend tới vị trí 0 chỉ
Vị Trí 1: Attend tới vị trí 0, 1 chỉ
Vị Trí 2: Attend tới vị trí 0, 1, 2

Decoder chỉ có thể sử dụng thông tin quá khứ!
```

**Tại Sao Điều Này Hoạt Động:**
- Trong quá trình huấn luyện, có thể sử dụng tạo hình autoregressive
- Trong quá trình suy luận, tạo từ từng từ một một cách tự nhiên
- Ngăn chặn mô hình "nhìn thấy câu trả lời"

---

# **Loại 3: Encoder-Decoder Attention**

**Mục Đích:** Decoder attend tới đầu ra encoder.

**Ví Dụ:**
```
Encoder xử lý: "Je suis heureux" (Tiếng Pháp)
Tạo ra: Context vectors C

Decoder xử lý: "" (bắt đầu rỗng)
Để tạo ra từ đầu tiên:
- Query: từ decoder (tôi nên dịch cái gì?)
- Key, Value: từ encoder (tôi nên nhìn vào các từ tiếng Pháp nào?)

Kết Quả: Decoder attend tới các từ tiếng Pháp để tạo ra tiếng Anh
```

**Khác Biệt Chính So Với Self-Attention:**
```
Self-Attention:              Encoder-Decoder:
Q, K, V đều từ đầu vào       Q từ decoder
Cùng chuỗi                   K, V từ encoder

Attend trong bản thân        Attend tới chuỗi khác
```

**Trường Hợp Sử Dụng:**
- Decoder nhìn lại đầu ra encoder
- Cho phép dịch: Tiếng Pháp → Tiếng Anh
- Cho phép tóm tắt: Tài Liệu → Tóm Tắt
- Nói chung hữu ích cho các tác vụ seq2seq

---

# **So Sánh: Cả Ba Loại**

| Loại | Nguồn Q | Nguồn K, V | Mục Đích |
|------|---------|-----------|---------|
| **Self-Attention** | Đầu vào | Đầu vào | Hiểu ngữ cảnh trong chuỗi tương tự |
| **Masked Self-Attention** | Đầu vào | Đầu vào (tương lai che) | Tạo hình autoregressive, ngăn gian lận |
| **Encoder-Decoder** | Decoder | Encoder | Hiểu xuyên chuỗi |

---

# **Masked Attention Chi Tiết**

### Toán Học

**Trước khi che:**
```
Attention = softmax(Q×K^T / √d_k) × V
```

**Với che:**
```
Scores = Q×K^T / √d_k

Ma trận Mask M:
M[i,j] = 0 nếu j <= i (được phép)
M[i,j] = -∞ nếu j > i (che tương lai)

Masked_scores = Scores + M

Attention = softmax(Masked_scores) × V
```

### Ví Dụ với Các Số Thực

**Điểm attention gốc (3×3):**
```
[0.1, 0.2, 0.3]
[0.4, 0.5, 0.6]
[0.7, 0.8, 0.9]
```

**Ma trận mask:**
```
[0,  -∞, -∞]
[0,   0, -∞]
[0,   0,  0]
```

**Sau khi thêm mask:**
```
[0.1, -∞, -∞]
[0.4, 0.5, -∞]
[0.7, 0.8, 0.9]
```

**Sau softmax (áp dụng exp và chuẩn hóa):**
```
exp(0.1) / exp(0.1) = 1.0, softmax([0.1]) = [1.0]
Vì vậy:
Hàng 0: [1.0, 0, 0]

exp(0.4) ≈ 1.49, exp(0.5) ≈ 1.65
Hàng 1: [1.49/(1.49+1.65), 1.65/(1.49+1.65), 0] ≈ [0.47, 0.53, 0]

Hàng 2: softmax([0.7, 0.8, 0.9])  (tất cả được phép)
```

**Trọng số attention cuối cùng:**
```
[1.0, 0.0, 0.0]
[0.47, 0.53, 0.0]
[0.25, 0.33, 0.42]
```

**Hiểu Biết Chính:** Vị trí 2 chỉ có thể sử dụng thông tin từ các vị trí 0, 1, 2 (không phải tương lai)

---

# **Luồng Attention Transformer Hoàn Chỉnh**

```
ĐẦU VÀO: "Je suis heureux"
  ↓
CÁC LỚP ENCODER (lặp 6 lần):
  ├─ Self-Attention: Mỗi từ tiếng Pháp attend tới tất cả các từ tiếng Pháp
  ├─ Feed-Forward
  → Đầu ra: C (vector ngữ cảnh tiếng Pháp)

CÁC LỚP DECODER (lặp 6 lần):
  ├─ Masked Self-Attention: Mỗi từ được tạo attend tới các từ trước đó
  ├─ Encoder-Decoder Attention: Từ được tạo attend tới ngữ cảnh tiếng Pháp
  ├─ Feed-Forward
  → Đầu ra: Logits cho dự đoán từ tiếp theo

ĐẦU RA: "I am happy"
```

---

# **Những Hiểu Biết Chính**

✅ **Self-Attention:** Hiểu lưỡng chiều (encoder)
✅ **Masked Attention:** Tạo hình một chiều (decoder)
✅ **Encoder-Decoder:** Chuyển giao xuyên chuỗi
✅ **Masking ngăn gian lận:** Mô hình không thể sử dụng thông tin tương lai

---

# **Tại Sao Không Luôn Sử Dụng Cả Ba?**

- **BERT (Encoder-only):** Chỉ sử dụng self-attention (lưỡng chiều, tốt cho phân loại)
- **GPT (Decoder-only):** Chỉ sử dụng masked self-attention (autoregressive, tốt cho tạo hình)
- **T5 (Đầy Đủ):** Sử dụng cả ba (cân bằng, tốt cho seq2seq)

---

# **Tiếp Theo: Triển Khai**

Bây giờ chúng ta hiểu ba loại attention, chúng ta sẽ thấy cách triển khai chúng trong code!
