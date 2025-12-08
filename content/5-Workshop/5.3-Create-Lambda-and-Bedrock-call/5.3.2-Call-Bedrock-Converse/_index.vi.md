---
title : "Thêm code gọi Converse API"
weight : 2
chapter : false
pre : " <b> 5.3.2. </b> "
---

## Thêm code gọi Converse API

Trong bước này, bạn sẽ thêm đoạn mã Python vào Lambda Function để gửi câu hỏi đến Amazon Bedrock thông qua **Converse API** và trả kết quả về cho client.

Hàm Lambda sẽ thực hiện các nhiệm vụ sau:

1. Nhận câu hỏi từ client hoặc từ test event  
2. Tạo request theo chuẩn Converse API  
3. Gửi prompt đến Amazon Bedrock Runtime  
4. Nhận kết quả sinh bởi mô hình  
5. Trả phản hồi dạng JSON  

---

## 🔹 Bước 1 — Mở file mã nguồn của Lambda

1. Mở hàm Lambda bạn đã tạo  
2. Cuộn đến phần **Code source**  
3. Mở file `lambda_function.py`

---

## 🔹 Bước 2 — Thay toàn bộ nội dung bằng đoạn mã sau

```python
import json
import boto3

# Tạo client để gọi Bedrock Runtime
bedrock = boto3.client("bedrock-runtime")

# Chọn mô hình hỗ trợ Converse API
MODEL_ID = "anthropic.claude-3-sonnet-20240229"

def lambda_handler(event, context):
    # Nhận dữ liệu từ API Gateway hoặc test event
    body = json.loads(event.get("body", "{}")) if isinstance(event.get("body"), str) else event
    question = body.get("question", "Xin chào! Bạn muốn hỏi gì?")

    # Gửi yêu cầu đến Bedrock bằng Converse API
    response = bedrock.converse(
        modelId=MODEL_ID,
        messages=[
            {
                "role": "user",
                "content": [
                    {"text": question}
                ]
            }
        ]
    )

    # Lấy nội dung trả lời từ output
    answer = response["output"]["message"]["content"][0]["text"]

    # Trả kết quả cho client
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({"answer": answer})
    }
```
---

### 🔹 Lưu ý quan trọng về `MODEL_ID`

Biến `MODEL_ID` trong file `lambda_function.py` có thể được thay đổi tùy theo mô hình bạn muốn sử dụng.  
Tuy nhiên, **mô hình đó phải hỗ trợ Converse API**.

Để xem model ID chính xác:

1. Mở **Amazon Bedrock Console → Model catalog**  
2. Chọn mô hình bạn muốn dùng  
3. Ở khung thông tin mô hình, bạn sẽ thấy phần **Model ID**

Ví dụ minh họa:

![h3](/images/5-Workshop/5.3-Create-Lambda-and-Bedrock-call/h3.png)

Hãy copy đúng Model ID này và dán vào biến:

```python
MODEL_ID = "model-id-ban-chon-tu-bedrock"
```

Nếu mô hình **không hỗ trợ Converse API**, bạn sẽ gặp lỗi khi Lambda gọi `bedrock.converse()`.

---

## 🔹 Bước 3 — Deploy Lambda

Sau khi cập nhật mã:

1. Nhấn **Deploy**  
2. Lambda Function giờ đã sẵn sàng để thực hiện gọi mô hình Bedrock

---

## 🎯 Kết quả mong đợi

Sau bước này, Lambda Function của bạn có thể:

- Nhận câu hỏi từ người dùng  
- Gửi prompt đến Bedrock qua Converse API  
- Nhận phản hồi từ mô hình  
- Trả kết quả dưới dạng JSON  

Bạn đã hoàn thành phần quan trọng nhất của dịch vụ AI Q&A.

---

Tiếp tục xem phần **[5.3.3 – Kiểm thử Lambda Function](../5.3.3-Test-Lambda/)**.
