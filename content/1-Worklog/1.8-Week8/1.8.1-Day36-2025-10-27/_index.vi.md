---
title: "Ngày 36 - Nền Tảng NLP & Ứng Dụng"
weight: 1
chapter: false
pre: "<b> 1.8.1. </b>"
---

**Ngày:** 2025-10-27 (Thứ Hai)  
**Trạng Thái:** "Hoàn Thành"  

---

# **Xử Lý Ngôn Ngữ Tự Nhiên là gì?**

**Xử Lý Ngôn Ngữ Tự Nhiên (NLP)** là một lĩnh vực của Trí Tuệ Nhân Tạo tập trung vào việc giúp máy tính có thể **hiểu, giải thích, tạo ra và tương tác** với ngôn ngữ con người.

NLP kết hợp **ngôn ngữ học tính toán**, **học máy** và **học sâu** để xử lý dữ liệu văn bản và lời nói quy mô lớn.

## Các Tác Vụ NLP Điển Hình:
- Phân loại văn bản
- Phân tích cảm xúc
- Nhận dạng thực thể (NER)
- Dịch máy
- Gắn nhãn từ loại (POS tagging)
- Nhận dạng giọng nói

---

# **Các Thành Phần Ngôn Ngữ Cốt Lõi trong NLP**

## **Âm Vị Học – Những Âm Thanh của Lời Nói Con Người**

**Âm Vị Học** nghiên cứu các đặc tính *vật lý* của những âm thanh lời nói.

### Ba Nhánh Chính:
- **Âm vị học phát âm**: cách những âm thanh được tạo ra (lưỡi, môi, dây thanh…)
- **Âm vị học âm học**: các đặc tính vật lý của âm thanh (tần số, biên độ, thời lượng)
- **Âm vị học thính giác**: con người cảm nhận âm thanh như thế nào

**Liên Quan NLP:** Được sử dụng trong nhận dạng giọng nói, tổng hợp giọng nói (TTS), mô hình âm thanh.

---

## **Âm Vị Học – Hệ Thống Âm Thanh của Ngôn Ngữ**

**Âm Vị Học** nghiên cứu cách những âm thanh hoạt động **trong một ngôn ngữ cụ thể**.
Nó đề cập đến **phonemes**, mô hình nhấn mạnh, các tổ hợp âm thanh được phép.

**Liên Quan NLP:** Chuyển đổi grapheme sang phoneme, mô hình phát âm.

---

## **Hình Thái Học – Cấu Trúc của Từ**

**Hình Thái Học** nghiên cứu cách những từ được hình thành từ những đơn vị nhỏ hơn gọi là **morphemes**.

### Ví Dụ:
- Tiền tố: un-, re-, pre-
- Hậu tố: -ing, -ed, -ness
- Gốc/thân từ: run, happy, form

**Liên Quan NLP:**
- Stemming
- Lemmatization
- Tokenization
- Xây dựng từ vựng cho mô hình BoW

---

# **Các Ứng Dụng NLP**

## Công Cụ Tìm Kiếm
Những tìm kiếm hàng ngày của bạn trên các công cụ tìm kiếm được tạo thuận lợi bởi NLP để hiểu truy vấn và xếp hạng kết quả.

### Ví Dụ Nhận Dạng Ý Định Tìm Kiếm
Khi ai đó tìm kiếm **"glass coffee tables"** (bàn cà phê mặt kính), công cụ nhận dạng ý định xác định rằng từ "glass" có khả năng đề cập đến giá trị của thuộc tính **'Top Material'** (Chất Liệu Bề Mặt) trong bàn cà phê. Sau đó, nó chỉ dẫn công cụ tìm kiếm hiển thị danh mục bàn cà phê với thuộc tính 'Top Material' được đặt thành 'glass'.

---

## Quảng Cáo Trực Tuyến

NLP cho phép quảng cáo được nhắm mục tiêu bằng cách phân tích hành vi trực tuyến thông qua nhiều thành phần:

### 1. Nhận Dạng Thực Thể (NER)
Xác định các yếu tố thông tin được chọn gọi là Thực Thể. Do không có dữ liệu được gắn nhãn, các phương pháp bán giám sát được áp dụng để phát hiện các thực thể cụ thể cho từng trường hợp sử dụng.

### 2. Trích Xuất Mối Quan Hệ
Một trong những tác vụ NLP cổ điển nhằm trích xuất các mối quan hệ ngữ nghĩa từ các tài liệu văn bản không có cấu trúc hoặc bán cấu trúc.

### 3. Nhận Dạng Khoảnh Khắc (MoRec)
Cho phép các nhà phân tích hiểu các cuộc thảo luận trên diễn đàn trong giai đoạn khám phá kiến thức bằng cách xử lý văn bản thảo luận không có cấu trúc và trích xuất kiến thức dưới dạng sự kiện. Các sự kiện có thể được xác định và cấu hình tùy thuộc vào trường hợp sử dụng đang được điều tra.

---

## Trợ Lý Giọng Nói
Siri, Alexa và Google Assistant sử dụng NLP để hiểu và trả lời các lệnh giọng nói của bạn.

## Dịch Máy
Các dịch vụ như Google Translate dựa vào NLP để chuyển đổi văn bản từ một ngôn ngữ sang ngôn ngữ khác.

## Chatbot
Chatbot dịch vụ khách hàng sử dụng NLP để tương tác với người dùng và cung cấp hỗ trợ.

## Tóm Tắt Văn Bản
Các thuật toán NLP có thể nén các bài viết dài thành những bản tóm tắt ngắn gọn.
