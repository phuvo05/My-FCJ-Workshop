---
title : "Tạo API Gateway"
weight : 4
chapter : false
pre : " <b> 5.4. </b> "
---

## Tạo API Gateway

Ở phần này, bạn sẽ tạo một HTTP API trên Amazon API Gateway để khách hàng (client) có thể gửi câu hỏi đến Lambda Function.  
API Gateway sẽ đóng vai trò là endpoint HTTP trung gian giữa client và dịch vụ AI Q&A của bạn.

---

## Nội dung

- [5.4.1 – Tạo HTTP API](5.4.1-Create-HTTP-API/)  
- [5.4.2 – Gắn API với Lambda](5.4.2-Integrate-Lambda/)  

---

Sau khi hoàn thành phần này, bạn sẽ có một HTTP endpoint công khai (hoặc private tùy cấu hình), cho phép client như Postman, cURL, frontend web… gửi câu hỏi đến Lambda và nhận lại câu trả lời từ Bedrock.
