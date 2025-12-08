---
title : "Prerequisites"
weight : 2
chapter : false
pre : " <b> 5.2. </b> "
---

## Preparation Steps Before Starting

Before building your AI API using Lambda + Bedrock, you need to configure several AWS resources and permissions.

---

### 1. Choose an AWS Region that Supports Bedrock

Amazon Bedrock is available in several AWS regions.  
For this workshop, you may choose:

- **us-east-1 (N. Virginia)** – commonly used in AWS documentation  
- **ap-southeast-1 (Singapore)** – also supports Bedrock and works normally  

Just make sure the model you want to use (Claude, Llama, Mistral…) is available in that region.

---

### 2. Create an IAM Role for Lambda

Lambda needs an IAM Role to call Bedrock models and write logs to CloudWatch.  
In this section, you will first **create a custom policy**, then **create a role** and attach the policy.

---

## 🔹 Step 1 — Create a New Policy

1. Open **IAM Console → Policies → Create policy**

![h1](/images/5-Workshop/5.2-Prerequisite/h1.png)

---

2. In the “Specify permissions” page, select the **JSON** tab.  
   Delete all existing content and replace it with the following:

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

3. Click **Next**, give the policy a name (e.g., `lambda-bedrock`) and click **Create policy**.

![h3](/images/5-Workshop/5.2-Prerequisite/h3.png)

---

## 🔹 Step 2 — Create the IAM Role and Attach the Policy

1. Go to **IAM Console → Roles → Create role**

![hinh1](/images/5-Workshop/5.2-Prerequisite/hinh1.png)

---

2. Select:

- **Trusted entity type**: AWS service  
- **Use case**: Lambda  

![hinh2](/images/5-Workshop/5.2-Prerequisite/hinh2.png)

---

3. In “Add permissions”, search for the policy you created earlier (`lambda-bedrock`) and select it.

![hinh3](/images/5-Workshop/5.2-Prerequisite/hinh3.png)

---

4. Name your role, for example:

```
lambda-bedrock-role
```

Then click **Create role**.

![hinh4](/images/5-Workshop/5.2-Prerequisite/hinh4.png)

---

Your Lambda execution role is now ready with the minimum permissions required to call Amazon Bedrock and write CloudWatch logs.

---

### 3. Verify the Model Using Bedrock Playground

Before writing Lambda code to call the Converse API, test the model in the AWS Console.

---

## 🔹 Step 1 — Open the Model Catalog

1. Open **Amazon Bedrock → Model catalog**

![hinh5](/images/5-Workshop/5.2-Prerequisite/hinh5.png)

---

## 🔹 Step 2 — Choose a Model and Open Playground

2. Pick a model such as **Claude 3.5 Sonnet**, **Llama 3.1**, or **Mistral 24.07**  
3. Click **Open in playground**

![hinh6](/images/5-Workshop/5.2-Prerequisite/hinh6.png)

---

## 🔹 Step 3 — Send a Test Prompt

Enter a simple question to confirm the model is responding correctly in your selected region.

---

## 🔹 Step 4 — (Optional) Check if the Model Supports the Converse API

If you want to confirm whether the selected model supports **Converse API**, follow these steps:

1. Return to the model page in the catalog  
2. Scroll down to **Code examples**

![hinh7](/images/5-Workshop/5.2-Prerequisite/hinh7.png)

3. AWS will open an example code page.

If the model supports Converse API, the example will include:

```
bedrock.converse(...)
```

Like this:

![hinh8](/images/5-Workshop/5.2-Prerequisite/hinh8.png)

---

### 4. Recommended (Optional) Knowledge

You may find it helpful to know the following:

- Basics of AWS Lambda  
- How to create an HTTP API with API Gateway  
- How to view logs in CloudWatch  

This workshop is beginner-friendly and does not require deep AWS experience.

---

In the next step, you will create a Lambda function and write your first code snippet to call the **Converse API** in Amazon Bedrock.
