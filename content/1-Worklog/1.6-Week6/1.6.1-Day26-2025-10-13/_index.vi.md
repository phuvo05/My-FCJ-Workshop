---
title: "Ngày 26 - Kiến thức Cơ bản về Cơ sở dữ liệu"
weight: 1
chapter: false
pre: "<b> 1.6.1. </b>"
---

**Ngày:** 2025-10-13 (Thứ Hai)  
**Trạng thái:** "Hoàn thành"  

---

# **Ghi chú Bài học**

## Ôn tập khái niệm cơ sở dữ liệu

- Một **cơ sở dữ liệu** là tập hợp dữ liệu có tổ chức (hoặc bán cấu trúc) được lưu trên thiết bị lưu trữ, cho phép nhiều người dùng/chương trình truy cập đồng thời cho các mục đích khác nhau.

### Phiên làm việc (Session)

- **Phiên** bắt đầu khi client kết nối tới DBMS và kết thúc khi đóng kết nối.

### Khóa chính (Primary Key)

- **Primary key** dùng để định danh duy nhất từng dòng trong bảng quan hệ.

### Khóa ngoại (Foreign Key)

- **Foreign key** ở một bảng sẽ trỏ đến **primary key** của bảng khác để tạo quan hệ dữ liệu.

![image](/images/1-Worklog/Week6/image.png)

### Chỉ mục (Index)

- **Index** giúp truy vấn nhanh hơn nhưng phải trả giá bằng ghi chép bổ sung và dung lượng lưu trữ để duy trì cấu trúc chỉ mục.
- Nhờ index, hệ quản trị có thể tìm bản ghi mà không phải quét toàn bộ bảng; có thể định nghĩa trên một hoặc nhiều cột.

![image](/images/1-Worklog/Week6/image%201.png)

**Các loại chỉ mục phổ biến:**

- **B-Tree:** Cây cân bằng dùng cho hầu hết tình huống.
- **Hash:** Truy vấn theo giá trị chính xác cực nhanh.
- **Bitmap:** Hợp lý với cột có số lượng giá trị ít.
- **Full-Text:** Tối ưu cho tìm kiếm văn bản.

---

### Phân vùng (Partitioning)

- **Partitioning** chia một bảng lớn thành nhiều phần nhỏ độc lập (partition) và có thể đặt trên nhiều thiết bị lưu trữ khác nhau.
- Lợi ích: tăng tốc truy vấn, dễ bảo trì và mở rộng.
- Các kiểu thông dụng:
  - **Range** (ví dụ theo ngày/tháng)
  - **List**
  - **Hash**
  - **Composite** (kết hợp nhiều tiêu chí)

**Ví dụ partition theo range:**

```sql
-- Partition theo năm
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    amount DECIMAL
) PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026)
);
```

---

### Execution Plan / Query Plan

- **Query plan** mô tả cách DBMS thực thi câu lệnh SQL (đường truy cập, kiểu join, sort...).
- Có hai dạng:
  - **Estimated plan:** ước lượng trước khi chạy.
  - **Actual plan:** sinh ra sau khi thực thi.
- Thành phần chính: table scan, index seek/scan, nested loop, hash/merge join, sort, aggregate, filter.

![image](/images/1-Worklog/Week6/image%202.png)

---

### Database Logs

- **Database log** ghi lại mọi thay đổi (INSERT/UPDATE/DELETE) và thao tác hệ thống.
- Thông dụng: log giao dịch, redo, undo, binary log...
- Công dụng: khôi phục dữ liệu, đảm bảo toàn vẹn (ACID), hỗ trợ replicate, phân tích hiệu năng.

---

### Bộ đệm (Buffer)

- **Buffer pool** lưu các trang dữ liệu được đọc từ đĩa nhằm giảm I/O.
- Chiến lược quản lý:
  - Thu hồi trang: LRU, FIFO, Clock...
  - Chính sách ghi: ghi ngay hay trì hoãn.
  - **Prefetching** để sưởi ấm bộ đệm trước.

![image](/images/1-Worklog/Week6/image%203.png)

---

# **Labs thực hành**

## Lab 05 – Amazon RDS & EC2 Integration (Phần 1)

1. Tạo VPC → *05-2.1*  
2. Tạo Security Group cho EC2 → *05-2.2*  
3. Tạo Security Group cho RDS → *05-2.3*  
4. Tạo DB Subnet Group → *05-2.4*
