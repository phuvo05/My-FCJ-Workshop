---
title : "Tạo Lambda Function"
weight : 1
chapter : false
pre : " <b> 5.3.1. </b> "
---

## Tạo Lambda Function

Trong bước này, bạn sẽ tạo một hàm AWS Lambda mới dùng để xử lý yêu cầu từ client và gửi prompt đến Amazon Bedrock thông qua Converse API.

---

### 🔹 Bước 1 — Mở giao diện tạo Lambda

1. Vào **AWS Lambda Console**
2. Chọn **Functions**
3. Chọn **Create function**

![h1](/images/5-Workshop/5.3-Create-Lambda-and-Bedrock-call/h1.png)

---

### 🔹 Bước 2 — Đặt tên và chọn cấu hình cho Lambda

Trong phần cấu hình:

- **Function name**: `bedrock-chatbot-lambda`
- **Runtime**: `Python 3.12` *(phiên bản ổn định và được khuyến nghị cho workshop)*  
- **Architecture**: `x86_64` hoặc `arm64` *(cả hai đều hỗ trợ)*  
- **Permissions → Use an existing role**
  - Chọn role bạn đã tạo ở phần Prerequisites, ví dụ:  
    **`lambda-bedrock-role`**

Sau đó bấm **Create function** để tạo Lambda.

![h2](/images/5-Workshop/5.3-Create-Lambda-and-Bedrock-call/h2.png)

---

### 🎯 Kết quả mong đợi

Bạn sẽ có một Lambda Function rỗng nhưng đã:

- Sẵn sàng để thêm mã gọi Converse API  
- Có Execution Role với quyền Bedrock + quyền ghi log CloudWatch  
- Có thể được test trực tiếp trong Lambda Console  

Ở phần tiếp theo, bạn sẽ cấu hình chi tiết IAM Role và chuẩn bị mã nguồn cho việc gọi mô hình.

---

Tiếp tục xem phần **[5.3.2 – Thêm code gọi Converse API](../5.3.2-Call-Bedrock-Converse/)**.
