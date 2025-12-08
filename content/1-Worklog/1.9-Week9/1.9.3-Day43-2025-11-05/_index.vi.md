---
title: "Ngày 43 - Sâu Hơn Về Scaled Dot-Product Attention"
weight: 3
chapter: false
pre: "<b> 1.9.3. </b>"
---

**Ngày:** 2025-11-05 (Thứ Tư)  
**Trạng Thái:** "Hoàn Thành"  

---

# **Scaled Dot-Product Attention: Cơ Chế Lõi**

Đây là **tim và linh hồn** của transformers. Hiểu biết sâu về điều này là rất quan trọng.

---

# **Công Thức Attention**

```
           (Q × K^T)
Attention(Q, K, V) = softmax(─────────) × V
                      √(d_k)
```

Trong đó:
- **Q** = ma trận Query (chúng ta đang tìm kiếm cái gì?)
- **K** = ma trận Key (chúng ta có thể attend tới cái gì?)
- **V** = ma trận Value (chúng ta nhận được thông tin gì?)
- **d_k** = chiều của keys (thường là 64)

---

# **Tính Toán Từng Bước**

Hãy tính toán attention cho một ví dụ đơn giản:

**Câu Đầu Vào:** "I am happy"

### Giai Đoạn Thiết Lập

**Bước 1: Tạo Word Embeddings**
```
I:      [0.1, 0.2, 0.3]
am:     [0.4, 0.5, 0.6]
happy:  [0.7, 0.8, 0.9]
```

**Bước 2: Chuyển Đổi Thành Q, K, V**
Trong thực tế, chúng ta học các phép chiếu tuyến tính:
```
Q = Embedding × W_q
K = Embedding × W_k
V = Embedding × W_v
```

Để đơn giản, hãy nói rằng:
```
Q = [0.1, 0.2, 0.3]    K = [0.1, 0.2, 0.3]    V = [0.1, 0.2, 0.3]
    [0.4, 0.5, 0.6]        [0.4, 0.5, 0.6]        [0.4, 0.5, 0.6]
    [0.7, 0.8, 0.9]        [0.7, 0.8, 0.9]        [0.7, 0.8, 0.9]
```

(Trong thực tế, Q, K, V sẽ là các phép chiếu khác nhau, nhưng điều này cho thấy khái niệm)

### Giai Đoạn Tính Toán

**Bước 3: Tính Q × K^T (dot products)**

```
Q × K^T = [0.1, 0.2, 0.3]   [0.1, 0.4, 0.7]
          [0.4, 0.5, 0.6] × [0.2, 0.5, 0.8]
          [0.7, 0.8, 0.9]   [0.3, 0.6, 0.9]

Q₁·K₁ = 0.1×0.1 + 0.2×0.2 + 0.3×0.3 = 0.01 + 0.04 + 0.09 = 0.14
Q₁·K₂ = 0.1×0.4 + 0.2×0.5 + 0.3×0.6 = 0.04 + 0.10 + 0.18 = 0.32
Q₁·K₃ = 0.1×0.7 + 0.2×0.8 + 0.3×0.9 = 0.07 + 0.16 + 0.27 = 0.50

Ma trận kết quả:
[0.14, 0.32, 0.50]
[0.32, 0.77, 1.22]
[0.50, 1.22, 1.94]
```

**Diễn Giải:**
- Q₁ (query cho "I") có điểm tương tự: [0.14, 0.32, 0.50]
  - 0.14 với "I" chính nó
  - 0.32 với "am"
  - 0.50 với "happy"

**Bước 4: Tỷ Lệ Theo √d_k**

d_k = 3 (chiều embedding), vì vậy √d_k = √3 ≈ 1.73

```
Ma trận được tỷ lệ = Q×K^T / √3:
[0.14/1.73, 0.32/1.73, 0.50/1.73]     [0.08, 0.18, 0.29]
[0.32/1.73, 0.77/1.73, 1.22/1.73]  =  [0.18, 0.44, 0.70]
[0.50/1.73, 1.22/1.73, 1.94/1.73]     [0.29, 0.70, 1.12]
```

**Tại Sao Tỷ Lệ?** 
- Khi d_k lớn (ví dụ: 64), dot products trở nên rất lớn
- Các số lớn khiến softmax có gradient rất nhỏ (bão hòa)
- Tỷ lệ theo √d_k giữ các số trong phạm vi hợp lý để huấn luyện

**Bước 5: Áp Dụng Softmax**

Softmax chuyển đổi điểm thành xác suất (tổng bằng 1):

```
softmax(x) = exp(x) / sum(exp(x))

Cho hàng đầu tiên [0.08, 0.18, 0.29]:
exp(0.08) ≈ 1.083
exp(0.18) ≈ 1.197
exp(0.29) ≈ 1.336
Tổng ≈ 3.616

Xác suất:
[1.083/3.616, 1.197/3.616, 1.336/3.616] ≈ [0.30, 0.33, 0.37]
```

**Cả ba hàng:**
```
Trọng số Softmax (ma trận attention):
[0.30, 0.33, 0.37]
[0.26, 0.37, 0.37]
[0.25, 0.36, 0.39]
```

**Diễn Giải:**
- Từ "I" chi 30% sự chú ý cho chính nó, 33% cho "am", 37% cho "happy"
- Từ "am" chi 26% sự chú ý cho "I", 37% cho chính nó, 37% cho "happy"
- Từ "happy" chi 25% cho "I", 36% cho "am", 39% cho chính nó

**Bước 6: Nhân Với Ma Trận Value (V)**

```
Context = Softmax_weights × V

Context(cho "I"):     0.30×[0.1,0.2,0.3] + 0.33×[0.4,0.5,0.6] + 0.37×[0.7,0.8,0.9]
                    = [0.03,0.06,0.09] + [0.13,0.17,0.20] + [0.26,0.30,0.33]
                    = [0.42, 0.53, 0.62]

Context(cho "am"):    0.26×[0.1,0.2,0.3] + 0.37×[0.4,0.5,0.6] + 0.37×[0.7,0.8,0.9]
                    = [0.026,0.052,0.078] + [0.148,0.185,0.222] + [0.259,0.296,0.333]
                    = [0.433, 0.533, 0.633]

Context(cho "happy"): 0.25×[0.1,0.2,0.3] + 0.36×[0.4,0.5,0.6] + 0.39×[0.7,0.8,0.9]
                    = [0.025,0.05,0.075] + [0.144,0.18,0.216] + [0.273,0.312,0.351]
                    = [0.442, 0.542, 0.642]
```

**Ma Trận Context Đầu Ra:**
```
[0.42, 0.53, 0.62]
[0.433, 0.533, 0.633]
[0.442, 0.542, 0.642]
```

Mỗi từ bây giờ có một **vector ngữ cảnh** kết hợp thông tin từ tất cả các từ được tính trọng số bằng điểm attention!

---

# **Tại Sao Scaled Dot-Product Attention?**

| Khía Cạnh | Lý Do |
|-----------|--------|
| **Dot Product** | Thước đo tương tự hiệu quả (chỉ là phép nhân ma trận) |
| **Scaling** | Ngăn chặn bão hòa softmax (giữ gradient khỏe mạnh) |
| **Softmax** | Chuyển đổi tương tự thành trọng số chuẩn hóa [0,1] |
| **Nhân Với V** | Lấy thông tin thực tế (kết hợp có trọng số) |

---

# **Multi-Head Attention: Nhiều Quan Điểm**

Thay vì một đầu attention, chúng ta sử dụng **h = 8 (hoặc nhiều hơn)** đầu attention:

```
MultiHeadAttention(Q, K, V) = Concat(Head₁, ..., Head₈) × W_o

Trong đó:
Head_i = Attention(Q × W_q^i, K × W_k^i, V × W_v^i)
```

**Các đầu khác nhau học các mối quan hệ khác nhau:**
- Đầu 1: Mối quan hệ chủ ngữ-động từ
- Đầu 2: Mối quan hệ tính từ-danh từ
- Đầu 3: Mối quan hệ đại từ-tham chiếu
- Đầu 4-8: Các mô hình ngữ nghĩa khác

**Ví Dụ:**
```
Câu: "The quick brown fox jumps over the lazy dog"

Đầu 1 (chủ ngữ-động từ):
  - "fox" → "jumps": 0.9
  - "dog" → has_property: 0.7

Đầu 2 (tính từ-danh từ):
  - "quick" → "fox": 0.85
  - "brown" → "fox": 0.8
  - "lazy" → "dog": 0.9

Đầu 3 (không gian):
  - "over" → kết nối "fox" và "dog": 0.8
```

Tất cả các quan điểm khác nhau này kết hợp lại tạo ra sự hiểu biết ngữ cảnh phong phú.

---

# **Hiệu Quả Tính Toán**

**Tại sao scaled dot-product attention lại hiệu quả đến vậy?**

1. **Phép Toán Ma Trận:** Chỉ là phép nhân và softmax (GPU-optimized)
2. **Có Thể Song Song Hóa:** Có thể xử lý toàn bộ chuỗi cùng lúc
3. **Tiết Kiệm Bộ Nhớ:** Bộ nhớ O(n²) cho chuỗi độ dài n (chấp nhận được)
4. **Huấn Luyện Nhanh:** GPU hiện đại có thể thực hiện hàng tỷ dot products/giây

**So Sánh:**
- RNN: O(n) bước tuần tự → chậm
- Attention: O(1) độ sâu, O(n²) bộ nhớ → nhanh!

---

# **Những Hiểu Biết Chính**

✅ **Attention được học:** W_q, W_k, W_v là các tham số có thể huấn luyện
✅ **Không phụ thuộc vị trí:** Không có phụ thuộc tuần tự - có thể attend trên bất kỳ khoảng cách nào
✅ **Có thể Diễn Giải:** Có thể hình dung các từ nào attend tới từ nào
✅ **Hiệu Quả:** Chỉ sử dụng phép toán ma trận (GPU-friendly)

---

# **Bước Tiếp Theo**

Bây giờ chúng ta hiểu scaled dot-product attention, chúng ta sẽ khám phá:
1. Self-attention (query=key=value)
2. Masked attention (decoder chỉ nhìn thấy quá khứ)
3. Encoder-decoder attention (kết nối xuyên ngôn ngữ)
4. Chi tiết Multi-head attention (học nhiều mô hình)
