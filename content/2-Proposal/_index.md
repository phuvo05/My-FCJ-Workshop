---
title: "Proposal"
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

# FitAI Challenge
## An application that helps users lose weight through exercise challenges, integrated with AI for tracking and evaluation

### 1. Executive Summary
FitAI Challenge is a website developed for Vietnamese users, aiming to promote fitness and exercise culture through sports challenges that incorporate gamification and artificial intelligence (AI). The website uses an AI Camera to recognize and count exercise movements such as push-ups, squats, planks, and jumping jacks, while also analyzing posture to provide accurate evaluations.
Users can participate in individual challenges to earn FitPoints upon completing tasks, which can be redeemed for vouchers, gifts, or discounts from partner merchants.
FitAI Challenge targets students, young adults, and working professionals — individuals who need motivation to maintain regular workout habits amid their busy lives.

### 2. Problem Statement
### What’s the Problem?
In Vietnam, most existing fitness applications primarily focus on basic guidance or step counting, and there is currently no platform that combines AI-based motion recognition, gamification, and an online fitness challenge community.
Users often lack motivation to exercise consistently and do not have tools that can accurately evaluate their workout performance. In addition, gyms and sports brands also lack creative engagement channels to connect with young and active customer groups.

### The Solution
FitAI Challenge uses an AI Camera to recognize, count, and evaluate the accuracy of workout movements through Computer Vision.
All user workout data is stored and processed via AWS Cloud using a serverless architecture:
AWS Lambda: processes AI data and backend requests.
AWS S3: stores videos, images, and temporary results.
The website is developed using React Native with a friendly and intuitive interface.
Users can:
Participate in individual, group, or nationwide challenges.
Earn FitPoints upon completing exercises.
Redeem FitPoints for vouchers or gifts from partners (Shopee, Grab, CGV, etc.).
Track leaderboards and share achievements on social media.


### Benefits and Return on Investment
For users:
Create daily workout motivation through challenge and reward mechanisms.
Receive transparent performance evaluations supported by AI.
Connect with the fitness community through leaderboards and sharing feeds.
For partner businesses:
A branding channel associated with a healthy lifestyle.
Access to a young, dynamic, and health-conscious customer base.
For the development team:
Establish a unique “Fitness + Gamification + E-commerce” business model in Vietnam.
Serverless cloud architecture helps reduce operating costs and allows easy scalability.
The MVP can be developed within the first 3 months with low infrastructure costs (estimated at 0.80 USD/month on AWS).


### 3. Solution Architecture
FitAI Challenge is an intelligent sports training platform that applies an AWS Serverless architecture combined with an AI/ML pipeline.
The system’s goal is to record workout data, analyze performance, and generate AI-powered feedback to provide personalized coaching for users.
Data from the web application is sent to Amazon API Gateway, processed by AWS Lambda (Java), and stored in Amazon S3 along with the Docker Database.

![FitAI Challenge Architecture](/images/2-Proposal/2.jpg)
### AWS Services Used
| **Service**                                   | Role                                                                                  |
| --------------------------------------------- | ------------------------------------------------------------------------------------- |
| **Amazon Route 53**                           | Manages domain names and routes traffic to CloudFront.                                |
| **AWS WAF**                                   | Protects frontend and API layers from DDoS and OWASP attacks.                         |
| **Amazon CloudFront**                         | Delivers static content (web app built from Java web, HTML, CSS, JS).                 |
| **Amazon API Gateway**                        | Receives requests from the frontend and forwards them to Lambda functions.            |
| **AWS Lambda (Java)**                         | Handles business logic (registration, login, data upload, scoring, AI pipeline).      |
| **AWS Step Functions & SQS**                  | Coordinates workflows between Lambda and SageMaker/Bedrock.                           |
| **Amazon Cognito**                            | Authenticates users, manages login sessions, and controls access permissions.         |
| **Amazon S3**                                 | Stores raw data, videos, images, and analysis results.                                |
| **Docker**                                    | Runs the Java Spring Boot API backend and hosts the database (PostgreSQL or MongoDB). |
| **Amazon SageMaker**                          | Runs inference for computer vision/pose estimation models.                            |
| **Amazon Bedrock**                            | Generates natural language feedback, training suggestions, and summary reports.       |
| **Amazon SES**                                | Sends authentication emails and user result notifications.                            |
| **Amazon CloudWatch**                         | Monitors logs, Lambda performance, costs, and system efficiency.                      |
| **IAM**                                       | Manages access permissions and security across services.                              |
| **AWS CodePipeline / CodeBuild / CodeDeploy** | CI/CD pipeline for automating Java backend and Lambda deployment.                     |

### Component Design
Frontend Layer:
The web app displays the user interface and connects to the API Gateway.
The content is built and deployed on S3 + CloudFront.
Users access the system through Route 53 → WAF → CloudFront → API Gateway.
Application Layer:
The API Gateway receives requests from the frontend.
Lambda (Java) executes business functions:
AuthLambda: handles user login and authentication.
UploadLambda: receives workout data, images, or videos.
AIPipelineLambda: triggers the AI workflow (SageMaker + Bedrock).
SaveResultLambda: stores training results and AI feedback.

### 4. Technical Implementation
**Implementation Phases**

| Phase | Description | Achieved Outcome |
|---|---|---|
| 1. AWS Infrastructure Setup | Deploy VPC, Private Subnets, Route 53, WAF, S3, API Gateway, Lambda, Cognito, RDS MySQL, VPC Endpoints (S3, Bedrock). | Secure, isolated, and ready-to-use base infrastructure. |
| 2. CI/CD Pipeline | Set up CodeCommit + CodeBuild + CodeDeploy + CodePipeline for Java backend and Lambda; build & deploy web to S3/CloudFront. | Automated deployment for backend and frontend. |
| 3. Build Lambda Functions (Java) | Create Lambdas for Auth, Upload, AI Pipeline, Save Result; connect to RDS MySQL and S3. | Completed serverless backend. |
| 4. AI Pipeline | Integrate SQS, Step Functions, and Bedrock; build workflow: receive job → analyze data → score → generate AI feedback. | Smooth AI operation with automated user feedback. |
| 5. Web App Deployment | Build web app → Deploy to S3 + CloudFront → configure domain in Route 53. | Stable online user interface. |
| 6. Monitoring & Cost Optimization | Use CloudWatch + Cost Explorer to track logs, performance, and costs; tune Lambda, RDS, and CloudFront configurations. | Stable system with low cost and tight monitoring. |

### 5. Timeline & Milestones
**Before internship (Month 0):**

Design detailed architecture based on the new diagram.

Experiment with a simple AI pipeline using Bedrock (text feedback).

**Internship (Months 1–3):**

Month 1:

Set up infrastructure: VPC, Subnets, RDS MySQL, Cognito, API Gateway, Lambda, S3, CloudFront.

Configure CI/CD (CodeCommit, CodeBuild, CodeDeploy, CodePipeline).

Month 2:

Develop Java backend and Lambda functions.

Build the AI pipeline with SQS, Step Functions, and Bedrock.

Month 3:

Integrate frontend with backend.

Run performance tests, pilot with 10–20 users, prepare the final demo.

**Post-deployment:**

Continue optimizing the AI model and add deeper gamification over the next year.

### 6. Budget Estimation
You can view costs on the AWS Pricing Calculator, or download the attached budget estimate.

**Infrastructure Costs (MVP estimate)**

- AWS Services:
  - Amazon API Gateway: 0.38 USD / month (≈300 requests/month, 1 KB/request).
  - Amazon Bedrock: 0.32 USD / month (1 req/min, 350 input tokens, 70 output tokens).
  - Amazon CloudFront: 1.20 USD / month (5 GB transfer, 500,000 HTTPS requests).
  - Amazon CloudWatch: 1.85 USD / month (5 metrics, 0.5 GB logs).
  - Amazon Cognito: 0.00 USD / month (≤100 MAU).
  - Amazon Route 53: 0.51 USD / month (1 hosted zone).
  - Amazon S3: 0.04 USD / month (1 GB storage, 1,000 PUT/POST/LIST, 20,000 GET).
  - Amazon SES: 0.30 USD / month (3,000 emails from EC2/Lambda).
  - Amazon Simple Queue Service (SQS): ≈0.00 USD / month (0.005 million requests/month).
  - AWS Lambda: 0.00 USD / month (≈300,000 requests/month, 512 MB ephemeral storage).
  - AWS Step Functions: 0.00 USD / month (500 workflows, 5 state transitions/workflow).
  - AWS Web Application Firewall (WAF): 6.12 USD / month (1 Web ACL, 1 rule).
  - Amazon RDS MySQL (auto-stop mode): 0–3 USD / month (depending on runtime).

**Total:** around 10.7 – 12 USD / month depending on RDS usage; equivalent to 128 – 144 USD / 12 months.

### 7. Risk Assessment
**Risk Matrix**

- Technical: AI misidentifies movements or fails on image/video processing; misconfigured VPC/Endpoints cause service disruption.
- User: Users don’t maintain workout habits; low return rate.
- Market & Partners: Hard to expand reward partners and co-branding; partner policy changes.
- Cost: Unexpected cost increases when user volume spikes (CloudFront, Bedrock).

**Mitigation Strategies**

- Optimize AI models with continuous training; monitor quality via logs; add basic validation before scoring.
- Deepen gamification (streak chains, friend groups, seasonal challenges, appealing rewards).
- Prepare clear value propositions; diversify partner types (sports, healthy food, entertainment).
- Set AWS Budgets + Alarms per service (CloudFront, Bedrock, Lambda, RDS).

**Contingency Plans**

- If AI fails → use fallback logic (simple time/rep-based scoring) and clearly notify users.
- If user volume drops → launch community challenges, pair with social media campaigns.
- If commercial partners withdraw → maintain internal FitPoints with small rewards (in-app badges/vouchers) while finding new partners.


### 8. Expected Outcomes
**Technical Improvements:**

- Complete the AI motion recognition system with >90% accuracy.
- Stable app that supports up to 10,000 concurrent active users on serverless architecture.
- Optimize architecture to keep infra cost around 10–12 USD/month in the early stage.

**Long-term Value:**

- Build a sustainable Vietnamese fitness community connected via online challenges.
- Become the pioneering “AI + Fitness + Gamification” platform in Vietnam.
- Establish a workout data foundation to expand into health analytics, personalized training programs, and future AI projects.

