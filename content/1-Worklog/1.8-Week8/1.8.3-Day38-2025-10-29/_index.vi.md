---
title: "Ngày 38 - Mô Hình Seq2seq & LSTM Chi Tiết"
weight: 3
chapter: false
pre: "<b> 1.8.3. </b>"
---

**Ngày:** 2025-10-29 (Thứ Tư)  
**Trạng Thái:** "Hoàn Thành"  

---

# **Mô Hình Seq2seq**

**Mô hình Sequence-to-Sequence (Seq2seq)** giới thiệu kiến trúc encoder-decoder hiệu quả cho các tác vụ như dịch máy và tóm tắt văn bản.

## Đặc Điểm Chính:
- Ánh xạ chuỗi có độ dài thay đổi thành bộ nhớ có độ dài cố định
- Đầu vào và đầu ra có thể có độ dài khác nhau
- Sử dụng LSTM và GRU để tránh vanishing và exploding gradients
- Encoder nhận token từ làm đầu vào → các vector trạng thái ẩn → decoder tạo ra chuỗi đầu ra

---

# **Kiến Trúc LSTM: Tìm Hiểu Sâu**

## LSTM là gì?

**LSTM (Long Short-Term Memory)** giống như phiên bản mini của não người khi xử lý trí nhớ.

## Cấu Trúc LSTM = 3 Cổng + 1 Trạng Thái Tế Bào

### 1. Cổng Quên – Quyết Định Quên Gì

Quyết định thông tin nào cần loại bỏ khỏi trạng thái cũ.

**Công thức:**
```
f_t = σ(W_f · [h_{t-1}, x_t] + b_f)
```

**Ví dụ não người:**
- Tin nhắn vô ích từ người đã ghosting bạn → quên
- Công thức bạn dùng hàng ngày → giữ

### 2. Cổng Đầu Vào – Quyết Định Nhớ Gì

Quyết định thông tin mới nào cần thêm vào bộ nhớ.

**Công thức:**
```
i_t = σ(W_i · [h_{t-1}, x_t] + b_i)
Ĉ_t = tanh(W_C · [h_{t-1}, x_t] + b_C)
```

**Ví dụ não người:**
- Thông tin có giá trị → lưu vào trí nhớ dài hạn
- Nhiễu không liên quan → loại bỏ ngay lập tức

### 3. Cập Nhật Trạng Thái Tế Bào – Trí Nhớ Dài Hạn

Cập nhật trí nhớ dài hạn bằng cách kết hợp cổng quên và cổng đầu vào.

**Công thức:**
```
C_t = f_t ⊙ C_{t-1} + i_t ⊙ Ĉ_t
```

Trong đó:
- `f_t ⊙ C_{t-1}` = những gì cần giữ từ trí nhớ cũ
- `i_t ⊙ Ĉ_t` = những gì cần thêm từ đầu vào mới

### 4. Cổng Đầu Ra – Quyết Định Xuất Ra Gì

Quyết định trí nhớ nào sử dụng cho đầu ra hiện tại.

**Công thức:**
```
o_t = σ(W_o · [h_{t-1}, x_t] + b_o)
h_t = o_t ⊙ tanh(C_t)
```

**Ví dụ não người:**
- Khi thi NLP → nhớ lại công thức LSTM
- Khi nói chuyện với ai đó → nhớ ngữ cảnh cuộc trò chuyện
- Khi làm DevOps → nhớ thông số AWS

---

## LSTM vs Não Người

| Não Người | LSTM |
|-----------|------|
| Trí nhớ dài hạn | Cell State |
| Lọc thông tin không cần thiết | Forget Gate |
| Chấp nhận thông tin mới có giá trị | Input Gate |
| Truy xuất trí nhớ phù hợp để phản hồi | Output Gate |
| Học từ kinh nghiệm tuần tự | RNN backbone |
| Không quên nhanh | Long-term dependencies |

---

## Cổng là gì?

**Cổng = bộ lọc nhận thức**

Mỗi cổng = một cơ chế quyết định "giữ hay bỏ"

### Ví dụ: Khi Bạn Học NLP

- **Cổng Quên**: "Tôi còn cần nhớ phương pháp lỗi thời này không?" → Bỏ nếu không
- **Cổng Đầu Vào**: "Khái niệm mới này có giá trị không?" → Lưu nếu có
- **Cổng Đầu Ra**: "Tôi cần kiến thức gì ngay bây giờ?" → Truy xuất phần liên quan

---

## Giới Hạn Hidden State

Hidden state không có giới hạn token, nhưng có **giới hạn khả năng nhớ hiệu quả**.

### Góc Độ Toán Học:
- Hidden state = vector có kích thước cố định (ví dụ: 128, 256, 512 chiều)
- Có thể xử lý 10 token hoặc 10.000 token → không bị crash
- Vấn đề: **không thể nhớ mọi thứ**

### Tại Sao?
- Ngay cả với cell state, gradient suy yếu qua nhiều bước thời gian
- Các phụ thuộc dài hạn bị mất
- Các token xa điểm bắt đầu có ảnh hưởng yếu đến đầu ra cuối cùng

**Giải pháp:** Đây là lý do chúng ta cần **cơ chế Attention**!

---

## Throttling trong NLP

### Hai Nghĩa của Throttling:

#### 1. Throttling Cấp Hệ Thống (API)
Giới hạn tốc độ request hoặc xử lý token để:
- Bảo vệ tài nguyên GPU
- Phân phối tài nguyên công bằng
- Tránh quá tải server
- Kiểm soát chi phí

Ví dụ:
- OpenAI GPT: 10 requests/giây, 90k tokens/phút
- Anthropic Claude: 20 requests/giây
- HuggingFace: timeout nếu generation mất quá lâu

#### 2. Throttling Cấp Mô Hình (Kiến Trúc)

LSTM, Transformer và Attention đều có cơ chế **giới hạn xử lý thông tin** tại bất kỳ thời điểm nào:

**(A) LSTM Throttling → Cổng Quên**
Khi chuỗi quá dài:
- Cổng quên tự động "throttle" thông tin cũ
- Chỉ cho phép một phần ý nghĩa đi qua
- Giống throttling mạng: "quá tải → giảm băng thông → bỏ packet"

**(B) Transformer Throttling → Giới Hạn Context Window**
- BERT: 512 tokens
- GPT-3: 2048-4096 tokens
- GPT-4: 128k-1M tokens
- Claude 3.5 Sonnet: 200k-1M tokens

Khi đầu vào vượt giới hạn:
- Mô hình cắt dữ liệu
- Hoặc từ chối xử lý
- Hoặc hạ chất lượng attention

**(C) Attention Throttling → Sparse Attention**
Trong các mô hình ngữ cảnh dài (Longformer, BigBird, Mistral):
- Không thể tính toán full n² attention
- Chỉ chú ý đến các vùng quan trọng (local attention)
- Hoặc global tokens
- Hoặc sliding window

**(D) Token Generation Throttling**
Một số decoder sẽ:
- Làm chậm tốc độ sinh token
- Giới hạn sampling
- Áp dụng kiểm soát nhiệt độ
- Cắt beam search

Khi đầu vào nhiễu hoặc không chắc chắn, điều này hoạt động như phanh: "Không chắc → làm chậm generation → tăng chất lượng"

---

# **Tóm Tắt**

LSTM không chỉ là một mô hình — nó là sự bắt chước tính toán cách trí nhớ con người hoạt động. Hiểu các cổng giúp bạn hiểu tại sao một số thông tin tồn tại trong khi thông tin khác biến mất.
