---
title: "Ngày 30 - Database Migration & Best Practices"
weight: 5
chapter: false
pre: "<b> 1.6.5. </b>"
---

**Ngày:** 2025-10-17 (Thứ Sáu)  
**Trạng thái:** "Hoàn thành"  

---

# **Ghi chú Bài học**

## AWS Database Migration Service (DMS)

AWS DMS hỗ trợ di chuyển cơ sở dữ liệu lên AWS nhanh chóng, bảo mật và giảm tối đa downtime.

**Điểm nổi bật:**

- **Homogeneous Migration:** cùng engine (ví dụ Oracle → Oracle).
- **Heterogeneous Migration:** khác engine (Oracle → Aurora).
- **Continuous Replication:** giữ đồng bộ nguồn và đích.
- **Schema Conversion:** dùng AWS Schema Conversion Tool (SCT).

**Kiểu migration:**

- **Full Load:** di chuyển toàn bộ dữ liệu hiện tại một lần.
- **Full Load + CDC:** tải ban đầu và đồng bộ thay đổi liên tục (Change Data Capture).
- **CDC Only:** chỉ replicate phần thay đổi mới.

**Nguồn hỗ trợ:**

- Oracle, SQL Server, MySQL, PostgreSQL, MongoDB, SAP ASE, IBM Db2
- Amazon RDS, Amazon Aurora, Amazon S3

**Đích hỗ trợ:**

- Amazon RDS, Amazon Aurora, Amazon Redshift, Amazon DynamoDB
- Amazon S3, Amazon Elasticsearch, Amazon Kinesis Data Streams

---

## Best Practices cho Database

### Tối ưu hiệu năng

**RDS/Aurora:**

- Chọn đúng loại instance.  
- Bật Enhanced Monitoring.  
- Tối ưu câu truy vấn và index.  
- Dùng Read Replica cho workload đọc nhiều.  
- Bật Performance Insights để phân tích bottleneck.

**Redshift:**

- Chọn distribution key phù hợp.  
- Dùng sort key cho cột hay lọc.  
- Vacuum & analyze định kỳ.  
- Tận dụng nén cột.  
- Cấu hình workload management (WLM).

**ElastiCache:**

- Chọn node type đúng nhu cầu.  
- Dùng cluster mode cho Redis.  
- Cài đặt chính sách loại bỏ (eviction).  
- Theo dõi cache hit rate.  
- Dùng connection pooling.

---

### Bảo mật

- **Mã hóa khi lưu (Encryption at Rest):** bật cho toàn bộ database.  
- **Mã hóa khi truyền:** dùng kết nối SSL/TLS.  
- **Cô lập mạng:** triển khai trong private subnet.  
- **IAM Authentication:** tận dụng cho RDS/Aurora khi có thể.  
- **Secrets Manager:** lưu thông tin đăng nhập an toàn.  
- **Security Group:** giới hạn truy cập tối thiểu.  
- **Audit Logging:** bật CloudWatch Logs và CloudTrail.

---

### High Availability & Disaster Recovery

**RDS/Aurora:**

- Bật Multi-AZ cho môi trường production.  
- Cấu hình backup tự động.  
- Thường xuyên kiểm tra quy trình khôi phục.  
- Sử dụng Aurora Global Database cho DR đa vùng.  
- Tạo read replica ở vùng khác nếu cần.

**Redshift:**

- Bật snapshot tự động.  
- Sao chép snapshot sang vùng khác.  
- Kết hợp Redshift Spectrum với data lake.  
- Thiết lập cơ chế copy snapshot cross-region.

**ElastiCache:**

- Redis: bật Multi-AZ với failover tự động.  
- Kích hoạt backup/restore.  
- Dùng cluster mode để mở rộng.  
- Thêm retry logic ở mức ứng dụng.

---

### Tối ưu chi phí

- **Right-sizing:** chọn instance đúng tải.  
- **Reserved Instances:** cam kết 1–3 năm.  
- **Aurora Serverless:** cho workload biến thiên.  
- **Redshift Serverless:** phù hợp phân tích không liên tục.  
- **Tối ưu lưu trữ:** chọn loại storage thích hợp.  
- **Lifecycle Policy:** lưu trữ lạnh lên S3/Glacier.  
- **Giám sát chi phí:** dùng Cost Explorer & Budgets.

---

# **Khám phá thêm**

## [The Data Warehouse Toolkit](https://www.amazon.com/Data-Warehouse-Toolkit-Definitive-Dimensional/dp/1118530802)

- Tài liệu kinh điển về dimensional modeling và các mẫu thiết kế data warehouse.

---

## Tổng kết Week 6

Tuần này hoàn thành trọn bộ kiến thức AWS Database Services:

✅ Database Fundamentals (RDBMS, NoSQL, OLTP vs OLAP)  
✅ Amazon RDS & Aurora  
✅ Amazon Redshift  
✅ Amazon ElastiCache  
✅ AWS Database Migration Service  

**Labs đã hoàn thành:** 2 labs (RDS & EC2 Integration, Database Migration Service)

---

## Tổng kết 6 tuần đầu (8/9 - 17/10/2025)

**30 ngày làm việc đã hoàn tất:**

### Week 1: Cloud Computing Fundamentals
- AWS basics, hạ tầng, công cụ quản trị, tối ưu chi phí.

### Week 2: AWS Networking Services
- VPC, subnet, security group, load balancing, hybrid connectivity.

### Week 3: AWS Compute Services
- EC2, AMI, storage, auto scaling, pricing models.

### Week 4: AWS Storage Services
- S3, Glacier, Snow Family, Storage Gateway, backup & DR.

### Week 5: AWS Security & Identity
- IAM, Cognito, Organizations, KMS, Security Hub.

### Week 6: AWS Database Services
- RDS, Aurora, Redshift, ElastiCache, DMS.

**Tổng số labs:** 25+ labs.  
**Kế hoạch tiếp theo:** Bắt đầu Week 7 từ ngày 20/10/2025 (Thứ Hai).
