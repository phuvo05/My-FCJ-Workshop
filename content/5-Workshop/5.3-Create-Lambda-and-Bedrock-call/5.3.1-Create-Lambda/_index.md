---
title : "Create Lambda Function"
weight : 1
chapter : false
pre : " <b> 5.3.1. </b> "
---

## Create Lambda Function

In this step, you will create a new AWS Lambda function that will receive requests from the client and send prompts to Amazon Bedrock using the Converse API.

---

### 🔹 Step 1 — Open the Lambda creation page

1. Go to the **AWS Lambda Console**  
2. Select **Functions**  
3. Click **Create function**

![h1](/images/5-Workshop/5.3-Create-Lambda-and-Bedrock-call/h1.png)

---

### 🔹 Step 2 — Set the name and configuration for the Lambda function

Configure the function as follows:

- **Function name**: `bedrock-chatbot-lambda`  
- **Runtime**: `Python 3.12` *(recommended and stable for this workshop)*  
- **Architecture**: `x86_64` or `arm64` *(both are supported)*  
- **Permissions → Use an existing role**  
  - Select the role you created in the Prerequisites section, for example:  
    **`lambda-bedrock-role`**

Then click **Create function**.

![h2](/images/5-Workshop/5.3-Create-Lambda-and-Bedrock-call/h2.png)

---

### 🎯 Expected result

You now have an empty Lambda function that:

- Is ready for adding the Converse API invocation code  
- Has an execution role with Bedrock permissions + CloudWatch logging  
- Can be tested directly in the Lambda Console  

In the next section, you will configure the IAM role further and prepare the source code to call the model.

---

Continue to **[5.3.2 – Add code to call the Converse API](../5.3.2-Call-Bedrock-Converse/)**.
