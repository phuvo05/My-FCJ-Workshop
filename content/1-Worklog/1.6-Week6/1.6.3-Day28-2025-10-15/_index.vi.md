---
title: "Ngày 28 - Amazon Redshift"
weight: 3
chapter: false
pre: "<b> 1.6.3. </b>"
---

**Ngày:** 2025-10-15 (Thứ Tư)  
**Trạng thái:** "Hoàn thành"  

---

# **Ghi chú Bài học**

## Amazon Redshift

Dịch vụ data warehouse fully-managed tối ưu cho workload phân tích quy mô lớn (OLAP).

- Lưu trữ dạng cột, nén dữ liệu, thực thi song song MPP; mở rộng từ hàng trăm GB tới hàng PB.
- Tích hợp sâu với S3, Kinesis, DynamoDB, các công cụ BI; hỗ trợ nhiều lớp bảo mật.
- **Concurrency Scaling** tự động bổ sung compute khi lưu lượng tăng đột biến.
- Kiến trúc: **cluster** gồm leader node + compute nodes; mỗi compute node chia thành nhiều **slice**.

Tùy chọn triển khai:

- **Redshift Provisioned**
- **Redshift Serverless**
- **Redshift Spectrum** (truy vấn trực tiếp dữ liệu trên S3)

Use case: BI doanh nghiệp, phân tích data lake, dashboard, phân tích xu hướng và dự báo.

![image](/images/1-Worklog/Week6/image%2013.png)
![image](/images/1-Worklog/Week6/image%2014.png)

**Tính năng nổi bật:**

- **Lưu trữ dạng cột:** phù hợp truy vấn phân tích.
- **Massively Parallel Processing:** phân tán truy vấn trên nhiều node.
- **Result Caching:** tăng tốc truy vấn lặp lại.
- **Automatic Compression:** giảm dung lượng lưu trữ.
- **Workload Management (WLM):** ưu tiên truy vấn quan trọng.
- **Concurrency Scaling:** xử lý workload bùng nổ.

**Redshift vs Data Warehouse truyền thống:**

| Tiêu chí | Redshift | DW truyền thống |
|---------|----------|-----------------|
| Thiết lập | Vài phút | Vài tuần/tháng |
| Mở rộng | Elastic | Cố định |
| Chi phí | Pay-as-you-go | Đầu tư lớn ban đầu |
| Vận hành | Managed | Tự quản lý |

**Redshift Spectrum:**

- Truy vấn trực tiếp dữ liệu trên S3 mà không cần load.
- Tách biệt compute và storage.
- Hỗ trợ nhiều định dạng (Parquet, ORC, JSON...).
- Tiết kiệm chi phí cho dữ liệu truy cập không thường xuyên.

---

# **Labs thực hành**

## Lab 43 – AWS Database Migration Service (DMS) (Phần 2)

7. Cấu hình đích MSSQL → Aurora MySQL → *43-07*  
8. Tạo project MSSQL → Aurora MySQL → *43-08*  
9. Convert schema MSSQL → Aurora MySQL → *43-09*  
10. Convert schema Oracle → MySQL (1) → *43-10*  
11. Tạo migration task & endpoints → *43-11*
