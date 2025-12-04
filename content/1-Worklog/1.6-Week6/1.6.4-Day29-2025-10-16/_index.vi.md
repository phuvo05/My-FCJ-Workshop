---
title: "Ngày 29 - Amazon ElastiCache"
weight: 4
chapter: false
pre: "<b> 1.6.4. </b>"
---

**Ngày:** 2025-10-16 (Thứ Năm)  
**Trạng thái:** "Hoàn thành"  

---

# **Ghi chú Bài học**

## Amazon ElastiCache

Dịch vụ cache in-memory managed cho **Redis** và **Memcached** giúp giảm độ trễ và giảm tải database.

- Độ trễ micro giây, Multi-AZ với failover, scale đơn giản, tích hợp mã hóa/xác thực, vận hành tự động.
- **Redis:** hỗ trợ cấu trúc dữ liệu phong phú, backup, replication, cluster mode.
- **Memcached:** cache key-value đơn giản, mở rộng ngang với auto-discovery.

Use case điển hình: tăng tốc web/mobile, cache truy vấn DB, session store, leaderboard, pub/sub, queue.

**ElastiCache for Redis – điểm nổi bật:**

- **Cấu trúc dữ liệu:** strings, lists, sets, sorted sets, hashes, bitmap, hyperloglog.
- **Persistence:** snapshot và AOF.
- **Replication:** mô hình primary-replica tự failover.
- **Cluster Mode:** phân mảnh dữ liệu trên nhiều shard.
- **Pub/Sub:** nhắn tin thời gian thực.
- **Lua Scripting:** chạy logic phía server.
- **Geospatial:** truy vấn tọa độ.

**ElastiCache for Memcached – điểm nổi bật:**

- **Multi-threaded:** tận dụng đa lõi.
- **Auto Discovery:** client tự nhận node mới.
- **Horizontal Scaling:** thêm/bớt node dễ dàng.
- **Đơn giản:** không persistence, cấu hình nhẹ.

**So sánh Redis vs Memcached:**

| Tiêu chí | Redis | Memcached |
|---------|-------|-----------|
| Cấu trúc dữ liệu | Phong phú | Đơn giản (key-value) |
| Persistence | Có | Không |
| Replication | Có | Không |
| Multi-AZ | Có | Không |
| Backup/Restore | Có | Không |
| Pub/Sub | Có | Không |
| Đa luồng | Không | Có |

---

## Chiến lược Caching

### Cache-Aside (Lazy Loading)

- Ứng dụng kiểm tra cache trước, nếu miss thì đọc DB và ghi lại vào cache.
- **Ưu:** chỉ cache dữ liệu thực sự cần.
- **Nhược:** cache miss gây trễ, dữ liệu có thể cũ.

### Write-Through

- Ghi đồng thời vào cache và database.
- **Ưu:** dữ liệu đọc luôn tươi.
- **Nhược:** ghi chậm hơn, có thể lưu trữ dữ liệu ít dùng.

### Write-Behind (Write-Back)

- Ghi vào cache tức thì, đồng bộ xuống DB bất đồng bộ.
- **Ưu:** ghi rất nhanh, giảm tải DB.
- **Nhược:** rủi ro mất dữ liệu nếu cache lỗi, phức tạp hơn.

---

## Tình huống sử dụng

**Session Store:**

```python
# Lưu session user vào Redis
redis.setex(f"session:{user_id}", 3600, session_data)

# Lấy session
session = redis.get(f"session:{user_id}")
```

**Leaderboard:**

```python
# Ghi điểm vào sorted set
redis.zadd("leaderboard", {user_id: score})

# Lấy top 10
top_10 = redis.zrevrange("leaderboard", 0, 9, withscores=True)
```

**Rate Limiting:**

```python
# Đếm số lần gọi trong 60 giây
pipe = redis.pipeline()
pipe.incr(f"rate:{user_id}")
pipe.expire(f"rate:{user_id}", 60)
count = pipe.execute()[0]

if count > 100:
    raise RateLimitExceeded()
```

---

# **Labs thực hành**

## Lab 43 – AWS Database Migration Service (DMS) (Phần 3)

12. Kiểm tra dữ liệu trên S3 → *43-12*  
13. Tạo migration serverless → *43-13*  
14. Tạo thông báo sự kiện → *43-14*  
15. Theo dõi log → *43-15*  
16. Xử lý sự cố: Memory Pressure → *43-16*  
17. Xử lý sự cố: Table Error → *43-17*
