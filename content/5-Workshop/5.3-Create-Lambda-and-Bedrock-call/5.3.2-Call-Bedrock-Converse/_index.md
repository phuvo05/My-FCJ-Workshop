---
title : "Add Code to Call the Converse API"
weight : 2
chapter : false
pre : " <b> 5.3.2. </b> "
---

## Add Code to Call the Converse API

In this step, you will add Python code to your Lambda Function to send user questions to Amazon Bedrock using the **Converse API**, and return the model’s response to the client.

The Lambda function will perform the following tasks:

1. Receive a question from the client or a test event  
2. Construct a request following the Converse API format  
3. Send the prompt to Amazon Bedrock Runtime  
4. Receive the model-generated answer  
5. Return the response in JSON format  

---

## 🔹 Step 1 — Open the Lambda Function source file

1. Open the Lambda function you created  
2. Scroll to the **Code source** section  
3. Open the file `lambda_function.py`

---

## 🔹 Step 2 — Replace the entire file content with the code below

```python
import json
import boto3

# Create a client to call Bedrock Runtime
bedrock = boto3.client("bedrock-runtime")

# Choose a model that supports the Converse API
MODEL_ID = "anthropic.claude-3-sonnet-20240229"

def lambda_handler(event, context):
    # Receive data from API Gateway or test event
    body = json.loads(event.get("body", "{}")) if isinstance(event.get("body"), str) else event
    question = body.get("question", "Hello! What would you like to ask?")

    # Send request to Bedrock using the Converse API
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

    # Extract the model's response
    answer = response["output"]["message"]["content"][0]["text"]

    # Return the result to the client
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({"answer": answer})
    }
```

---

### 🔹 Important note about `MODEL_ID`

The `MODEL_ID` value inside `lambda_function.py` can be changed to any model you want to use.  
However, the model **must support the Converse API**.

To find the correct Model ID:

1. Open **Amazon Bedrock Console → Model catalog**  
2. Select the model you want to use  
3. In the model information panel, look for **Model ID**

Example:

![h3](/images/5-Workshop/5.3-Create-Lambda-and-Bedrock-call/h3.png)

Copy this Model ID and update the variable:

```python
MODEL_ID = "your-selected-model-id"
```

If the model **does not support the Converse API**, Lambda will throw an error when calling `bedrock.converse()`.

---

## 🔹 Step 3 — Deploy the Lambda Function

After updating the source code:

1. Click **Deploy**  
2. Your Lambda Function is now ready to call Amazon Bedrock

---

## 🎯 Expected Outcome

At the end of this section, your Lambda Function will be able to:

- Receive questions from a client  
- Send prompts to Bedrock using the Converse API  
- Receive model-generated responses  
- Return the result as JSON  

You have now completed the core logic of your AI Q&A service.

---

Continue to **[5.3.3 – Test the Lambda Function](../5.3.3-Test-Lambda/)**.
