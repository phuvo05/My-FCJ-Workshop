---
title: "Các bài blogs đã dịch"
weight: 3
chapter: false
pre: " <b> 3. </b> "
---

###  [Blog 1 - Migrating from AWS CodeDeploy to Amazon ECS for blue/green deployments](3.1-Blog1/)
Blog này giới thiệu cách di chuyển từ **AWS CodeDeploy** sang phương pháp triển khai **blue/green** của **Amazon ECS**. Nội dung giải thích rằng ECS hiện đã hỗ trợ triển khai blue/green một cách nguyên bản, giúp loại bỏ sự cần thiết của CodeDeploy. Các ưu điểm chính bao gồm hỗ trợ cho **ECS ServiceConnect**, **dịch vụ không định danh (headless services)**, **ổ đĩa Amazon EBS**, và **nhiều nhóm mục tiêu (multiple target groups)**.

Bài viết cũng trình bày chi tiết về sự khác biệt giữa **API**, **CLI**, và **giao diện console**, cách ánh xạ các **hook vòng đời (lifecycle hook)**, và các biến thể trong luồng triển khai.

---

### Ba Phương Án Di Chuyển 📝

Dưới đây là ba phương án di chuyển được đề xuất:

1.  **Cập nhật tại chỗ (In-place update)**
    * *Mô tả:* Đơn giản nhất, không có thời gian chết (downtime).
2.  **Dịch vụ mới sử dụng bộ cân bằng tải hiện có (New service using existing load balancer)**
    * *Mô tả:* An toàn hơn, gián đoạn tối thiểu.
3.  **Dịch vụ mới với bộ cân bằng tải mới (New service with new load balancer)**
    * *Mô tả:* Hoàn toàn không có thời gian chết, nhưng chi phí cao hơn.
###  [Blog 2 - Break down data silos and seamlessly query Iceberg tables in Amazon SageMaker from Snowflake](3.2-Blog2/)
Blog này hướng dẫn cách **truy vấn trực tiếp các bảng Apache Iceberg** trong lakehouse của Amazon SageMaker **từ Snowflake**, giúp bạn phân tích dữ liệu hợp nhất mà không cần sao chép hay thực hiện quy trình ETL (Extract, Transform, Load).

---

### Cách Hoạt Động & Bảo Mật 🔐

Sử dụng **AWS Glue Data Catalog**, **Lake Formation**, và **điểm cuối REST của Glue Iceberg**, người dùng Snowflake có thể truy vấn an toàn dữ liệu được lưu trữ trong **Amazon S3**.



Cơ chế tích hợp này đảm bảo truy cập an toàn thông qua việc **cấp phát thông tin xác thực qua Lake Formation** và **xác thực SigV4**.

---

### Lợi Ích & Các Bước Thực Hiện 

Giải pháp này cho phép phân tích liền mạch giữa các nền tảng, giúp cải thiện **khả năng truy cập dữ liệu**, **tính nhất quán**, và **hiệu quả về chi phí**.

Bài hướng dẫn cũng vạch ra các **điều kiện tiên quyết**, cách **thiết lập IAM và Lake Formation**, cùng các bước **tích hợp catalog trong Snowflake**. Mục tiêu cuối cùng là giúp các tổ chức **phá vỡ các rào cản dữ liệu (data silos)** và tăng cường khả năng ra quyết định trong toàn bộ hệ sinh thái dữ liệu của mình.
###  [Blog 3 - Navigating Amazon GuardDuty protection plans and Extended Threat Detection](3.3-Blog3/)
Blog này giới thiệu về **Amazon GuardDuty**, dịch vụ giám sát bảo mật của AWS nay đã được nâng cấp với một bộ **Gói Bảo Vệ (Protection Plans)** và tính năng **Phát Hiện Mối Đe Dọa Mở Rộng (Extended Threat Detection - ETD)**.

---

### Các Gói Bảo Vệ Chuyên Sâu 🛡️

Các gói bảo vệ mở rộng phạm vi giám sát đến các dịch vụ cụ thể—bao gồm **S3, EKS, EC2, ECS, Lambda, RDS**, và nhiều dịch vụ khác—nhằm phát hiện các mối đe dọa như **phần mềm độc hại (malware)**, **leo thang đặc quyền**, và **trích xuất dữ liệu trái phép**.



GuardDuty cũng đưa ra đề xuất kết hợp các gói bảo vệ phù hợp nhất tùy theo loại workload (EC2, container, serverless, cơ sở dữ liệu, hoặc môi trường có quy định nghiêm ngặt).

---

### Phát Hiện Mối Đe Dọa Mở Rộng (ETD) 🧠

Tính năng **ETD** tận dụng **AI/ML** để tương quan các sự kiện trên nhiều dịch vụ, từ đó xác định các cuộc tấn công đa giai đoạn với độ tin cậy cao và ánh xạ chúng tới các chiến thuật của **MITRE ATT&CK**.

---

### Lợi Ích Chính ✅

Sự kết hợp của các tính năng này mang lại khả năng **phát hiện mối đe dọa toàn diện, tự động** và cung cấp **thông tin chi tiết có thể hành động (actionable insights)**, giúp bảo vệ các workload trên AWS với chi phí vận hành tối thiểu.
