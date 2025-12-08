---
title: "Ngày 39 - NMT & Tóm Tắt Văn Bản"
weight: 4
chapter: false
pre: "<b> 1.8.4. </b>"
---

**Ngày:** 2025-10-30 (Thứ Năm)  
**Trạng Thái:** "Hoàn Thành"  

---

# **Dịch Máy Neuron (NMT)**

## Tổng Quan Kiến Trúc

Câu đầu vào được chuyển đổi thành biểu diễn số và được mã hóa thành biểu diễn sâu bởi một **encoder 6 lớp**, sau đó được giải mã bởi một **decoder 6 lớp** thành bản dịch ở ngôn ngữ đích.

### Các Lớp Encoder và Decoder

Các lớp bao gồm:
- **Self-attention**: Giúp mô hình tập trung vào các phần khác nhau của đầu vào
- **Các lớp feed-forward**: Xử lý thông tin
- **Lớp encoder-decoder attention** (chỉ decoder): Sử dụng biểu diễn sâu từ lớp encoder cuối cùng

---

## Ví Dụ Cơ Chế Attention

**Tác Vụ Dịch:** "The woman took the empty magazine out of her gun"  
**Ngôn Ngữ Đích:** Czech

### Trực Quan Hóa Self-Attention

Khi dịch "magazine", cơ chế attention:
- Tạo liên kết attention mạnh giữa 'magazine' và 'gun'
- Điều này giúp dịch chính xác "magazine" thành "zásobník" (hộp đạn súng)
- Thay vì "časopis" (tạp chí tin tức)

### Tại Sao Attention Quan Trọng

**Attention = cơ chế giúp mô hình tập trung vào các phần quan trọng nhất của đầu vào khi tạo ra đầu ra**

Nói cách khác: **Attention = xử lý thông tin có chọn lọc thay vì tiêu thụ mọi thứ cùng một lúc**

Trong NLP, attention cho phép mô hình quyết định từ nào ảnh hưởng mạnh nhất đến việc hiểu một từ khác trong câu.

---

## Chi Tiết Triển Khai NMT

### Các Thành Phần Kiến Trúc Mô Hình:

#### Đầu Vào:
1. **Input tokens** (ngôn ngữ nguồn)
2. **Target tokens** (ngôn ngữ đích)

#### Bước 1: Tạo Bản Sao
Tạo hai bản sao cho mỗi input và target tokens (cần thiết ở các vị trí khác nhau của mô hình)

#### Bước 2: Encoder
- Một bản sao của input tokens → encoder
- Chuyển đổi thành vector **key** và **value**
- Đi qua lớp embedding → LSTM

#### Bước 3: Pre-attention Decoder
- Một bản sao của target tokens → pre-attention decoder
- Dịch chuỗi sang phải + thêm token start-of-sentence (**teacher forcing**)
- Đi qua lớp embedding → LSTM
- Đầu ra trở thành vector **query**

**Lưu ý:** Encoder và pre-attention decoder có thể chạy **song song** (không có phụ thuộc)

#### Bước 4: Chuẩn Bị cho Attention
- Lấy các vector query, key, value
- Tạo **padding mask** để xác định padding tokens
- Sử dụng bản sao của input tokens cho bước này

#### Bước 5: Lớp Attention
Truyền queries, keys, values và mask vào lớp attention
- Đầu ra là **context vectors** và mask

#### Bước 6: Post-attention Decoder
Bỏ mask, truyền context vectors qua:
- LSTM
- Lớp Dense
- LogSoftmax

#### Bước 7: Đầu Ra
Mô hình trả về:
- Log probabilities
- Bản sao của target tokens (để tính loss)

---

# **Tóm Tắt Văn Bản**

Tóm tắt = nén nội dung trong khi vẫn giữ các ý chính

## Hai Loại:

### 1. Tóm Tắt Extractive

**Khái niệm:** Chọn các câu quan trọng nhất từ văn bản gốc

**Đặc Điểm:**
- Không viết lại văn bản
- Giữ nguyên từ ngữ gốc
- Giống như "đánh dấu các câu chính"

**Quy Trình (TextRank Cổ Điển):**
1. Tách thành các câu
2. Chuyển đổi câu thành embeddings
3. Tính toán độ tương tự (cosine)
4. Tạo đồ thị (câu là nodes)
5. Xếp hạng sử dụng TextRank
6. Chọn các câu xếp hạng cao nhất

**Kết Quả:** Tập con của văn bản gốc

---

### 2. Tóm Tắt Abstractive

**Khái niệm:** Viết lại các ý chính trong các câu mới

**Đặc Điểm:**
- Tạo ra các câu chưa từng xuất hiện trong bản gốc
- Hiểu nội dung → paraphrase
- Yêu cầu mô hình mạnh (seq2seq, Transformer)

**Ví Dụ:**
Bài báo gốc thảo luận về quy trình điều tra của công tố viên...

Tóm tắt được tạo:
> "Công tố viên: Cho đến nay không có video nào được sử dụng trong cuộc điều tra vụ tai nạn."

Câu này không tồn tại trong bản gốc nhưng nắm bắt ý chính.

---

## Tóm Tắt Extractive vs Abstractive

| Đặc Điểm | Extractive | Abstractive |
|----------|------------|-------------|
| Cách tiếp cận | Chọn câu hiện có | Tạo câu mới |
| Sáng tạo | Thấp | Cao |
| Độ phức tạp | Đơn giản hơn | Phức tạp hơn |
| Độ chính xác | Trung thành hơn với nguồn | Có thể gây lỗi |
| Mô hình | TextRank, dựa trên đồ thị | Seq2seq, Transformer |

---

## Pipeline TextRank

**Tóm tắt extractive từng bước:**

1. **Kết hợp các bài báo** → văn bản đầy đủ
2. **Tách các câu**
3. **Chuyển đổi câu** → vectors (embeddings)
4. **Tạo ma trận tương tự**
5. **Xây dựng đồ thị** (câu = nodes, cạnh = tương tự)
6. **Xếp hạng nodes** sử dụng thuật toán TextRank
7. **Chọn các câu xếp hạng cao nhất** → Tóm tắt

Đây là thuật toán cổ điển thống trị trước deep learning!

---

# **Ôn Tập Cú Pháp và Ngữ Nghĩa**

## Cú Pháp – Cấu Trúc Câu

**Cú Pháp** kiểm tra cách các từ kết hợp để tạo thành **các câu chính xác ngữ pháp**.

### Bao Gồm:
- **Thứ tự từ**: Tiếng Anh sử dụng S–V–O (Chủ Từ–Động Từ–Tân Từ)
- **Cấu trúc cụm từ**: NP (Cụm Danh Từ), VP (Cụm Động Từ), PP (Cụm Giới Từ)
- **Các mối quan hệ phụ thuộc**: Cách các từ liên quan đến nhau

### Liên Quan NLP:
- Gắn nhãn POS
- Phân tích cú pháp
- Nhận dạng thực thể
- Dịch máy
- Trả lời câu hỏi

---

## Ngữ Nghĩa – Ý Nghĩa của Từ và Câu

**Ngữ Nghĩa** tập trung vào ý nghĩa **độc lập với ngữ cảnh bên ngoài**.

### Bao Gồm:
- **Ngữ nghĩa từ vựng**: Ý nghĩa của từ
- **Ngữ nghĩa thành phần**: Ý nghĩa của câu
- **Từ đồng nghĩa / trái nghĩa**: Ý nghĩa tương tự/đối lập
- **Cấp tính / hạ tính**: Mối quan hệ chung/cụ thể

### Liên Quan NLP:
- Nhúng từ
- Các biện pháp tương tự
- Tìm kiếm ngữ nghĩa
- Phân loại văn bản

---

## Thực Dụng – Ý Định Có Ngữ Cảnh

**Thực Dụng** nghiên cứu ý nghĩa từ **ngữ cảnh, ý định của người nói và kiến thức thế giới thực**.

### Bao Gồm:
- **Hàm ý**: Ý nghĩa ẩn
- **Chỉ dẫn**: Tham chiếu phụ thuộc ngữ cảnh (cái này/cái kia/ở đây/bạn)
- **Hành động nói**: Hứa, yêu cầu, xin lỗi
- **Lịch sự, tính chính thức, châm biếm**: Tông điệu và ý định

### Liên Quan NLP:
- Hệ thống hội thoại
- Chatbots
- Phát hiện cảm xúc và châm biếm
- Mô hình ngôn ngữ ngữ cảnh (BERT, GPT)
