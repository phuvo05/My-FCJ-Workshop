---
title: "Ngày 40 - Đánh Giá MT & Chiến Lược Decoding"
weight: 5
chapter: false
pre: "<b> 1.8.5. </b>"
---

**Ngày:** 2025-10-31 (Thứ Sáu)  
**Trạng Thái:** "Hoàn Thành"  

---

# **Điểm BLEU – Đánh Giá Dựa Trên Precision**

**BLEU (Bilingual Evaluation Understudy)** là thuật toán được thiết kế để đánh giá chất lượng dịch máy.

## Cách BLEU Hoạt Động

**Khái Niệm Cốt Lõi:** So sánh bản dịch ứng viên với một hoặc nhiều bản dịch tham chiếu (thường là bản dịch của con người)

**Phạm Vi Điểm:** 0 đến 1
- Gần 1 = bản dịch tốt hơn
- Gần 0 = bản dịch tệ hơn

---

## Tính Toán Điểm BLEU

### BLEU Vanilla (Có Vấn Đề)

**Ví Dụ:**
- Ứng viên: "I I am I"
- Tham chiếu 1: "Eunice said I'm hungry"
- Tham chiếu 2: "He said I'm hungry"

**Quy Trình:**
1. Đếm có bao nhiêu từ của ứng viên xuất hiện trong bất kỳ tham chiếu nào
2. Chia cho tổng số từ của ứng viên

Kết quả: 4/4 = **1.0** (điểm hoàn hảo!)

**Vấn Đề:** Bản dịch này tệ nhưng lại được điểm hoàn hảo! Một mô hình chỉ xuất ra các từ phổ biến sẽ đạt điểm tốt.

---

### BLEU Được Sửa Đổi (Tốt Hơn)

**Thay Đổi Chính:** Sau khi khớp một từ, **loại bỏ nó** khỏi tham chiếu

**Ví Dụ Tương Tự:**
1. "I" (đầu tiên) → khớp → loại bỏ "I" khỏi tham chiếu → đếm = 1
2. "I" (thứ hai) → không còn khớp → đếm = 1
3. "am" → khớp → loại bỏ "am" → đếm = 2
4. "I" (thứ ba) → không còn khớp → đếm = 2

Kết quả: 2/4 = **0.5** (thực tế hơn!)

---

## Hạn Chế của BLEU

**❌ Không xem xét ý nghĩa ngữ nghĩa**
- Chỉ kiểm tra khớp từ

**❌ Không xem xét cấu trúc câu**
- "Ate I was hungry because" vs "I ate because I was hungry"
- Cả hai đều được điểm giống nhau!

**✅ Vẫn là metric được áp dụng rộng rãi nhất** mặc dù có hạn chế

---

# **Điểm ROUGE – Đánh Giá Dựa Trên Recall**

**ROUGE (Recall-Oriented Understudy for Gisting Evaluation)**

## BLEU vs ROUGE

| Metric | Tập Trung | Tính Toán |
|--------|-----------|-----------|
| BLEU | Precision | Bao nhiêu từ ứng viên có trong tham chiếu? |
| ROUGE | Recall | Bao nhiêu từ tham chiếu có trong ứng viên? |

---

## Tính Toán Điểm ROUGE-N

**Ví Dụ:**
- Ứng viên: "I I am I"
- Tham chiếu 1: "Younes said I am hungry" (5 từ)
- Tham chiếu 2: "He said I'm hungry" (5 từ)

**Quy Trình cho Tham chiếu 1:**
1. "Younes" → không khớp → đếm = 0
2. "said" → không khớp → đếm = 0
3. "I" → khớp → đếm = 1
4. "am" → khớp → đếm = 2
5. "hungry" → không khớp → đếm = 2

Điểm ROUGE cho Ref 1: 2/5 = **0.4**

**Nếu có nhiều tham chiếu:** Tính cho mỗi cái, lấy giá trị lớn nhất

---

# **Điểm F1 – Kết Hợp BLEU và ROUGE**

Vì BLEU = precision và ROUGE = recall, chúng ta có thể tính **điểm F1**:

**Công Thức:**
```
F1 = 2 × (Precision × Recall) / (Precision + Recall)
F1 = 2 × (BLEU × ROUGE) / (BLEU + ROUGE)
```

**Ví Dụ:**
- BLEU = 0.5
- ROUGE = 0.4
- F1 = 2 × (0.5 × 0.4) / (0.5 + 0.4) = 4/9 ≈ **0.44**

---

# **Beam Search Decoding**

**Vấn Đề:** Chọn từ có xác suất cao nhất ở mỗi bước không đảm bảo chuỗi tốt nhất tổng thể

**Giải Pháp:** Beam search tìm các chuỗi có khả năng cao nhất trên một cửa sổ cố định

## Cách Beam Search Hoạt Động

**Độ Rộng Beam (B):** Số lượng chuỗi cần giữ ở mỗi bước

### Quy Trình:

#### Bước 1: Bắt đầu với SOS token
Lấy xác suất cho từ đầu tiên:
- I: 0.5
- am: 0.4
- hungry: 0.1

Giữ top B=2: **"I"** và **"am"**

#### Bước 2: Tính Xác Suất Có Điều Kiện
Cho "I":
- I am: 0.5 × 0.5 = 0.25
- I I: 0.5 × 0.1 = 0.05

Cho "am":
- am I: 0.4 × 0.7 = 0.28
- am hungry: 0.4 × 0.2 = 0.08

Giữ top B=2: **"am I"** (0.28) và **"I am"** (0.25)

#### Bước 3: Lặp Lại
Tiếp tục cho đến khi tất cả B chuỗi đạt EOS token

#### Bước 4: Chọn Tốt Nhất
Chọn chuỗi có xác suất tổng thể cao nhất

---

## Đặc Điểm Beam Search

**Ưu Điểm:**
- Tốt hơn greedy decoding (B=1)
- Tìm các chuỗi tốt hơn toàn cục
- Được sử dụng rộng rãi trong production

**Nhược Điểm:**
- Tốn bộ nhớ (lưu trữ B chuỗi)
- Tốn kém về mặt tính toán (chạy mô hình B lần mỗi bước)
- Phạt các chuỗi dài (tích của nhiều xác suất)

**Giải Pháp cho Chuỗi Dài:**
Chuẩn hóa theo độ dài: chia xác suất cho số từ

---

# **Minimum Bayes Risk (MBR) Decoding**

**Khái Niệm:** Tạo nhiều mẫu và tìm sự đồng thuận

## Quy Trình MBR:

### Bước 1: Tạo Nhiều Mẫu
Tạo ~30 mẫu ngẫu nhiên từ mô hình

### Bước 2: So Sánh Tất Cả Các Cặp
Với mỗi mẫu, so sánh với tất cả các mẫu khác sử dụng metric tương tự (ví dụ: ROUGE)

### Bước 3: Tính Độ Tương Tự Trung Bình
Với mỗi ứng viên, tính độ tương tự trung bình với tất cả các ứng viên khác

### Bước 4: Chọn Tốt Nhất
Chọn mẫu có **độ tương tự trung bình cao nhất** (rủi ro thấp nhất)

---

## Công Thức MBR

```
E* = argmax_E [ trung bình ROUGE(E, E') cho tất cả E' ]
```

Trong đó:
- E = bản dịch ứng viên
- E' = tất cả các ứng viên khác
- Mục tiêu: Tìm E tối đa hóa ROUGE trung bình với mọi E'

---

## Ví Dụ MBR (4 Ứng Viên)

**Bước 1:** Tính điểm ROUGE theo cặp
- ROUGE(C1, C2), ROUGE(C1, C3), ROUGE(C1, C4)
- Trung bình = R1

**Bước 2:** Lặp lại cho C2, C3, C4
- Lấy R2, R3, R4

**Bước 3:** Chọn cao nhất
- Chọn ứng viên có max(R1, R2, R3, R4)

---

## Đặc Điểm MBR

**Ưu Điểm:**
- Chính xác hơn về mặt ngữ cảnh so với random sampling
- Tìm bản dịch đồng thuận
- Có thể vượt trội beam search

**Nhược Điểm:**
- Yêu cầu tạo nhiều mẫu (tốn kém)
- Yêu cầu so sánh O(n²)

**Khi Nào Sử Dụng:**
- Khi cần bản dịch chất lượng cao
- Khi chi phí tính toán chấp nhận được
- Khi đầu ra beam search không nhất quán

---

# **Tóm Tắt: Các Chiến Lược Decoding**

| Phương Pháp | Mô Tả | Ưu Điểm | Nhược Điểm |
|-------------|-------|---------|------------|
| **Greedy** | Chọn xác suất cao nhất mỗi bước | Nhanh, đơn giản | Chuỗi không tối ưu |
| **Beam Search** | Giữ top-B chuỗi | Chất lượng tốt hơn | Chi phí bộ nhớ + tính toán |
| **Random Sampling** | Lấy mẫu từ phân phối | Đầu ra đa dạng | Chất lượng không nhất quán |
| **MBR** | Đồng thuận từ các mẫu | Chất lượng cao | Rất tốn kém |

---

# **Tóm Tắt Các Metric Đánh Giá**

| Metric | Loại | Tập Trung | Tốt Nhất Cho |
|--------|------|-----------|--------------|
| **BLEU** | Precision | Ứng viên → Tham chiếu | MT chung |
| **ROUGE** | Recall | Tham chiếu → Ứng viên | Tóm tắt |
| **F1** | Trung bình điều hòa | Cả precision & recall | Cái nhìn cân bằng |

**Lưu Ý Quan Trọng:** Tất cả các metric này:
- ❌ Không xem xét ngữ nghĩa
- ❌ Không xem xét cấu trúc câu
- ✅ Chỉ đếm khớp n-gram

**Thay Thế Hiện Đại:** Sử dụng các metric neural hoặc đánh giá của con người cho các ứng dụng quan trọng!
