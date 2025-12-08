---
title : "Kiểm thử"
weight : 5
chapter : false
pre : " <b> 5.5. </b> "
---

## Kiểm thử API bằng Thunder Client (VS Code)

Sau khi đã tích hợp API Gateway với Lambda, bạn đã có một endpoint HTTP sẵn sàng để kiểm thử.  
Trong bước này, bạn sẽ sử dụng **Thunder Client** – một extension phổ biến trong VS Code để gửi request và xem phản hồi.

---

## 🔹 Bước 1 — Lấy Invoke URL từ API Gateway

Trong AWS API Gateway:

1. Mở service **API Gateway**.
2. Chọn API vừa tạo, ví dụ: `bedrock-chatbot-api`.
3. Ở menu bên trái, chọn **Deploy → Stages**.
4. Nhấp vào stage **$default**.
5. Trong phần **Stage details**, bạn sẽ thấy **Invoke URL**.

![h1](/5-Workshop/5.5-Testing-and-logs/h1.png)
![h3](/5-Workshop/5.5-Testing-and-logs/h3.png)


Sao chép **Invoke URL**, ví dụ:

https://v8p3h9umxg.execute-api.ap-southeast-1.amazonaws.com


Tiếp theo, thêm route path bạn đã cấu hình, ví dụ: /chat


👉 Endpoint đầy đủ sẽ là:

https://v8p3h9umxg.execute-api.ap-southeast-1.amazonaws.com/chat

---

## 🔹 Bước 2 — Cài và mở Thunder Client trong VS Code

1. Mở **VS Code**.
2. Vào tab **Extensions** (biểu tượng ô vuông).
3. Tìm **Thunder Client** và nhấn **Install**.
4. Sau khi cài xong, icon **Thunder Client** sẽ xuất hiện ở sidebar bên trái.
5. Nhấp icon đó và chọn **New Request**.
6. Chọn method **POST**.
7. Dán endpoint đã tạo vào ô URL:
https://v8p3h9umxg.execute-api.ap-southeast-1.amazonaws.com/chat

---

## 🔹 Bước 3 — Gửi JSON body và kiểm tra phản hồi

1. Trong cửa sổ request, chọn tab **Body → JSON**.
2. Nhập nội dung:

```json
{
  "question": "Amazon Bedrock là gì?"
}
```
Nhấn Send để gửi request.
![h2](/5-Workshop/5.5-Testing-and-logs/h2.png)
Nếu hệ thống hoạt động đúng, bạn sẽ nhận được phản hồi tương tự:
{
  "answer": "Amazon Bedrock is a fully managed service..."
}
Điều này xác nhận rằng:

- API Gateway nhận request thành công

- Lambda chạy đúng và gọi Bedrock

- Hệ thống trả về kết quả theo mong đợi

🔧 Nếu gặp lỗi?

- 403 / AccessDeniedException → Kiểm tra IAM Role của Lambda

- 500 Internal Error → Xem CloudWatch Logs

- Missing 'question' field → Kiểm tra JSON body

- Timeout → Tăng timeout của Lambda lên 10–20s

## Kết luận

Bạn đã kiểm thử thành công toàn bộ pipeline:

Client → API Gateway → Lambda → Bedrock → Trả kết quả AI

Bạn đã hoàn tất phần kiểm thử của workshop.