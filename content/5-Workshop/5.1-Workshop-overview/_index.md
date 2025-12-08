---
title : "Introduction"
weight : 1
chapter : false
pre : " <b> 5.1. </b> "
---

#### Introduction to Amazon Bedrock

+ **Amazon Bedrock** is a fully managed platform that provides access to a wide range of powerful large language models (LLMs). It enables applications to interact with AI models through simple API calls without the need to deploy or manage machine learning infrastructure.
+ Bedrock supports a variety of foundation models such as Claude, Llama, and Titan, making it suitable for tasks like text generation, question-answering, content summarization, and other AI-driven use cases.
+ In a serverless architecture, Bedrock can be integrated directly with **AWS Lambda** to build lightweight, scalable, and easily maintained AI services.

#### Workshop Overview

In this workshop, you will build a simple question-and-answer service using Amazon Bedrock. When a user submits a query, a Lambda function will construct a prompt, send it to a Bedrock model, and return the generated response.

To support this workflow, the workshop makes use of three core components:

+ **Lambda function** – acts as the processing layer, receiving input and invoking Bedrock’s API.
+ **Amazon Bedrock Runtime** – performs the inference based on the selected model.
+ **API Gateway** (optional) – exposes an HTTP endpoint for external clients or users to send their questions.

The high-level workflow of the system is as follows:

1. A user sends a question through API Gateway.  
2. API Gateway forwards the request to the Lambda function.  
3. Lambda invokes Amazon Bedrock with the constructed prompt.  
4. Bedrock returns the generated model output.  
5. Lambda formats and returns the response to the client.

The diagram below illustrates the overall architecture used in this workshop:

![overview](/images/5-Workshop/5.1-Workshop-overview/diagram-bedrock.png)
