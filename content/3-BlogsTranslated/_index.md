---
title: "Translated Blogs"
weight: 3
chapter: false
pre: " <b> 3. </b> "
---


This section will list and introduce the blogs you have translated. For example:

###  [Blog 1 - Migrating from AWS CodeDeploy to Amazon ECS for blue/green deployments](3.1-Blog1/)
This blog introduces how to migrate from AWS CodeDeploy to Amazon ECS blue/green deployments. It explains that ECS now supports native blue/green deployments, removing the need for CodeDeploy. Key advantages include support for ECS ServiceConnect, headless services, Amazon EBS volumes, and multiple target groups. It details API, CLI, and console differences, lifecycle hook mappings, and deployment workflow variations. Three migration options are outlined:

1. **In-place update** â€” simplest, no downtime  
2. **New service using existing load balancer** â€” safer, minimal disruption  
3. **New service with new load balancer** â€” zero downtime, higher cost


###  [Blog 2 - Break down data silos and seamlessly query Iceberg tables in Amazon SageMaker from Snowflake](3.2-Blog2/)

This blog explains how to **query Apache Iceberg tables in Amazon SageMakerâ€™s lakehouse** directly from **Snowflake**, enabling unified analytics without ETL or data duplication.  

Using **AWS Glue Data Catalog**, **Lake Formation**, and the **Glue Iceberg REST endpoint**, Snowflake users can securely query data stored in **Amazon S3**.  

The integration supports **credential vending via Lake Formation** and **SigV4 authentication** for secure access. It enables seamless cross-platform analytics, improving **data accessibility**, **consistency**, and **cost efficiency**.  

The guide outlines **prerequisites, IAM and Lake Formation setup**, and **Snowflake catalog integration steps**, empowering organizations to **break data silos** and enhance decision-making across their data ecosystem.


###  [Blog 3 - Navigating Amazon GuardDuty protection plans and Extended Threat Detection](3.3-Blog3/)
This blog introduces **Amazon GuardDuty**, which now offers a suite of **protection plans** and **Extended Threat Detection (ETD)** to enhance AWS security monitoring.  

Protection plans extend coverage to specific servicesâ€”**S3, EKS, EC2, ECS, Lambda, RDS**, and moreâ€”detecting threats such as **malware**, **privilege escalation**, and **data exfiltration**.  

**ETD** leverages **AI/ML** to correlate events across services, identifying multi-stage attacks with high confidence and mapping them to **MITRE ATT&CK** tactics.  

GuardDuty recommends tailored plan combinations by workload type (EC2, containerized, serverless, database, or regulated environments).  

Together, these features deliver **comprehensive, automated threat detection** and **actionable insights** to secure AWS workloads with minimal operational overhead.

