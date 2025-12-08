---
title : "Integrate API with Lambda"
weight : 2
chapter : false
pre : " <b> 5.4.2. </b> "
---

## Integrate API with Lambda

In this step, you will configure the HTTP API so that incoming requests from the client are forwarded to your Lambda function.  
API Gateway will serve as the HTTP interface for your Bedrock-powered chatbot.

---

### 🔹 Step 1 — Open the API you created

Go to **API Gateway Console** and select the API:

`bedrock-chatbot-api`

![h4](/images/5-Workshop/5.4-API-Gateway-Integration/5.4.2-Integrate-Lambda/h4.png)

---

### 🔹 Step 2 — Create a route

1. Go to the **Routes** section  
2. Click **Create**  
3. Configure the route:

- **Method**: `POST`  
- **Resource path**: `/chat`

Click **Create** to add the route.

---

### 🔹 Step 3 — Add Integration with Lambda

1. Click the newly created `/chat` route  
2. In the **Integration** section, choose **Attach integration**

![h5](/images/5-Workshop/5.4-API-Gateway-Integration/5.4.2-Integrate-Lambda/h5.png)

3. Select **Create and attach an integration**, then configure:

- **Integration type**: Lambda function  
- **Region**: The AWS region you are using  
- **Lambda function**: `lambda-bedrock-function` (the Lambda you created earlier)

![h6](/images/5-Workshop/5.4-API-Gateway-Integration/5.4.2-Integrate-Lambda/h6.png)
![h7](/images/5-Workshop/5.4-API-Gateway-Integration/5.4.2-Integrate-Lambda/h7.png)

Click **Create**.

---

### 🎯 Expected Result

You have now:

- Created the `/chat` route  
- Attached the route to your Lambda function  
- Your API now has an endpoint ready for testing  

