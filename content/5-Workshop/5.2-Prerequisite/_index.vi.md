---
title : "Chuẩn bị"
weight : 2
chapter : false
pre : " <b> 5.2. </b> "
---

## Các bước chuẩn bị trước khi bắt đầu

Trước khi triển khai API AI bằng Lambda + Bedrock, bạn cần thiết lập một số tài nguyên và quyền truy cập trong AWS.

---

### 1. Chọn AWS Region hỗ trợ Bedrock

Amazon Bedrock hiện hỗ trợ tại nhiều region khác nhau.  
Trong workshop này, bạn có thể sử dụng:

- **us-east-1 (N. Virginia)** – region thường dùng trong tài liệu AWS  
- **ap-southeast-1 (Singapore)** – cũng hỗ trợ Bedrock và có thể sử dụng bình thường

Chỉ cần đảm bảo mô hình AI bạn định dùng (Claude, Llama, Mistral…) có mặt tại region đó.

---

### 2. Tạo IAM Role cho Lambda

Lambda cần một IAM Role để có quyền gọi mô hình Bedrock và ghi log.  
Trong phần này, bạn sẽ tạo **policy trước**, sau đó tạo **role** và gắn policy vào.

---

## 🔹 Bước 1 — Tạo Policy mới

1. Mở **IAM Console → Policies → Create policy**

![h1](/images/5-Workshop/5.2-Prerequisite/h1.png)

---

2. Ở bước "Specify permissions", bấm chọn tab **JSON** →  
   Xóa toàn bộ nội dung cũ và thay bằng đoạn JSON sau:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "bedrock:InvokeModel",
        "bedrock:InvokeModelWithResponseStream"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
```

![h2](/images/5-Workshop/5.2-Prerequisite/h2.png)

---

3. Chọn **Next**, đặt tên cho policy mới (ví dụ: `lambda-bedrock`) và bấm **Create policy**

![h3](/images/5-Workshop/5.2-Prerequisite/h3.png)

---

## 🔹 Bước 2 — Tạo Role và gắn policy vừa tạo

1. Quay lại **IAM Console → Roles → Create role**

![hinh1](/images/5-Workshop/5.2-Prerequisite/hinh1.png)

---

2. Chọn:
- **Trusted entity type**: AWS service  
- **Use case**: Lambda  

![hinh2](/images/5-Workshop/5.2-Prerequisite/hinh2.png)

---

3. Ở bước "Add permissions", tìm policy bạn vừa tạo (`lambda-bedrock`) và tick chọn nó

![hinh3](/images/5-Workshop/5.2-Prerequisite/hinh3.png)

---

4. Đặt tên cho role, ví dụ:

```
lambda-bedrock-role
```

Sau đó bấm **Create role**

![hinh4](/images/5-Workshop/5.2-Prerequisite/hinh4.png)

---

Vậy là bạn đã hoàn tất tạo IAM Role với quyền tối thiểu để Lambda có thể gọi Amazon Bedrock và ghi log CloudWatch.

---

### 3. Kiểm tra mô hình với Bedrock Playground

Trước khi viết mã gọi Converse API, bạn sẽ kiểm thử nhanh mô hình trong AWS Console.

---

## 🔹 Bước 1 — Mở Model Catalog

1. Mở **Amazon Bedrock → Model catalog**

![hinh5](/images/5-Workshop/5.2-Prerequisite/hinh5.png)

---

## 🔹 Bước 2 — Chọn mô hình và mở Playground

2. Chọn mô hình như **Claude 3.5 Sonnet**, **Llama 3.1**, hoặc **Mistral 24.07**  
3. Bấm **Open in playground** để mở giao diện thử nghiệm mô hình

![hinh6](/images/5-Workshop/5.2-Prerequisite/hinh6.png)

---

## 🔹 Bước 3 — Gửi thử một câu hỏi

Nhập thử một câu hỏi để xác nhận rằng mô hình hoạt động bình thường trong region bạn đã chọn.

---

## 🔹 Bước 4 — (Tuỳ chọn) Kiểm tra mô hình có hỗ trợ Converse API hay không

Nếu bạn muốn kiểm tra mô hình có hỗ trợ **Converse API**, làm theo bước sau:

1. Trở lại trang mô hình trong Model Catalog  
2. Cuộn xuống phần **Code examples**

![hinh7](/images/5-Workshop/5.2-Prerequisite/hinh7.png)

3. AWS sẽ mở một tab mới hiển thị ví dụ code.

Nếu mô hình hỗ trợ **Converse API**, bạn sẽ thấy ví dụ có chứa lệnh:

```
bedrock.converse(...)
```

Như hình minh họa:

![hinh8](/images/5-Workshop/5.2-Prerequisite/hinh8.png)

---

Như vậy là bạn đã kiểm tra xong khả năng hoạt động và hỗ trợ Converse API của mô hình trước khi bắt đầu tích hợp vào Lambda.

---

### 4. Kiến thức cần có (không bắt buộc nhưng hữu ích)

- Hiểu cơ bản về AWS Lambda  
- Biết cách tạo API Gateway dạng HTTP API  
- Biết cách đọc log trong CloudWatch  

Workshop này vẫn phù hợp cho người mới, nên không yêu cầu kiến thức sâu.

---

Ở bước tiếp theo, bạn sẽ tạo Lambda Function và viết đoạn mã đầu tiên để gọi **Converse API** của Bedrock.
