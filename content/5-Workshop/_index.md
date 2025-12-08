---
title: "Workshop"
weight: 5
chapter: false
pre: " <b> 5. </b> "
---

# Build a Simple AI API with AWS Lambda + Bedrock + API Gateway

## Overview

**Amazon Bedrock** is a fully managed service that provides access to leading large language models (LLMs) such as **Claude**, **Llama**, **Mistral**, and **Titan**.  
You can integrate AI features into your applications using simple API calls without managing infrastructure or hosting models yourself.

In this workshop, you will build a simple **AI Q&A API** using:

- **AWS Lambda** – handles incoming requests and calls Bedrock  
- **Amazon Bedrock Runtime** – sends prompts and receives model responses  
- **Amazon API Gateway** – exposes an HTTP endpoint for client requests  

A key aspect of this workshop is the use of the **Converse API** — a unified interface for Bedrock models **that support the Converse capability** (e.g., Claude 3, Claude 3.5, Llama 3.1, Mistral 24.07…).  
With the Converse API:

- You can switch models by simply changing the **`modelId`** in Lambda  
- There is no need to rewrite conversation-handling logic  
- You can easily test or compare multiple models with the same API flow  

> Note: Only models **that support Converse API** can be used with the code in this workshop.

---

## Workshop Content

1. [Introduction](5.1-Workshop-overview/)
2. [Prerequisites](5.2-Prerequisite/)
3. [Lambda Calls Bedrock](5.3-Lambda-call-bedrock/)
4. [Create API Gateway](5.4-Api-gateway/)
5. [Testing](5.5-Testing-and-logs/)
6. [Cleanup](5.6-Cleanup/)
