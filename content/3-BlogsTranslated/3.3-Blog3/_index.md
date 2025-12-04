---
title: "Blog 3"
weight: 1
chapter: false
pre: " <b> 3.3. </b> "
---

# Navigating Amazon GuardDuty protection plans and Extended Threat Detection

by Nisha Amthul, Shachar Hirshberg, and Sujay Doshi on 15 SEP 2025 in [Amazon GuardDuty](https://aws.amazon.com/blogs/security/category/security-identity-compliance/amazon-guardduty/), [Intermediate (200)](https://aws.amazon.com/blogs/security/category/learning-levels/intermediate-200/), [Security, Identity, & Compliance](https://aws.amazon.com/blogs/security/category/security-identity-compliance/) [Permalink](https://aws.amazon.com/blogs/security/navigating-amazon-guardduty-protection-plans-and-extended-threat-detection/)  [Comments](https://aws.amazon.com/blogs/security/navigating-amazon-guardduty-protection-plans-and-extended-threat-detection/#Comments)  [Share](https://aws.amazon.com/vi/blogs/security/navigating-amazon-guardduty-protection-plans-and-extended-threat-detection/#)

Organizations are innovating and growing their cloud presence to deliver better customer experiences and drive business value. To support and protect this growth, organizations can use [Amazon GuardDuty](https://aws.amazon.com/guardduty/), a threat detection service that continuously monitors for malicious activity and unauthorized behavior across your AWS environment. GuardDuty uses artificial intelligence (AI), machine learning (ML), and anomaly detection using both AWS and industry-leading threat intelligence to help protect your AWS accounts, workloads, and data. Building on these foundational capabilities, GuardDuty offers a comprehensive suite of protection plans and the [Extended Threat Detection](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) feature.

In this post, we explore how to use these features to provide robust security coverage for your AWS workloads, helping you detect sophisticated threats across your AWS environment.

## **Understanding GuardDuty protection plans**

GuardDuty starts with foundational security monitoring, which analyzes [AWS CloudTrail](https://aws.amazon.com/cloudtrail) management events, [Amazon Virtual Private Cloud (Amazon VPC)](https://aws.amazon.com/vpc) Flow Logs, and DNS logs. Building on this foundation, GuardDuty offers several protection plans that extend its threat detection capabilities to additional AWS services and data sources. These protection plans are optional features that analyze data from specific AWS services in your environment to provide enhanced security coverage. GuardDuty offers the flexibility to customize how new accounts inherit protection plans, so you can add coverage for your accounts or select specific accounts based on your security needs. You can enable or disable these protection plans at any time to align with your evolving workload requirements.

Here are the available GuardDuty protection plans and their capabilities:

| GuardDuty protection plan | Description |
| :---- | :---- |
| [S3 Protection](https://docs.aws.amazon.com/guardduty/latest/ug/s3-protection.html) | Identifies potential security risks such as data exfiltration and destruction attempts in your [Amazon Simple Storage Service (Amazon S3)](https://aws.amazon.com/s3) buckets. |
| [EKS Protection](https://docs.aws.amazon.com/guardduty/latest/ug/kubernetes-protection.html) | EKS audit log monitoring analyzes Kubernetes audit logs from your [Amazon Elastic Kubernetes Service (Amazon EKS)](https://aws.amazon.com/eks) clusters for potentially suspicious and malicious activities. |
| [Runtime Monitoring](https://docs.aws.amazon.com/guardduty/latest/ug/runtime-monitoring.html) | Monitors and analyzes operating system-level events on your Amazon EKS, [Amazon Elastic Compute Cloud (Amazon EC2)](https://aws.amazon.com/ec2), and [Amazon Elastic Container Service (Amazon ECS)](https://aws.amazon.com/ecs) (including [AWS Fargate](https://aws.amazon.com/fargate)), to detect potential runtime threats. |
| [Malware Protection for EC2](https://docs.aws.amazon.com/guardduty/latest/ug/malware-protection.html) | Detects the potential presence of malware by scanning the [Amazon Elastic Block Store (Amazon EBS)](https://aws.amazon.com/ebs) volumes associated with your EC2 instances. There is an option to use this feature on-demand. |
| [Malware Protection for S3](https://docs.aws.amazon.com/guardduty/latest/ug/gdu-malware-protection-s3.html) | Detects the potential presence of malware in the newly uploaded objects within your S3 buckets. |
| [RDS Protection](https://docs.aws.amazon.com/guardduty/latest/ug/rds-protection.html) | Analyzes and profiles your RDS login activity for potential access threats to the supported [Amazon Aurora](https://aws.amazon.com/aurora) and [Amazon Relational Database Service (Amazon RDS)](https://aws.amazon.com/rds) databases. |
| [Lambda Protection](https://docs.aws.amazon.com/guardduty/latest/ug/lambda-protection.html) | Monitors [AWS Lambda](https://aws.amazon.com/lambda) network activity logs, starting with VPC Flow Logs, to detect threats to your Lambda functions. Examples of these potential threats include crypto mining and communicating with malicious servers. |

Let’s explore how these protection plans help secure different aspects of your AWS environment.

### **S3 Protection**

S3 Protection extends threat detection capabilities of GuardDuty to your S3 buckets by monitoring object-level API operations. Beyond basic monitoring, it analyzes patterns of behavior to detect sophisticated threats. When a threat actor attempts to exfiltrate data, GuardDuty can detect unusual sequences of API calls, such as ListBucket operations followed by suspicious GetObject requests from unusual locations. It also identifies potential security risks like attempts to disable S3 server access logging or unauthorized changes to bucket policies that could indicate an attempt to make buckets public. For instance, GuardDuty would generate an UnauthorizedAccess finding if it detects these suspicious API calls originating from known malicious IP addresses.

### **EKS Protection**

For containerized workloads, EKS Protection monitors your Amazon EKS clusters’ control plane audit logs for security threats. It’s specifically designed to detect container-based exploits by analyzing Kubernetes audit logs from your EKS clusters. GuardDuty detects scenarios such as containers deployed with suspicious characteristics (like known malicious images), attempted privilege escalation through role binding modifications, and suspicious service account activities that could indicate compromise of your Kubernetes environment. When detecting such activities, GuardDuty would generate a PrivilegeEscalation finding, alerting you to potential unauthorized access attempts within your clusters. For a comprehensive understanding of the tactics, techniques, and procedures (TTPs), see the [AWS Threat Technique Catalog](https://aws-samples.github.io/threat-technique-catalog-for-aws/).

### **Runtime Monitoring**

Runtime Monitoring provides deeper visibility into potential threats by analyzing runtime behavior in EC2 instances, EKS clusters, and container workloads. This capability detects threats that manifest at the operating system level by monitoring process executions, file system changes, and network connections. GuardDuty can identify defense evasion tactics, execution of suspicious processes, and file access patterns indicating potential malware activity. For example, if a compromised instance attempts to disable security monitoring or creates unusual processes, GuardDuty would generate a Runtime finding indicating potential malicious activity at the OS level.

### **Malware Protection**

Malware Protection offers two distinct capabilities: scanning EBS volumes attached to EC2 instances and scanning objects uploaded to S3 buckets. For EC2 instances, GuardDuty can perform both agentless scan-on-demand and continuous scanning of EBS volumes, detecting both known malware and potentially malicious files using advanced heuristics. For S3, it automatically scans newly uploaded objects, helping protect against malware distribution through your S3 buckets. When malware is detected, GuardDuty generates a Malware finding, specifying whether the threat was found in an EC2 instance or S3 bucket, helping you quickly identify and respond to the threat.

### **RDS Protection**

RDS Protection focuses on database security by analyzing login activity for [supported Amazon Aurora databases](https://docs.aws.amazon.com/guardduty/latest/ug/rds-protection.html). It creates behavioral baselines of normal database access patterns and can detect anomalous sign-in attempts that might indicate unauthorized access attempts. This includes detecting unusual sign-in patterns, access from unexpected locations, and potential database compromise attempts. When suspicious database access is detected, GuardDuty generates an RDS finding, alerting you to potential unauthorized access or credential compromise.

### **Lambda Protection**

Lambda Protection monitors your serverless applications by analyzing Lambda function activity through VPC Flow Logs. It can detect threats specific to serverless environments, such as when Lambda functions exhibit signs of compromise through unexpected network connections or potential cryptocurrency mining activity. If a Lambda function attempts to communicate with known malicious IP addresses or shows signs of cryptojacking, GuardDuty will generate a Lambda finding, so you can quickly identify and remediate compromised functions.

Each protection plan adds specialized detection capabilities designed for specific workload types, working together to provide comprehensive threat detection across your AWS environment. By enabling the protection plans relevant to your workloads, you can help make sure that GuardDuty provides targeted security monitoring for your specific use cases

## **Tailoring GuardDuty protection plans to your workload types**

To maximize threat detection coverage, consider enabling all applicable GuardDuty protection plans across your AWS environment. This approach helps provide comprehensive coverage while maintaining cost efficiency, because you’re only charged for active protections on resources that exist in your account. For example, if you don’t use Amazon EKS, you won’t incur charges for EKS Protection even if it’s enabled. This strategy also helps facilitate automatic security coverage if teams deploy new services, without requiring immediate security team intervention. You retain the flexibility to adjust your protection plans at any time as your workload requirements evolve.

Based on AWS security best practices, we offer recommendations for different protection plan combinations aligned with common workload profiles. These recommendations help you understand how different protection plans work together to secure your specific architectures. For Amazon EC2 and Amazon S3 workloads, GuardDuty recommends Foundational, Amazon S3 Protection, and Amazon GuardDuty Malware Protection for Amazon EC2 to detect threats to compute instances, data storage, and [AWS Identity and Access Management (IAM)](https://aws.amazon.com/iam/) misuse.

Container-heavy environments using Amazon EKS and Amazon ECS benefit from Foundational, Amazon EKS Protection, Amazon GuardDuty Runtime Monitoring, and Amazon GuardDuty Malware Protection for Amazon EC2. These plans work together to monitor container control-plane and runtime for threats and malware.

For serverless-first architectures built on Lambda, GuardDuty suggests Foundational, AWS Lambda Protection, and Amazon S3 Protection (if using Amazon S3 triggers) to identify anomalous function behavior and suspicious traffic patterns.

Data systems using Amazon Aurora or Amazon RDS should consider Foundational, Amazon RDS Protection, Amazon S3 Protection, and Amazon GuardDuty Malware Protection for Amazon S3. This combination helps detect anomalous database sign-ins and potential S3 bucket misuse.

For regulated environments or those implementing zero-trust architectures, enabling all GuardDuty protection plans helps provide comprehensive threat detection coverage that can support your broader security monitoring and compliance program requirements.

For quick reference, here’s what protection plans you should use to actively monitor your different workload types:

| Workload profile | Expected security outcomes | Recommended GuardDuty plans |
| :---- | :---- | :---- |
| Amazon EC2 and Amazon S3 | Detect threats to compute instances, data storage, and IAM misuse | Foundational, Amazon S3 Protection, and Amazon GuardDuty Malware Protection for Amazon EC2 |
| Container-heavy (Amazon EKS, Amazon ECS) | Monitor container control-plane and runtime for threats and malware | Foundational, Amazon EKS Protection, Amazon GuardDuty Runtime Monitoring, and Amazon GuardDuty Malware Protection for Amazon EC2 |
| Serverless-first (AWS Lambda) | Identify anomalous function behavior and suspicious traffic patterns | Foundational, GuardDuty Lambda Protection, GuardDuty S3 Protection (if using Amazon S3 triggers), and GuardDuty Runtime Monitoring for ECS on Fargate |
| Data system (Amazon Aurora or Amazon RDS) | Detect anomalous database logins and potential S3 bucket misuse | Foundational, Amazon RDS Protection, GuardDuty S3 Protection, and Amazon GuardDuty Malware Protection for Amazon S3 |
| Regulated and Zero-Trust | Comprehensive threat detection to support compliance requirements | All Amazon GuardDuty protection plans |

## **The power of GuardDuty Extended Threat Detection**

Building upon these protection plans, GuardDuty offers Extended Threat Detection by default at no additional cost, using AI/ML capabilities to provide improved threat detection for your applications, workloads, and data. This capability correlates security signals to identify active threat sequences, offering a more comprehensive approach to cloud security.

Extended Threat Detection includes a *Critical* severity level for the most urgent and high-confidence threats based on correlating multiple steps taken by adversaries, such as privilege discovery, API manipulation, persistence activities, and data exfiltration. Integration with the MITRE ATT\&CK® framework allows GuardDuty to map observed activities to tactics and techniques, providing context for security teams. To help teams respond quickly, GuardDuty provides specific remediation recommendations based on AWS best practices for each identified threat.

## **Real-world protection: Extended Threat Detection in action**

To understand how GuardDuty protection plans and Extended Threat Detection work together in practice, let’s examine two sophisticated threat scenarios that security teams commonly face: data compromise and container cluster compromise.

### **Data compromise detection**

GuardDuty Extended Threat Detection continuously analyzes and correlates events across multiple protection plans, providing comprehensive visibility when data compromise attempts occur in Amazon S3. For example, in a recent incident, GuardDuty identified a critical severity attack sequence spanning 24 hours. The sequence began with discovery actions through unusual S3 API calls, progressed to defense evasion through CloudTrail modifications, and culminated in potential data exfiltration attempts.

During the discovery phase, S3 Protection detected an IAM role making unusual ListBuckets and GetObject API calls across multiple buckets—a significant deviation from their normal pattern of accessing only specific assigned buckets. Extended Threat Detection then correlated this suspicious activity with subsequent actions from the same IAM role: attempts to disable CloudTrail logging and modify bucket policies (classic signs of defense evasion), followed by the creation of new access keys. This connected sequence of events, all from the same identity, indicated a progressing exploit moving from initial discovery to establishing persistence through credential creation.

### **Container environment compromise**

Protecting containerized environments requires visibility across multiple layers of your Amazon EKS infrastructure. GuardDuty combines signals from EKS control plane (through EKS Protection), container runtime behavior (through Runtime Monitoring), and foundational infrastructure logs to provide comprehensive threat detection for your Kubernetes clusters. For example, EKS Protection detects suspicious activities at the Kubernetes control plane level, such as unusual kubernetes API server authentication attempts or the creation of service accounts with elevated permissions. Runtime Monitoring provides visibility into container behavior, identifying unexpected privileged commands or suspicious file system access. Together with foundational logs, these components provide multi-layer threat detection for your container workloads.

Here’s how these components worked together in detecting an attack sequence: The exploit began when EKS Protection detected unusual Kubernetes API server authentication attempts from a container within the cluster. Runtime Monitoring simultaneously observed commands that deviated from the container’s baseline behavior, such as privilege escalation attempts and unauthorized system calls. As the exploit progressed, GuardDuty detected the creation of a Kubernetes service account with elevated permissions, followed by attempts to mount sensitive host paths to containers.

The scenario then escalated when the compromised Kubernetes Pod established connections to other Pods across namespaces, suggesting lateral movement. GuardDuty Extended Threat Detection correlated these events with the Pod accessing sensitive Kubernetes secrets and AWS credentials stored in Kubernetes ConfigMaps. The final stage revealed the compromised Pod making AWS API calls using stolen credentials, targeting resources outside the cluster’s normal operational scope.

The detection of this multi-stage attack, spanning container exploitation, privilege escalation, and credential theft, demonstrates the power of the correlation capabilities of Extended Threat Detection. Security teams received a single critical finding that mapped the entire exploit sequence to MITRE ATT\&CK® tactics, providing clear visibility into the exploit progression and specific remediation steps.

These real-world scenarios illustrate how GuardDuty protection plans work in concert with Extended Threat Detection to provide deep security insights. The combination of targeted protection plans and AI-powered correlation helps security teams identify and respond to sophisticated threats that might otherwise go unnoticed or be difficult to piece together manually.

## **Conclusion**

GuardDuty protection plans, coupled with its built-in Extended Threat Detection feature, offer a powerful suite of managed detections to secure your AWS environment. By tailoring your security strategy to your specific workload types and using AI-powered insights, you can significantly enhance your ability to detect and respond to sophisticated threats. To get started with GuardDuty protection plans and Extended Threat Detection, visit the GuardDuty console. Each protection plan includes a 30-day trial at no additional cost per AWS account and AWS Region, allowing you to evaluate the security coverage for your specific needs. Remember, you can adjust your enabled plans at any time to align with your evolving security requirements and workload changes. By using these capabilities, you can strengthen your organization’s threat detection and response in the face of evolving security risks.

### **Nisha Amthul**
![Nisha Amthul](/images/3-BlogsTranslated/3.3-Blog3/image1.jpg)
Nisha is a Senior Product Marketing Manager at AWS Security, specializing in detection and response solutions. She has a strong foundation in product management and product marketing within the domains of information security and data protection. When not at work, you’ll find her cake decorating, strength training, and chasing after her two energetic kiddos.

### 

### 

### **Sujay Doshi**
![Sujay Doshi](/images/3-BlogsTranslated/3.3-Blog3/image2.jpeg)
Sujay is a Senior Product Manager at AWS, focusing on security services. With over 10 years of experience in product management and software development, he leads the product strategy for Amazon GuardDuty. Prior to AWS, Sujay held leadership roles at various technology companies. He’s passionate about cloud security and describes himself as “a data nerd with a penchant for finding needles in the cyber haystack.

### **Shachar Hirshberg**
![Shachar Hirshberg](/images/3-BlogsTranslated/3.3-Blog3/image3.png)
Shachar was a Senior Product Manager for Amazon GuardDuty with over a decade of experience in building, designing, launching, and scaling enterprise software. He is passionate about further improving how customers harness AWS services to enable innovation and enhance the security of their cloud environments. Outside of work, Shachar is an avid traveler and a skiing enthusiast.

