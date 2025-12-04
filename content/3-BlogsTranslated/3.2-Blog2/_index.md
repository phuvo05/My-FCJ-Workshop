---
title: "Blog 2"
weight: 1
chapter: false
pre: " <b> 3.2. </b> "
---

# Break down data silos and seamlessly query Iceberg tables in Amazon SageMaker from Snowflake

by Nidhi Gupta and Andries Engelbrecht on 15 SEP 2025 in [Advanced (300)](https://aws.amazon.com/blogs/big-data/category/learning-levels/advanced-300/), [Amazon SageMaker Lakehouse](https://aws.amazon.com/blogs/big-data/category/analytics/amazon-sagemaker-lakehouse/), [Amazon Simple Storage Service (S3)](https://aws.amazon.com/blogs/big-data/category/storage/amazon-simple-storage-services-s3/), [AWS Glue](https://aws.amazon.com/blogs/big-data/category/analytics/aws-glue/), [AWS Lake Formation](https://aws.amazon.com/blogs/big-data/category/analytics/aws-lake-formation/), [Partner solutions](https://aws.amazon.com/blogs/big-data/category/post-types/partner-solutions/), [S3 Select](https://aws.amazon.com/blogs/big-data/category/storage/s3-select/), [Technical How-to](https://aws.amazon.com/blogs/big-data/category/post-types/technical-how-to/) [Permalink](https://aws.amazon.com/blogs/big-data/break-down-data-silos-and-seamlessly-query-iceberg-tables-in-amazon-sagemaker-from-snowflake/)  [Comments](https://aws.amazon.com/blogs/big-data/break-down-data-silos-and-seamlessly-query-iceberg-tables-in-amazon-sagemaker-from-snowflake/#Comments)  [Share](https://aws.amazon.com/vi/blogs/big-data/break-down-data-silos-and-seamlessly-query-iceberg-tables-in-amazon-sagemaker-from-snowflake/#)

Organizations often struggle to unify their data ecosystems across multiple platforms and services. The connectivity between [Amazon SageMaker](https://aws.amazon.com/sagemaker/) and [Snowflake’s AI Data Cloud](https://www.snowflake.com/en/) offers a powerful solution to this challenge, so businesses can take advantage of the strengths of both environments while maintaining a cohesive data strategy.

In this post, we demonstrate how you can break down data silos and enhance your analytical capabilities by querying Apache Iceberg tables in the [lakehouse architecture of SageMaker](https://aws.amazon.com/sagemaker/lakehouse/) directly from Snowflake. With this capability, you can access and analyze data stored in [Amazon Simple Storage Service](https://aws.amazon.com/s3/) (Amazon S3) through [AWS Glue Data Catalog](https://docs.aws.amazon.com/glue/latest/dg/catalog-and-crawler.html) using an [AWS Glue Iceberg REST endpoint](https://docs.aws.amazon.com/glue/latest/dg/access_catalog.html), all secured by [AWS Lake Formation](https://aws.amazon.com/lake-formation/), without the need for complex extract, transform, and load (ETL) processes or data duplication. You can also automate table discovery and refresh using [Snowflake catalog-linked databases for Iceberg](https://docs.snowflake.com/en/user-guide/tables-iceberg-catalog-linked-database). In the following sections, we show how to set up this integration so Snowflake users can seamlessly query and analyze data stored in AWS, thereby improving data accessibility, reducing redundancy, and enabling more comprehensive analytics across your entire data ecosystem.

## **Business use cases and key benefits**

The capability to query Iceberg tables in SageMaker from Snowflake delivers significant value across multiple industries:

* Financial services – Enhance fraud detection through unified analysis of transaction data and customer behavior patterns  
* Healthcare – Improve patient outcomes through integrated access to clinical, claims, and research data  
* Retail – Increase customer retention rates by connecting sales, inventory, and customer behavior data for personalized experiences  
* Manufacturing – Boost production efficiency through unified sensor and operational data analytics  
* Telecommunications – Reduce customer churn with comprehensive analysis of network performance and customer usage data

Key benefits of this capability include:

* Accelerated decision-making – Reduce time to insight through integrated data access across platforms  
* Cost optimization – Accelerate time to insight by querying data directly in storage without the need for ingestion  
* Improved data fidelity – Reduce data inconsistencies by establishing a single source of truth  
* Enhanced collaboration – Increase cross-functional productivity through simplified data sharing between data scientists and analysts

By using the lakehouse architecture of SageMaker with Snowflake’s serverless and zero-tuning computational power, you can break down data silos, enabling comprehensive analytics and democratizing data access. This integration supports a modern data architecture that prioritizes flexibility, security, and analytical performance, ultimately driving faster, more informed decision-making across the enterprise.

## **Solution overview**

The following diagram shows the architecture for catalog integration between Snowflake and Iceberg tables in the lakehouse.

![Catalog integration to query Iceberg tables in S3 bucket using Iceberg REST Catalog (IRC) with credential vending](/images/3-BlogsTranslated/3.2-Blog2/image1.png)

The workflow consists of the following components:

* Data storage and management:  
  * Amazon S3 serves as the primary storage layer, hosting the Iceberg table data  
  * The Data Catalog maintains the metadata for these tables  
  * Lake Formation provides credential vending  
* Authentication flow:  
  * Snowflake initiates queries using a catalog integration configuration  
  * Lake Formation vends temporary credentials through [AWS Security Token Service](https://docs.aws.amazon.com/STS/latest/APIReference/welcome.html) (AWS STS)  
  * These credentials are automatically refreshed based on the configured refresh interval  
* Query flow:  
  * Snowflake users submit queries against the mounted Iceberg tables  
  * The AWS Glue Iceberg REST endpoint processes these requests  
  * Query execution uses Snowflake’s compute resources while reading directly from Amazon S3  
  * Results are returned to Snowflake users while maintaining all security controls

There are four patterns to query Iceberg tables in SageMaker from Snowflake:

* Iceberg tables in an S3 bucket using an AWS Glue Iceberg REST endpoint and Snowflake Iceberg REST catalog integration, with credential vending from Lake Formation  
* Iceberg tables in an S3 bucket using an AWS Glue Iceberg REST endpoint and Snowflake Iceberg REST catalog integration, using Snowflake external volumes to Amazon S3 data storage  
* Iceberg tables in an S3 bucket using AWS Glue API catalog integration, also using Snowflake external volumes to Amazon S3  
* [Amazon S3 Tables using Iceberg REST catalog integration with credential vending](https://aws.amazon.com/blogs/storage/connect-snowflake-to-s3-tables-using-the-sagemaker-lakehouse-iceberg-rest-endpoint/) from Lake Formation

In this post, we implement the first of these four access patterns using [catalog integration](https://docs.snowflake.com/en/user-guide/tables-iceberg-configure-catalog-integration-rest#sigv4-glue) for the AWS Glue Iceberg REST endpoint with [Signature Version 4 (SigV4)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html) authentication in Snowflake.

## **Prerequisites**

You must have the following prerequisites:

* A [Snowflake account](https://signup.snowflake.com/).  
* An [AWS Identity and Access Management](https://aws.amazon.com/iam/) (IAM) role that is a Lake Formation data lake administrator in your AWS account. A data lake administrator is an IAM principal that can register Amazon S3 locations, access the Data Catalog, grant Lake Formation permissions to other users, and view [AWS CloudTrail](https://aws.amazon.com/cloudtrail). See [Create a data lake administrator](https://docs.aws.amazon.com/lake-formation/latest/dg/initial-LF-setup.html#create-data-lake-admin) for more information.  
* An existing [AWS Glue](https://aws.amazon.com/glue/) database named iceberg\_db and Iceberg table named customer with data stored in an S3 general purpose bucket with a unique name. To create the table, refer to the [table schema](https://github.com/gregrahn/tpch-kit/blob/master/dbgen/dss.ddl) and [dataset](https://github.com/gregrahn/tpch-kit/blob/master/ref_data/1/customer.tbl.1).  
* A user-defined IAM role that Lake Formation assumes when accessing the data in the aforementioned S3 location to vend scoped credentials (see [Requirements for roles used to register locations](https://docs.aws.amazon.com/lake-formation/latest/dg/registration-role.html)). For this post, we use the IAM role LakeFormationLocationRegistrationRole.

The solution takes approximately 30–45 minutes to set up. Cost varies based on data volume and query frequency. Use the [AWS Pricing Calculator](https://calculator.aws/#/) for specific estimates.

## **Create an IAM role for Snowflake**

To create an IAM role for Snowflake, you first create a policy for the role:

1. On the IAM console, choose Policies in the navigation pane.  
2. Choose Create policy.  
3. Choose the JSON editor and enter the following policy (provide your AWS Region and account ID), then choose Next.
```yml
{

     "Version": "2012-10-17",

     "Statement": [

         {

         	"Sid": "AllowGlueCatalogTableAccess",

         	"Effect": "Allow",

         	"Action": [

             	"glue:GetCatalog",

             	"glue:GetCatalogs",

                 "glue:GetPartitions",

             	"glue:GetPartition",

             	"glue:GetDatabase",

             	"glue:GetDatabases",

             	"glue:GetTable",

             	"glue:GetTables",

             	"glue:UpdateTable"

         	],

         	"Resource": [

                 "arn:aws:glue:<region\>:<account-id\>:catalog",

                 "arn:aws:glue:<region\>:<account-id\>:database/iceberg_db",

                 "arn:aws:glue:<region\>:<account-id\>:table/iceberg_db/\*",

         	]

         },

         {

         	"Effect": "Allow",

         	"Action": [

                 "lakeformation:GetDataAccess"

         	],

         	"Resource": "*"

         }
```
4. Enter iceberg-table-access as the policy name.  
5. Choose Create policy.

Now you can create the role and attach the policy you created.

6. Choose Roles in the navigation pane.  
7. Choose Create role.  
8. Choose AWS account.  
9. Under Options, select Require External Id and enter an external ID of your choice.  
10. Choose Next.  
11. Choose the policy you created (iceberg-table-access policy).  
12. Enter snowflake\_access\_role as the role name.  
13. Choose Create role.

## **Configure Lake Formation access controls**

To configure your Lake Formation access controls, first set up the application integration:

1. Sign in to the Lake Formation console as a data lake administrator.  
2. Choose Administration in the navigation pane.  
3. Select Application integration settings.  
4. Enable Allow external engines to access data in Amazon S3 locations with full table access.  
5. Choose Save.

Now you can grant permissions to the IAM role.

6. Choose Data permissions in the navigation pane.  
7. Choose Grant.  
8. Configure the following settings:  
   1. For Principals, select IAM users and roles and choose snowflake\_access\_role.  
   2. For Resources, select Named Data Catalog resources.  
   3. For Catalog, choose your AWS account ID.  
   4. For Database, choose iceberg\_db.  
   5. For Table, choose customer.  
   6. For Permissions, select SUPER.  
9. Choose Grant.

SUPER access is required for mounting the Iceberg table in Amazon S3 as a Snowflake table.

## **Register the S3 data lake location**

Complete the following steps to register the S3 data lake location:

1. As data lake administrator on the Lake Formation console, choose Data lake locations in the navigation pane.  
2. Choose Register location.  
3. Configure the following:  
   1. For S3 path, enter the S3 path to the bucket where you will store your data.  
   2. For IAM role, choose LakeFormationLocationRegistrationRole.  
   3. For Permission mode, choose Lake Formation.  
4. Choose Register location.

## **Set up the Iceberg REST integration in Snowflake**

Complete the following steps to set up the Iceberg REST integration in Snowflake:

1. Log in to Snowflake as an admin user.  
2. Execute the following SQL command (provide your Region, account ID, and external ID that you provided during IAM role creation):
```yml
CREATE OR REPLACE CATALOG INTEGRATION glue_irc_catalog_int  
CATALOG_SOURCE = ICEBERG_REST  
TABLE_FORMAT = ICEBERG  
CATALOG_NAMESPACE = 'iceberg_db'  
REST_CONFIG = (  
    CATALOG_URI = 'https://glue.<region>.amazonaws.com/iceberg'  
    CATALOG_API_TYPE = AWS_GLUE  
    CATALOG_NAME = '<account-id>'  
    ACCESS_DELEGATION_MODE = VENDED_CREDENTIALS  
)  
REST_AUTHENTICATION = (  
    TYPE = SIGV4  
    SIGV4_IAM_ROLE = 'arn:aws:iam::<account-id>:role/snowflake_access_role'  
    SIGV4_SIGNING_REGION = '<region>'  
    SIGV4_EXTERNAL_ID = '<external-id>'  
)  
REFRESH_INTERVAL_SECONDS = 120

ENABLED = TRUE;
```
3. Execute the following SQL command and retrieve the value for API\_AWS\_IAM\_USER\_ARN:
```yml
DESCRIBE CATALOG INTEGRATION glue_irc_catalog_int;
```
4. On the IAM console, update the trust relationship for snowflake\_access\_role with the value for API\_AWS\_IAM\_USER\_ARN:
```yml
{  
    "Version": "2012-10-17",  
    "Statement": [  
        {  
            "Sid": "",  
            "Effect": "Allow",  
            "Principal": {  
                "AWS": [  
                   "<API_AWS_IAM_USER_ARN>"  
                ]  
            },  
            "Action": "sts:AssumeRole",  
            "Condition": {  
                "StringEquals": {  
                    "sts:ExternalId": [  
                        "<external-id>"  
                    ]  
                }  
            }  
        }  
    \]

}
```
5. Verify the catalog integration:
```yml
SELECT SYSTEM$VERIFY_CATALOG_INTEGRATION('glue_irc_catalog_int');
```
6. Mount the S3 table as a Snowflake table:
```yml
CREATE OR REPLACE ICEBERG TABLE s3iceberg_customer  
 CATALOG = 'glue_irc_catalog_int'  
 CATALOG_NAMESPACE = 'iceberg_db'  
 CATALOG_TABLE_NAME = 'customer'

 AUTO_REFRESH = TRUE;
```
## **Query the Iceberg table from Snowflake**

To test the configuration, log in to Snowflake as an admin user and run the following sample query:
```yml
SELECT * FROM s3iceberg_customer LIMIT 10;
```
## **Clean up**

To clean up your resources, complete the following steps:

1. Delete the database and table in AWS Glue.  
2. Drop the Iceberg table, catalog integration, and database in Snowflake:
```yml
DROP ICEBERG TABLE iceberg_customer;

DROP CATALOG INTEGRATION glue_irc_catalog_int;
```
Make sure all resources are properly cleaned up to avoid unexpected charges.

## **Conclusion**

In this post, we demonstrated how to establish a secure and efficient connection between your Snowflake environment and SageMaker to query Iceberg tables in Amazon S3. This capability can help your organization maintain a single source of truth while also letting teams use their preferred analytics tools, ultimately breaking down data silos and enhancing collaborative analysis capabilities.

To further explore and implement this solution in your environment, consider the following resources:

* Technical documentation:  
  * Review the [Amazon SageMaker Lakehouse User Guide](https://docs.aws.amazon.com/sagemaker-unified-studio/latest/userguide/lakehouse.html)  
  * Explore [Security in AWS Lake Formation](https://docs.aws.amazon.com/lake-formation/latest/dg/security.html) for best practices to optimize your security controls  
  * Learn more about [Iceberg table format](https://iceberg.apache.org/) and its benefits for data lakes  
  * Refer to [Configuring secure access from Snowflake to Amazon S3](https://docs.snowflake.com/en/user-guide/data-load-s3-config)  
* Related blog posts:  
  * [Build real-time data lakes with Snowflake and Amazon S3 Tables](https://aws.amazon.com/blogs/apn/build-real-time-data-lakes-with-snowflake-and-amazon-s3-tables/)  
  * [Simplify data access for your enterprise using Amazon SageMaker Lakehouse](https://aws.amazon.com/blogs/big-data/simplify-data-access-for-your-enterprise-using-amazon-sagemaker-lakehouse/)

These resources can help you to implement and optimize this integration pattern for your specific use case. As you begin this journey, remember to start small, validate your architecture with test data, and gradually scale your implementation based on your organization’s needs.

# **About the authors**

### 

### 

### 

### 

### Nidhi Gupta
![Nidhi Gupta](/images/3-BlogsTranslated/3.2-Blog2/image2.jpg)

[Nidhi](https://www.linkedin.com/in/nidhi-gupta-5b80874/) is a Senior Partner Solutions Architect at AWS, specializing in data and analytics. She helps customers and partners build and optimize Snowflake workloads on AWS. Nidhi has extensive experience leading production releases and deployments, with focus on Data, AI, ML, generative AI, and Advanced Analytics.

### Andries Engelbrecht
![Andries Engelbrecht](/images/3-BlogsTranslated/3.2-Blog2/image3.jpg)

[Andries](https://www.linkedin.com/in/andries-engelbrecht-427b8b1/)  is a Principal Partner Solutions Engineer at Snowflake working with AWS. He supports product and service integrations, as well the development of joint solutions with AWS. Andries has over 25 years of experience in the field of data and analytics.
