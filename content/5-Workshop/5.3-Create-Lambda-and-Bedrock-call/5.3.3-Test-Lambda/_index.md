---
title : "Test Lambda Function"
weight : 3
chapter : false
pre : " <b> 5.3.3. </b> "
---

## Test Lambda Function

After creating the Lambda Function and adding the code to call Amazon Bedrock using the **Converse API**, the next step is to test the function to ensure everything works correctly.

In this section, you will:

1. Create a test event in the Lambda Console  
2. Send a sample question to the Bedrock model  
3. Review the response and check logs if any errors occur  

---

### 🔹 Step 1 — Open Lambda and Create a Test Event

1. Go to **AWS Lambda Console**  
2. Select the function: `bedrock-chatbot-lambda`  
3. Click the **Test** button  
4. Choose **Create new event** if this is your first test  
5. Enter an event name, for example:

- **Event name**: `test-bedrock-converse`

Scroll down to the JSON editor and **replace the entire content with**:

```json
{
  "question": "What is Amazon Bedrock?"
}
```

Example illustration:

![h4](/5-Workshop/5.3-Create-Lambda-and-Bedrock-call/h4.png)

Click **Save** to store the test event.

---

### 🔹 Step 2 — Run the Test and Review the Output

1. Select the event you just created  
2. Click **Test**

If everything is working correctly, Lambda should return a response similar to:

```json
{
  "answer": "Amazon Bedrock is a fully managed service..."
}
```

The `"answer"` field contains the model’s generated response.

---

### 🔹 Step 3 — Check CloudWatch Logs if Errors Occur

If the Lambda function throws an error or behaves unexpectedly:

1. Open the **Monitor** tab  
2. Click **View logs in CloudWatch**  
3. Open the most recent log stream to inspect the execution details

Common issues and fixes:

#### ❌ **AccessDeniedException**
- Cause: Lambda Execution Role lacks `bedrock:InvokeModel`  
- Fix: Re-check the IAM Role created in the *Prerequisites* section

#### ❌ **Timeout**
- Cause: Default Lambda timeout (3 seconds) is too short  
- Fix: Go to **Configuration → General** and increase timeout to 10–20 seconds

#### ❌ **KeyError or missing question field**
- Cause: Payload is missing the `"question"` key  
- Fix: Ensure the test event JSON is formatted like:

```json
{
  "question": "Your question here"
}
```

---

### 🎯 Expected Outcome

After completing this step, you will:

- Confirm that Lambda successfully invokes Bedrock  
- Receive responses from the model via the Converse API  
- Verify that your IAM Role and MODEL_ID are correctly configured  
- Be ready to move on to building the API endpoint

---
