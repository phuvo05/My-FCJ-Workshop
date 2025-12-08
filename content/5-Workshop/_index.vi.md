---
title: "Workshop"
weight: 5
chapter: false
pre: " <b> 5. </b> "
---

# Xây API AI đơn giản với AWS Lambda + Bedrock + API Gateway

## Tổng quan

**Amazon Bedrock** là dịch vụ fully managed cung cấp các mô hình ngôn ngữ lớn (LLM) như **Claude**, **Llama**, **Mistral** và **Titan**.  
Bạn có thể tích hợp AI vào ứng dụng chỉ thông qua API mà không cần quản lý hạ tầng hay tự vận hành mô hình.

Trong workshop này, bạn sẽ xây dựng một **API AI Hỏi – Đáp (Q&A)** đơn giản bằng cách kết hợp:

- **AWS Lambda** – xử lý request và gọi Bedrock  
- **Amazon Bedrock Runtime** – gửi prompt và nhận kết quả từ mô hình  
- **Amazon API Gateway** – tạo HTTP endpoint để client gửi câu hỏi  

Điểm quan trọng của workshop là bạn sẽ dùng **Converse API** – giao diện thống nhất cho các mô hình Bedrock **có hỗ trợ Converse** (ví dụ: Claude 3, Claude 3.5, Llama 3.1, Mistral 24.07…).  
Nhờ đó:

- Chỉ cần **đổi `modelId`** trong Lambda là có thể chuyển sang mô hình khác  
- Không phải thay đổi logic xử lý conversation  
- Dễ dàng thử nghiệm, so sánh nhiều mô hình trên cùng một API

> Lưu ý: Chỉ những mô hình Bedrock **có hỗ trợ Converse API** mới dùng được với code trong workshop này.

---

## Nội dung Workshop

1. [Giới thiệu](5.1-Workshop-overview/)
2. [Chuẩn bị](5.2-Prerequisite/)
3. [Lambda gọi Bedrock](5.3-Lambda-call-bedrock/)
4. [Tạo API Gateway](5.4-Api-gateway/)
5. [Kiểm thử](5.5-Testing-and-logs/)
6. [Dọn dẹp](5.6-Cleanup/)
