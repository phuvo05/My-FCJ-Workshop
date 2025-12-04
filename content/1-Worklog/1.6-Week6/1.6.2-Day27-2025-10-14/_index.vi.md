---
title: "Ngày 27 - Amazon RDS & Aurora"
weight: 2
chapter: false
pre: "<b> 1.6.2. </b>"
---

**Ngày:** 2025-10-14 (Thứ Ba)  
**Trạng thái:** "Hoàn thành"  

---

# **Ghi chú Bài học**

## RDBMS vs NoSQL

### RDBMS

- **RDBMS** lưu dữ liệu trong các bảng có quan hệ (hàng/cột), đảm bảo ràng buộc toàn vẹn, dùng SQL và cung cấp đầy đủ đặc tính ACID.
- Engine phổ biến: Oracle, MySQL, SQL Server, PostgreSQL, IBM Db2.

![image](/images/1-Worklog/Week6/image%204.png)

### Tổng quan NoSQL

- **NoSQL** hướng tới dữ liệu phi cấu trúc/bán cấu trúc, ưu tiên khả năng mở rộng và hiệu năng cao.
- Các loại chính:
  - **Document** (MongoDB, CouchDB)
  - **Key–Value** (Redis, DynamoDB)
  - **Column-Family** (Cassandra, HBase)
  - **Graph** (Neo4j, Amazon Neptune)
- Đặc điểm: schema linh hoạt, mở rộng ngang, xử lý big data tốt, thiết kế theo CAP.

![image](/images/1-Worklog/Week6/image%205.png)

#### So sánh nhanh RDBMS vs NoSQL

![image](/images/1-Worklog/Week6/image%206.png)

### OLTP vs OLAP

- **OLTP:** nhiều giao dịch nhỏ, đồng thời; dữ liệu chuẩn hóa; truy vấn ngắn, phụ thuộc index.
- **OLAP:** phân tích phức tạp trên dữ liệu lịch sử; schema sao/tuyết; đọc nhiều, ghi ít.

![image](/images/1-Worklog/Week6/image%207.png)

---

## Amazon RDS & Aurora

### Amazon Relational Database Service (RDS)

Dịch vụ CSDL quan hệ managed giúp đơn giản hóa triển khai, vá lỗi, backup và HA.

- Engine hỗ trợ: MySQL, PostgreSQL, MariaDB, Oracle, SQL Server, **Amazon Aurora**.
- Tính năng chính: backup/patch tự động, mở rộng dễ dàng, Multi-AZ cho HA, bảo mật với VPC/IAM/SSL.
- Kiểu triển khai:
  - **Single-AZ**
  - **Multi-AZ** (standby đồng bộ ở AZ khác)
  - **Read Replica** để scale đọc

![image](/images/1-Worklog/Week6/image%208.png)
![image](/images/1-Worklog/Week6/image%209.png)

**Tính năng RDS:**

- **Automated Backups:** khôi phục tới từng thời điểm trong 35 ngày.
- **Manual Snapshots:** backup thủ công do người dùng kích hoạt.
- **Multi-AZ:** tự động failover để duy trì HA.
- **Read Replica:** tối đa 15 replica (tùy engine) cho workload đọc.
- **Parameter Groups:** quản lý cấu hình database.
- **Option Groups:** bật tính năng bổ sung (ví dụ Oracle Advanced Security).

---

### Amazon Aurora

Hệ CSDL tương thích MySQL/PostgreSQL được thiết kế lại cho cloud.

![image](/images/1-Worklog/Week6/image%2010.png)

- Điểm nổi bật:
  - Hiệu năng ~5× MySQL / ~3× PostgreSQL (benchmark điển hình).
  - Storage tự động mở rộng tới 128 TB.
  - Sao chép 6 bản trên 3 AZ, tự chữa lành storage.
  - **Aurora Serverless** mở rộng theo nhu cầu.
  - **Global Database** cho độ trễ thấp đa vùng.

![image](/images/1-Worklog/Week6/image%2011.png)
![image](/images/1-Worklog/Week6/image%2012.png)

**Aurora Features:**

- **Aurora Replicas:** tối đa 15 read replica với độ trễ < 10 ms.
- **Aurora Serverless:** tự động scale compute.
- **Aurora Global Database:** replicate xuyên vùng < 1 giây.
- **Aurora Backtrack:** tua ngược DB về thời điểm cụ thể.
- **Aurora Parallel Query:** tăng tốc truy vấn phân tích trên dữ liệu hiện thời.
- **Aurora Machine Learning:** tích hợp ML native.

**Aurora vs RDS:**

| Tính năng | Aurora | RDS |
|-----------|--------|-----|
| Hiệu năng | ~5× MySQL, ~3× PostgreSQL | Chuẩn |
| Lưu trữ | Tự mở rộng tới 128 TB | Tăng thủ công |
| Replica | Tối đa 15 | Tối đa 5 (MySQL) |
| Failover | < 30 giây | 1–2 phút |
| Backtrack | Có | Không |

---

# **Labs thực hành**

## Lab 05 – Amazon RDS & EC2 Integration (Phần 2)

5. Tạo EC2 Instance → *05-3*  
6. Tạo RDS Database Instance → *05-4*  
7. Triển khai ứng dụng → *05-5*  
8. Backup & Restore → *05-6*  
9. Dọn tài nguyên → *05-7*

## Lab 43 – AWS Database Migration Service (DMS) (Phần 1)

1. EC2 Connect RDP Client → *43-01*  
2. EC2 Connect Fleet Manager → *43-02*  
3. Cấu hình nguồn SQL Server → *43-03*  
4. Oracle Connect Source DB → *43-04*  
5. Oracle Config Source DB → *43-05*  
6. Drop Constraint → *43-06*
