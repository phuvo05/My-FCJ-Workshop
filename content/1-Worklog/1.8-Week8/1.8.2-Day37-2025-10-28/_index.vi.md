---
title: "Ngày 37 - Tìm Kiếm Giọng Nói & Kiến Trúc Chatbot"
weight: 2
chapter: false
pre: "<b> 1.8.2. </b>"
---

**Ngày:** 2025-10-28 (Thứ Ba)  
**Trạng Thái:** "Hoàn Thành"  

---

# **Tìm Kiếm Giọng Nói (Cách Siri Hoạt Động)**

Hệ thống tìm kiếm giọng nói tuân theo một pipeline từ đầu vào giọng nói đến phản hồi có thể thực hiện được:

## Các Thành Phần Pipeline:

### 1. Chuyển Đổi Analog sang Digital
Lời nói (phát âm) → Mô hình sóng âm thanh → Spectrogram (mô hình tần số) → Chuỗi các khung âm thanh sử dụng **Fast Fourier Transform (FFT)**

### 2. Nhận Dạng Giọng Nói Tự Động (ASR)
- **Phân tích đặc trưng**: Trích xuất các đặc trưng âm thanh
- **Hidden Markov Model (HMM)**: Nhận dạng mẫu cho chuyển giọng nói sang văn bản
- **Thuật toán Viterbi**: Tìm chuỗi trạng thái ẩn có khả năng nhất
- **Từ điển ngữ âm**: Ánh xạ âm thanh thành từ
- **Mô hình ngôn ngữ**: Đảm bảo tính chính xác ngữ pháp

### 3. Chú Thích NLP
- Tokenization
- Gắn nhãn POS
- Nhận dạng thực thể (NER)

### 4. Ánh Xạ Mẫu-Hành Động
Ánh xạ các ý định được nhận dạng thành các hành động phù hợp

### 5. Quản Lý Dịch Vụ
- API nội bộ & bên ngoài (email, SMS, bản đồ, thời tiết, cổ phiếu, v.v.)
- Thực hiện hành động được yêu cầu

### 6. Chuyển Văn Bản Thành Giọng Nói (TTS)
Chuyển đổi phản hồi trở lại thành giọng nói

### 7. Phản Hồi Người Dùng
Hệ thống học từ các sửa chữa để cải thiện độ chính xác

---

# **Kiến Trúc Voicebot**

Pipeline xử lý voicebot bao gồm nhiều cấp độ ngôn ngữ:

## Các Lớp Xử Lý:

### Phân Tích Giọng Nói (Âm Vị Học)
Nhận dạng và phiên âm giọng nói sử dụng Nhận Dạng Giọng Nói Tự Động (ASR)

### Phân Tích Hình Thái và Từ Vựng (Hình Thái Học)
Phân tích cấu trúc và ý nghĩa của từ sử dụng các quy tắc hình thái và từ vựng

### Phân Tích Cú Pháp (Cú Pháp)
Hiểu cấu trúc câu sử dụng từ vựng và quy tắc ngữ pháp

### Suy Luận Ngữ Cảnh (Ngữ Nghĩa)
Hiểu ý nghĩa trong ngữ cảnh sử dụng ngữ cảnh diễn ngôn

### Suy Luận và Thực Thi Ứng Dụng (Lý Luận)
Sử dụng kiến thức miền để quyết định hành động

### Lập Kế Hoạch Phát Ngôn
Lập kế hoạch những gì sẽ nói trong phản hồi

### Hiện Thực Hóa Cú Pháp
Tạo ra các câu chính xác ngữ pháp

### Hiện Thực Hóa Hình Thái
Áp dụng các dạng từ chính xác

### Mô Hình Phát Âm
Tạo ra phát âm phù hợp

### Tổng Hợp Giọng Nói
Chuyển đổi văn bản trở lại thành giọng nói

---

# **Quy Trình Làm Việc Chatbot**

## Quy Trình Từng Bước:

### 1. Người Dùng → Ứng Dụng Chat
Người dùng gõ: *"Tôi muốn kiểm tra số dư tài khoản."*
Ứng Dụng Chat = giao diện nơi người dùng gõ (web, app, messenger)

### 2. Ứng Dụng Chat → Chatbot
Tin nhắn được gửi đến hệ thống chatbot

### 3. Chatbot → NLP Engine
Chatbot gửi tin nhắn đến NLP Engine để phân tích

#### NLP Engine thực hiện hai tác vụ chính:

**(a) Phát Hiện Ý Định**
Xác định người dùng muốn làm gì
- Ví dụ: `kiểm_tra_số_dư`

**(b) Trích Xuất Thực Thể**
Trích xuất dữ liệu quan trọng từ câu
- Ví dụ: `tài_khoản = thanh toán/tiết kiệm?`

### 4. NLP Engine → Logic Nghiệp Vụ / Dịch Vụ Dữ Liệu
Dựa trên **ý định**, chatbot gọi dịch vụ phù hợp:
- Truy vấn cơ sở dữ liệu
- Gọi API
- Thực thi quy tắc nghiệp vụ
- Xử lý logic backend

Ví dụ: Gọi API để lấy số dư từ hệ thống ngân hàng

### 5. Dịch Vụ Dữ Liệu → Chatbot
Backend trả về kết quả:
> "Số dư tài khoản của bạn là 12.500.000₫"

### 6. Chatbot → Ứng Dụng Chat
Chatbot đóng gói thông tin thành phản hồi ngôn ngữ tự nhiên

### 7. Hiển Thị Cho Người Dùng
Người dùng nhìn thấy phản hồi

---

## Chatbot = Lắng Nghe + Trò Chuyện

### Lắng Nghe (NLP - Hiểu)
- Nhận dạng ý định
- Trích xuất thực thể
- Hiểu ngữ cảnh

### Trò Chuyện (NLG - Tạo)
- Tạo ngôn ngữ tự nhiên
- Công thức hóa phản hồi
- Cá nhân hóa

### Đằng Sau Hậu Trường:
- **Dữ liệu dựa trên kiến thức**: Sự thật, quy tắc, FAQ
- **Học máy**: Học từ các tương tác
- **Logic nghiệp vụ**: Quy tắc cụ thể của ứng dụng

---

## Phân Biệt Quan Trọng: Từ Khóa vs Thực Thể

**Từ Khóa** = các từ chỉ ra chủ đề hoặc đối tượng
**Thực Thể** = các điểm dữ liệu cụ thể với loại và giá trị

Ví dụ: *"Đặt chuyến bay đến Paris vào thứ Sáu"*
- Từ khóa: đặt, chuyến bay
- Thực thể: 
  - điểm_đến = "Paris" (ĐỊA ĐIỂM)
  - ngày = "thứ Sáu" (NGÀY THÁNG)

Không phải tất cả từ khóa đều là thực thể, nhưng tất cả thực thể đều được trích xuất từ từ khóa!
