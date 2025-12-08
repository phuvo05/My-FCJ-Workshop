---
title : "Giới thiệu"
weight : 1
chapter : false
pre : " <b> 5.1. </b> "
---

## Giới thiệu về Amazon Bedrock và Converse API

**Amazon Bedrock** là nền tảng AI fully managed của AWS, cung cấp nhiều mô hình ngôn ngữ lớn (LLM) như Claude, Llama, Mistral và Titan. Các mô hình này có thể được gọi trực tiếp qua API mà không cần triển khai hay quản lý hạ tầng.

Workshop này sử dụng **Converse API**, giao diện thống nhất cho các mô hình Bedrock *có hỗ trợ Converse*. Với Converse API:

- Bạn có thể dùng chung một cấu trúc request/response cho nhiều mô hình.
- Việc chuyển đổi mô hình chỉ cần đổi **`modelId`**.
- Toàn bộ logic conversation được đơn giản hóa và nhất quán.

Converse API giúp bạn dễ dàng xây dựng dịch vụ AI trên kiến trúc serverless mà không phụ thuộc vào từng mô hình cụ thể.

---

## Tổng quan về workshop

Trong workshop này, bạn sẽ triển khai một **API Hỏi–Đáp AI đơn giản**. Ứng dụng sẽ nhận câu hỏi từ người dùng, gửi đến mô hình Bedrock thông qua Lambda, và trả về câu trả lời dưới dạng văn bản.

Kiến trúc gồm ba thành phần chính:

- **AWS Lambda** – xử lý request và gọi Bedrock bằng Converse API.  
- **Amazon Bedrock Runtime** – thực thi suy luận với mô hình được cấu hình.  
- **Amazon API Gateway** – cung cấp HTTP endpoint để client gửi câu hỏi.

Luồng hoạt động:

1. Người dùng gửi request đến API Gateway.  
2. API Gateway chuyển request đến Lambda.  
3. Lambda gửi prompt đến Bedrock qua Converse API.  
4. Bedrock thực thi suy luận và trả về kết quả.  
5. Lambda trả kết quả cho client.

Sơ đồ kiến trúc workshop:

![overview](/5-Workshop/5.1-Workshop-overview/diagram-bedrock.png)
