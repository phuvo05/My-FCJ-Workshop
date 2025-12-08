---
title : "Cleanup Resources"
weight : 6
chapter : false
pre : " <b> 5.6. </b> "
---

## Cleanup Resources

After completing the workshop, you should delete the AWS resources you no longer need to avoid unnecessary costs.  
Below is a list of the services you created and how to remove them.

---

## 🔹 1. Delete the API Gateway

1. Open the **API Gateway Console**  
2. Select the API you created, e.g., `bedrock-chatbot-api`  
3. Choose **Actions → Delete**  
4. Confirm deletion

This prevents any further requests from reaching Lambda and avoids API Gateway charges.

---

## 🔹 2. Delete the Lambda Function

1. Open the **Lambda Console**  
2. Select the function `bedrock-chatbot-lambda`  
3. Choose **Actions → Delete function**  
4. Confirm deletion

---

## 🔹 3. Delete the IAM Role and Policy

### **Delete the Policy:**

1. Open **IAM Console → Policies**  
2. Search for `lambda-bedrock`  
3. Click **Delete**

### **Delete the Role:**

1. Open **IAM Console → Roles**  
2. Search for `lambda-bedrock-role`  
3. Click **Delete**

> ⚠️ Note: You can only delete the role after deleting the Lambda function that uses it.

---

## 🔹 4. Check CloudWatch Log Groups (Optional)

Lambda logs remain in CloudWatch and may accumulate storage charges over time.

1. Open the **CloudWatch Console**  
2. Select **Logs → Log groups**  
3. Find your Lambda log group (e.g., `/aws/lambda/bedrock-chatbot-lambda`)  
4. Choose **Actions → Delete log group**

---

## 🔹 5. Review Other Resources (If Applicable)

Depending on how you expanded the workshop, you may have created additional resources such as:

- S3 buckets  
- Step Functions  
- KMS keys  
- VPC / Security Groups  

If they are no longer needed, delete them to prevent charges.

---

## 🎉 All Done!

You have now cleaned up all resources created during this workshop.  
Your AWS account will no longer incur costs from the lab environment.

Thank you for participating in the workshop!
