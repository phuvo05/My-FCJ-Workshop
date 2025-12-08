---
title: "Ngày 45 - Decoder Transformer & Triển Khai GPT2"
weight: 5
chapter: false
pre: "<b> 1.9.5. </b>"
---

**Ngày:** 2025-11-07 (Thứ Sáu)  
**Trạng Thái:** "Hoàn Thành"  

---

# **Xây Dựng Decoder Transformer: Kiến Trúc GPT2**

Bây giờ hãy xem cách tất cả những phần này kết hợp lại trong mã thực tế!

---

# **Cấu Trúc Transformer Decoder (kiểu GPT2)**

```
Đầu Vào: Câu được tokenize [1, 2, 3, 4, 5]
  ↓
Lớp Embedding: Chuyển đổi tokens thành vectors
  ↓
Thêm Positional Encoding: Thêm thông tin vị trí
  ↓
┌──────────────────────────────────┐
│  Decoder Block (N lần)           │
│  ├─ Masked Self-Attention        │
│  ├─ Residual + LayerNorm         │
│  ├─ Feed-Forward                 │
│  └─ Residual + LayerNorm         │
└──────────────────────────────────┘
  ↓
Lớp Linear: Chiếu tới kích thước vocab
  ↓
Softmax: Chuyển đổi thành xác suất
  ↓
Đầu Ra: Xác suất cho từ tiếp theo
```

---

# **Triển Khai PyTorch**

### Bước 1: Word Embedding + Positional Encoding

```python
import torch
import torch.nn as nn

class TransformerDecoder(nn.Module):
    def __init__(self, vocab_size=10000, d_model=512, num_layers=6, 
                 num_heads=8, d_ff=2048, max_seq_len=1024, dropout=0.1):
        super().__init__()
        
        # 1. Lớp embedding
        self.embedding = nn.Embedding(vocab_size, d_model)
        
        # 2. Positional encoding (được học)
        self.positional_encoding = nn.Embedding(max_seq_len, d_model)
        
        # 3. Các decoder blocks (lặp N lần)
        self.decoder_layers = nn.ModuleList([
            DecoderBlock(d_model, num_heads, d_ff, dropout)
            for _ in range(num_layers)
        ])
        
        # 4. Lớp đầu ra
        self.final_layer = nn.Linear(d_model, vocab_size)
        self.softmax = nn.Softmax(dim=-1)
        
        self.d_model = d_model
        
    def forward(self, input_ids, mask=None):
        # input_ids shape: [batch_size, seq_length]
        batch_size, seq_len = input_ids.shape
        
        # 1. Nhúng các tokens
        x = self.embedding(input_ids)  # [batch, seq_len, d_model]
        
        # 2. Thêm positional encoding
        positions = torch.arange(seq_len, device=input_ids.device).unsqueeze(0)
        pos_encoding = self.positional_encoding(positions)
        x = x + pos_encoding  # [batch, seq_len, d_model]
        
        # 3. Truyền qua các lớp decoder
        for decoder_layer in self.decoder_layers:
            x = decoder_layer(x, mask)
        
        # 4. Chiếu tới vocab
        logits = self.final_layer(x)  # [batch, seq_len, vocab_size]
        
        return logits
```

### Bước 2: Decoder Block

```python
class DecoderBlock(nn.Module):
    def __init__(self, d_model, num_heads, d_ff, dropout):
        super().__init__()
        
        # 1. Masked multi-head attention
        self.self_attention = MultiHeadAttention(d_model, num_heads, dropout)
        self.norm1 = nn.LayerNorm(d_model)
        
        # 2. Feed-forward network
        self.feed_forward = FeedForward(d_model, d_ff, dropout)
        self.norm2 = nn.LayerNorm(d_model)
        
        self.dropout = nn.Dropout(dropout)
        
    def forward(self, x, mask=None):
        # x shape: [batch, seq_len, d_model]
        
        # Masked Self-Attention + Residual + Norm
        attn_output = self.self_attention(x, x, x, mask)  # Q=K=V
        x = x + self.dropout(attn_output)
        x = self.norm1(x)
        
        # Feed-Forward + Residual + Norm
        ff_output = self.feed_forward(x)
        x = x + self.dropout(ff_output)
        x = self.norm2(x)
        
        return x
```

### Bước 3: Multi-Head Attention

```python
class MultiHeadAttention(nn.Module):
    def __init__(self, d_model, num_heads, dropout):
        super().__init__()
        assert d_model % num_heads == 0
        
        self.num_heads = num_heads
        self.d_k = d_model // num_heads
        
        # Các phép chiếu tuyến tính cho Q, K, V
        self.W_q = nn.Linear(d_model, d_model)
        self.W_k = nn.Linear(d_model, d_model)
        self.W_v = nn.Linear(d_model, d_model)
        
        # Phép chiếu đầu ra
        self.W_o = nn.Linear(d_model, d_model)
        
        self.dropout = nn.Dropout(dropout)
        
    def forward(self, Q, K, V, mask=None):
        batch_size = Q.shape[0]
        
        # 1. Các phép chiếu tuyến tính và chia thành nhiều đầu
        Q = self.W_q(Q)  # [batch, seq_len, d_model]
        K = self.W_k(K)
        V = self.W_v(V)
        
        # Reshape cho multi-head: [batch, seq_len, num_heads, d_k]
        Q = Q.view(batch_size, -1, self.num_heads, self.d_k).transpose(1, 2)
        K = K.view(batch_size, -1, self.num_heads, self.d_k).transpose(1, 2)
        V = V.view(batch_size, -1, self.num_heads, self.d_k).transpose(1, 2)
        # Bây giờ: [batch, num_heads, seq_len, d_k]
        
        # 2. Scaled dot-product attention
        scores = torch.matmul(Q, K.transpose(-2, -1)) / math.sqrt(self.d_k)
        # [batch, num_heads, seq_len, seq_len]
        
        # 3. Áp dụng mask (cho causal masking trong decoder)
        if mask is not None:
            scores = scores.masked_fill(mask == 0, -1e9)
        
        # 4. Softmax
        attention_weights = torch.softmax(scores, dim=-1)
        attention_weights = self.dropout(attention_weights)
        
        # 5. Nhân với value
        context = torch.matmul(attention_weights, V)
        # [batch, num_heads, seq_len, d_k]
        
        # 6. Ghép các đầu
        context = context.transpose(1, 2).contiguous()
        context = context.view(batch_size, -1, self.d_model)
        
        # 7. Phép chiếu tuyến tính cuối cùng
        output = self.W_o(context)
        
        return output
```

### Bước 4: Feed-Forward Network

```python
class FeedForward(nn.Module):
    def __init__(self, d_model, d_ff, dropout):
        super().__init__()
        self.linear1 = nn.Linear(d_model, d_ff)  # 512 → 2048
        self.linear2 = nn.Linear(d_ff, d_model)  # 2048 → 512
        self.relu = nn.ReLU()
        self.dropout = nn.Dropout(dropout)
        
    def forward(self, x):
        x = self.linear1(x)      # Mở rộng
        x = self.relu(x)         # Non-linearity
        x = self.dropout(x)      # Regularization
        x = self.linear2(x)      # Nén
        return x
```

### Bước 5: Causal Mask (để ngăn chặn attend vào tương lai)

```python
def create_causal_mask(seq_len, device):
    """
    Tạo một mask ngăn chặn attention tới các vị trí tương lai.
    
    Đầu Ra:
    [1, 0, 0, 0]
    [1, 1, 0, 0]
    [1, 1, 1, 0]
    [1, 1, 1, 1]
    
    Vị trí i chỉ có thể attend tới các vị trí 0...i
    """
    mask = torch.tril(torch.ones(seq_len, seq_len, device=device))
    return mask.unsqueeze(0).unsqueeze(0)  # [1, 1, seq_len, seq_len]

# Sử Dụng:
mask = create_causal_mask(seq_len=10, device='cuda')
```

---

# **Vòng Lặp Huấn Luyện**

```python
def train_transformer(model, train_loader, epochs=10, learning_rate=0.0001):
    optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
    loss_fn = nn.CrossEntropyLoss()
    
    for epoch in range(epochs):
        total_loss = 0
        
        for batch_idx, (input_ids, target_ids) in enumerate(train_loader):
            # Forward pass
            logits = model(input_ids)
            # logits: [batch, seq_len, vocab_size]
            # target_ids: [batch, seq_len]
            
            # Tính toán loss
            loss = loss_fn(
                logits.view(-1, vocab_size),
                target_ids.view(-1)
            )
            
            # Backward pass
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()
            
            total_loss += loss.item()
        
        print(f"Epoch {epoch+1}, Loss: {total_loss/len(train_loader):.4f}")
```

---

# **Suy Luận (Tạo Văn Bản)**

```python
def generate_text(model, start_token, max_length=50, device='cuda'):
    """
    Tạo văn bản tự động sử dụng transformer được huấn luyện.
    """
    model.eval()
    generated = [start_token]
    
    with torch.no_grad():
        for _ in range(max_length):
            # Chuẩn bị đầu vào
            input_ids = torch.tensor(generated, device=device).unsqueeze(0)
            
            # Forward pass
            logits = model(input_ids)
            
            # Lấy logits cho vị trí cuối cùng
            last_logits = logits[0, -1, :]  # [vocab_size]
            
            # Lấy mẫu hoặc tham lam
            next_token = torch.argmax(last_logits).item()  # Tham lam
            # Hoặc: next_token = torch.multinomial(softmax(last_logits), 1).item()  # Lấy mẫu
            
            generated.append(next_token)
            
            if next_token == end_token:
                break
    
    return generated
```

---

# **Ví Dụ Hoàn Chỉnh Hoạt Động**

```python
# Khởi tạo mô hình
model = TransformerDecoder(
    vocab_size=10000,
    d_model=512,
    num_layers=6,
    num_heads=8,
    d_ff=2048,
    max_seq_len=1024,
    dropout=0.1
).to('cuda')

# Tạo dữ liệu giả
batch_size, seq_len = 32, 128
input_ids = torch.randint(0, 10000, (batch_size, seq_len)).to('cuda')

# Forward pass
output = model(input_ids)
print(f"Output shape: {output.shape}")  # [32, 128, 10000]

# Tạo causal mask
mask = create_causal_mask(seq_len, 'cuda')

# Forward với mask
output_masked = model(input_ids, mask)
print(f"Masked output shape: {output_masked.shape}")

# Tạo văn bản
generated = generate_text(model, start_token=101, max_length=20)
print(f"Generated sequence: {generated}")
```

---

# **Tóm Tắt Các Thành Phần Chính**

| Thành Phần | Mục Đích | Kích Thước |
|-----------|---------|-----------|
| **Embedding** | Token → Vector | vocab_size → d_model |
| **Positional Encoding** | Thêm thông tin vị trí | d_model |
| **Multi-Head Attention** | Học mối quan hệ | d_model → d_model |
| **Feed-Forward** | Phép biến đổi phi tuyến | d_model → d_ff → d_model |
| **LayerNorm** | Ổn định huấn luyện | per-element |
| **Output Layer** | Chiếu tới vocab | d_model → vocab_size |

---

# **Tại Sao Kiến Trúc Này Hoạt Động**

✅ **Xử Lý Song Song:** Tất cả các vị trí được xử lý cùng nhau (nhanh!)
✅ **Phụ Thuộc Dài Hạn:** Attention trực tiếp tới bất kỳ vị trí nào (không có vanishing gradients!)
✅ **Có Thể Diễn Giải:** Có thể hình dung các mô hình attention
✅ **Có Thể Mở Rộng:** Có thể lớn lên tới hàng tỷ tham số

---

# **Các Biến Thể GPT2**

- **GPT-2 Small:** 117M tham số
- **GPT-2 Medium:** 345M tham số
- **GPT-2 Large:** 762M tham số
- **GPT-2 XL:** 1.5B tham số

Tất cả sử dụng kiến trúc decoder giống nhau, chỉ được mở rộng!

---

# **Bước Tiếp Theo**

1. **Huấn Luyện Trước:** Huấn luyện trên kho ngữ liệu văn bản lớn (Wikipedia, Sách, v.v.)
2. **Tinh Chỉnh:** Điều chỉnh cho các tác vụ cụ thể (dịch, phân loại, v.v.)
3. **Đánh Giá:** Đo chất lượng (perplexity, BLEU, đánh giá của con người)
4. **Triển Khai:** Sử dụng cho các ứng dụng thực tế

---

# **Tóm Tắt Tuần 9**

Chúng ta đã bao quát:
- ✅ Tại sao transformers thay thế RNNs
- ✅ Kiến trúc transformer hoàn chỉnh
- ✅ Cơ chế scaled dot-product attention
- ✅ Self, masked, và encoder-decoder attention
- ✅ Chi tiết triển khai và code

**Đây là nền tảng của NLP hiện đại!** Tất cả các mô hình tiên tiến (BERT, GPT, T5, Claude, ChatGPT) đều dựa trên kiến trúc transformer.
