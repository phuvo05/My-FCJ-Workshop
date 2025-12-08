---
title : "Tạo Lambda và gọi Bedrock"
weight : 3
chapter : false
pre : " <b> 5.3. </b> "
---

## Tạo Lambda và gọi Bedrock

Trong phần này, bạn sẽ tạo một Lambda Function và cấu hình để gọi mô hình Amazon Bedrock thông qua **Converse API**.  
Sơ đồ kiến trúc tổng quan đã được giới thiệu ở phần trước, và trong bước này bạn sẽ triển khai từng thành phần cần thiết để Lambda có thể gửi prompt tới Bedrock và nhận kết quả phản hồi.

---
Ở các bước tiếp theo, bạn sẽ:

1. Tạo hàm Lambda mới  
2. Gán Execution Role đã chuẩn bị ở phần **Prerequisites**  
3. Viết đoạn mã đầu tiên để gọi mô hình thông qua **Converse API**  

Sau khi hoàn thành mục này, Lambda Function của bạn sẽ có thể tương tác trực tiếp với Bedrock và xử lý yêu cầu Hỏi – Đáp từ người dùng.

---

## Nội dung

- [Tạo Lambda Function](5.3.1-Create-Lambda/)  
- [Gán IAM Role cho Lambda](5.3.2-Call-Bedrock-Converse/)  
- [Thêm code gọi Bedrock bằng Converse API](5.3.3-Call-Bedrock-Converse/)  

---

