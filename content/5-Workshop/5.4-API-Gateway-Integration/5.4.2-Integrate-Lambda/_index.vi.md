---
title : "Gắn API với Lambda"
weight : 2
chapter : false
pre : " <b> 5.4.2. </b> "
---

## Gắn API với Lambda

Trong bước này, bạn sẽ cấu hình HTTP API để chuyển các request từ client đến Lambda Function.  
API Gateway sẽ đóng vai trò là lớp giao tiếp HTTP cho dịch vụ chatbot sử dụng Bedrock của bạn.

---

### 🔹 Bước 1 — Mở API vừa tạo

Vào **API Gateway Console** và chọn API:

`bedrock-chatbot-api`

![h4](/5-Workshop/5.4-API-Gateway-Integration/5.4.2-Integrate-Lambda/h4.png)

---

### 🔹 Bước 2 — Tạo route

1. Chọn mục **Routes**  
2. Nhấn **Create**  
3. Cấu hình:

- **Method**: `POST`  
- **Resource path**: `/chat`

Nhấn **Create** để tạo route.

---

### 🔹 Bước 3 — Thêm Integration với Lambda

1. Nhấn vào route vừa tạo `/chat`  
2. Ở phần **Integration**, chọn **Attach integration**

![h5](/5-Workshop/5.4-API-Gateway-Integration/5.4.2-Integrate-Lambda/h5.png)

3. Chọn Create and attach an integration:

- **Integration type**: Lambda function  
- **Region**: Region bạn đang sử dụng  
- **Lambda function**: `lambda-bedrock-function` (Tên lambda bạn mới tạo)
![h6](/5-Workshop/5.4-API-Gateway-Integration/5.4.2-Integrate-Lambda/h6.png)
![h7](/5-Workshop/5.4-API-Gateway-Integration/5.4.2-Integrate-Lambda/h7.png)

Nhấn **Create**.



---

### 🎯 Kết quả mong đợi

Bạn đã:

- Tạo route `/chat`  
- Gắn route này với Lambda Function  
- Deploy API và có endpoint HTTP sẵn sàng để test  

