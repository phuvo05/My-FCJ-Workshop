---
title : "Dọn dẹp tài nguyên"
weight : 6
chapter : false
pre : " <b> 5.6. </b> "
---

## Dọn dẹp tài nguyên (Cleanup)

Sau khi hoàn thành workshop, bạn nên xóa các tài nguyên AWS không còn sử dụng để tránh phát sinh chi phí.  
Dưới đây là danh sách các dịch vụ bạn đã tạo và cách xoá chúng.

---

## 🔹 1. Xoá API Gateway

1. Mở **API Gateway Console**  
2. Chọn API bạn đã tạo, ví dụ: `bedrock-chatbot-api`  
3. Chọn **Actions → Delete**  
4. Xác nhận xoá

Điều này sẽ ngăn mọi request đến Lambda và tránh bị tính phí API.

---

## 🔹 2. Xoá Lambda Function

1. Mở **Lambda Console**  
2. Chọn hàm `bedrock-chatbot-lambda`  
3. Chọn **Actions → Delete function**  
4. Xác nhận xoá

---

## 🔹 3. Xoá IAM Role và Policy

### **Xoá Policy:**

1. Mở **IAM Console → Policies**  
2. Tìm `lambda-bedrock`  
3. Bấm **Delete**

### **Xoá Role:**

1. Mở **IAM Console → Roles**  
2. Tìm `lambda-bedrock-role`  
3. Bấm **Delete**

> ⚠️ Bạn chỉ xoá được Role sau khi đã xoá Lambda Function sử dụng nó.

---

## 🔹 4. Kiểm tra CloudWatch Log Groups (tuỳ chọn)

Log của Lambda vẫn còn trong CloudWatch và có thể chiếm dung lượng lưu trữ lâu dài.

1. Mở **CloudWatch Console**  
2. Chọn **Logs → Log groups**  
3. Tìm log của Lambda (ví dụ: `/aws/lambda/bedrock-chatbot-lambda`)  
4. Chọn **Actions → Delete log group**

---

## 🔹 5. Kiểm tra các tài nguyên khác (nếu có)

Tuỳ theo cách bạn mở rộng workshop, bạn có thể đã tạo thêm các tài nguyên như:

- S3 bucket  
- Step Functions  
- KMS key  
- VPC / Security Groups  

Nếu không dùng nữa, hãy xoá để tránh phí.

---

## 🎉 Hoàn tất!

Bạn đã dọn dẹp toàn bộ tài nguyên được tạo trong workshop này.  
Giờ tài khoản AWS của bạn sẽ không phát sinh thêm chi phí từ phần lab.

Cảm ơn bạn đã tham gia workshop!  
