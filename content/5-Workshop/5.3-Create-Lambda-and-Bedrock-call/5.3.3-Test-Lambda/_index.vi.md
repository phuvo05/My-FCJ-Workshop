---
title : "Kiểm thử Lambda Function"
weight : 3
chapter : false
pre : " <b> 5.3.3. </b> "
---

## Kiểm thử Lambda Function

Sau khi đã tạo Lambda Function và thêm code gọi Amazon Bedrock bằng **Converse API**, bước tiếp theo là kiểm thử để đảm bảo hàm hoạt động đúng.

Trong phần này, bạn sẽ:

1. Tạo một test event trong Lambda Console  
2. Gửi thử một câu hỏi đến mô hình Bedrock  
3. Xem kết quả trả về và kiểm tra log nếu có lỗi  

---

### 🔹 Bước 1 — Mở Lambda và tạo test event

1. Vào **AWS Lambda Console**  
2. Chọn hàm: `bedrock-chatbot-lambda`  
3. Nhấn nút **Test**  
4. Chọn **Create new event** nếu đây là lần đầu test  
5. Đặt tên event, ví dụ:

- **Event name**: `test-bedrock-converse`

Tại mục cấu hình event, kéo xuống phần JSON và **thay toàn bộ nội dung bằng**:

```json
{
  "question": "Amazon Bedrock là gì?"
}
```

Ví dụ minh họa:

![h4](/images/5-Workshop/5.3-Create-Lambda-and-Bedrock-call/h4.png)

Nhấn **Save** để lưu test event.

---

### 🔹 Bước 2 — Chạy test và xem kết quả

1. Chọn event bạn vừa tạo  
2. Nhấn **Test**

Nếu Lambda hoạt động đúng, bạn sẽ thấy phản hồi dạng:

```json
{
  "answer": "Amazon Bedrock is a fully managed service..."
}
```

Trường `"answer"` chính là nội dung mô hình Bedrock trả về.

---

### 🔹 Bước 3 — Kiểm tra log nếu có lỗi

Nếu Lambda trả về lỗi hoặc không chạy như mong đợi:

1. Chọn tab **Monitor**  
2. Nhấn **View logs in CloudWatch**  
3. Mở log stream mới nhất

Một số lỗi phổ biến:

#### ❌ **AccessDeniedException**
- Nguyên nhân: Role Lambda thiếu quyền `bedrock:InvokeModel`  
- Cách xử lý: Kiểm tra lại IAM Role ở phần *Prerequisites*

#### ❌ **Timeout**
- Nguyên nhân: Lambda timeout mặc định 3 giây quá thấp  
- Cách xử lý: Vào **Configuration → General** tăng timeout lên 10–20 giây

#### ❌ **KeyError hoặc rỗng input**
- Nguyên nhân: Payload không chứa `"question"`  
- Cách xử lý: Đảm bảo JSON gửi vào đúng format:

```json
{
  "question": "Nội dung câu hỏi"
}
```

---

### 🎯 Kết quả mong đợi

Sau phần này, bạn sẽ:

- Kiểm chứng được Lambda có thể gọi Bedrock thành công  
- Nhận phản hồi từ mô hình qua Converse API  
- Xác nhận IAM Role và MODEL_ID hoạt động đúng  
- Sẵn sàng triển khai bước tiếp theo: tạo API endpoint

