---
title : "Testing and Logs"
weight : 5
chapter : false
pre : " <b> 5.5. </b> "
---

## Testing the API with Thunder Client (VS Code)

After integrating API Gateway with Lambda, you now have an HTTP endpoint ready for testing.  
In this step, you will use **Thunder Client** – a popular VS Code extension to send requests and view responses.

---

## 🔹 Step 1 — Get the Invoke URL from API Gateway

In AWS API Gateway:

1. Open the **API Gateway** service.  
2. Select the API you just created, for example: `bedrock-chatbot-api`.  
3. In the left menu, select **Deploy → Stages**.  
4. Click on the **$default** stage.  
5. In the **Stage details** section, you will see the **Invoke URL**.

![h1](/images/5-Workshop/5.5-Testing-and-Logs/h1.png)
![h3](/images/5-Workshop/5.5-Testing-and-Logs/h3.png)

Copy the **Invoke URL**, for example:

```
https://v8p3h9umxg.execute-api.ap-southeast-1.amazonaws.com
```

Next, add the path route you configured, for example: `/chat`

👉 The complete endpoint will be:

```
https://v8p3h9umxg.execute-api.ap-southeast-1.amazonaws.com/chat
```

---

## 🔹 Step 2 — Install and open Thunder Client in VS Code

1. Open **VS Code**.  
2. Select the **Extensions** tab.  
3. Search for **Thunder Client** and click **Install**.  
4. After installation, the **Thunder Client** icon will appear in the sidebar.  
5. Click on the icon and select **New Request**.  
6. Select the **POST** method.  
7. Paste the endpoint into the URL field:

```
https://v8p3h9umxg.execute-api.ap-southeast-1.amazonaws.com/chat
```

---

## 🔹 Step 3 — Send JSON body and check the response

1. Select the **Body → JSON** tab.  
2. Enter the content:

```json
{
  "question": "What is Amazon Bedrock?"
}
```

Click **Send** to submit the request.

![h2](/images/5-Workshop/5.5-Testing-and-Logs/h2.png)

If the system is working correctly, you will receive a response similar to:

```json
{
  "answer": "Amazon Bedrock is a fully managed service..."
}
```

This confirms that:

- API Gateway received the request successfully  
- Lambda executed correctly and called Bedrock  
- The system returned the expected result  

---

## 🔧 If you encounter errors?

- **403 / AccessDeniedException** → Check Lambda's IAM Role  
- **500 Internal Error** → Check CloudWatch Logs  
- **Missing 'question' field** → Check the JSON body  
- **Timeout** → Increase Lambda timeout to 10–20 seconds  

---

## ✔ Conclusion

Bạn đã kiểm thử thành công toàn bộ pipeline:

**Client → API Gateway → Lambda → Bedrock → Trả kết quả AI**

Bạn đã hoàn tất phần kiểm thử của workshop.
