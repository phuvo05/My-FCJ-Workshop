---
title: "Day 45 - Transformer Decoder & GPT2 Implementation"
weight: 5
chapter: false
pre: "<b> 1.9.5. </b>"
---

**Date:** 2025-11-07 (Friday)  
**Status:** "Done"  

---

# **Building a Transformer Decoder: GPT2 Architecture**

Now let's see how all these pieces come together in actual code!

---

# **Transformer Decoder Structure (GPT2-style)**

```
Input: Tokenized sentence [1, 2, 3, 4, 5]
  ↓
Embedding Layer: Convert tokens to vectors
  ↓
Add Positional Encoding: Add position info
  ↓
┌──────────────────────────────────┐
│  Decoder Block (N times)         │
│  ├─ Masked Self-Attention        │
│  ├─ Residual + LayerNorm         │
│  ├─ Feed-Forward                 │
│  └─ Residual + LayerNorm         │
└──────────────────────────────────┘
  ↓
Linear Layer: Project to vocab size
  ↓
Softmax: Convert to probabilities
  ↓
Output: Probabilities for next word
```

---

# **PyTorch Implementation**

### Step 1: Word Embedding + Positional Encoding

```python
import torch
import torch.nn as nn

class TransformerDecoder(nn.Module):
    def __init__(self, vocab_size=10000, d_model=512, num_layers=6, 
                 num_heads=8, d_ff=2048, max_seq_len=1024, dropout=0.1):
        super().__init__()
        
        # 1. Embedding layer
        self.embedding = nn.Embedding(vocab_size, d_model)
        
        # 2. Positional encoding (learned)
        self.positional_encoding = nn.Embedding(max_seq_len, d_model)
        
        # 3. Decoder blocks (repeat N times)
        self.decoder_layers = nn.ModuleList([
            DecoderBlock(d_model, num_heads, d_ff, dropout)
            for _ in range(num_layers)
        ])
        
        # 4. Output layer
        self.final_layer = nn.Linear(d_model, vocab_size)
        self.softmax = nn.Softmax(dim=-1)
        
        self.d_model = d_model
        
    def forward(self, input_ids, mask=None):
        # input_ids shape: [batch_size, seq_length]
        batch_size, seq_len = input_ids.shape
        
        # 1. Embed tokens
        x = self.embedding(input_ids)  # [batch, seq_len, d_model]
        
        # 2. Add positional encoding
        positions = torch.arange(seq_len, device=input_ids.device).unsqueeze(0)
        pos_encoding = self.positional_encoding(positions)
        x = x + pos_encoding  # [batch, seq_len, d_model]
        
        # 3. Pass through decoder layers
        for decoder_layer in self.decoder_layers:
            x = decoder_layer(x, mask)
        
        # 4. Project to vocab
        logits = self.final_layer(x)  # [batch, seq_len, vocab_size]
        
        return logits
```

### Step 2: Decoder Block

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

### Step 3: Multi-Head Attention

```python
class MultiHeadAttention(nn.Module):
    def __init__(self, d_model, num_heads, dropout):
        super().__init__()
        assert d_model % num_heads == 0
        
        self.num_heads = num_heads
        self.d_k = d_model // num_heads
        
        # Linear projections for Q, K, V
        self.W_q = nn.Linear(d_model, d_model)
        self.W_k = nn.Linear(d_model, d_model)
        self.W_v = nn.Linear(d_model, d_model)
        
        # Output projection
        self.W_o = nn.Linear(d_model, d_model)
        
        self.dropout = nn.Dropout(dropout)
        
    def forward(self, Q, K, V, mask=None):
        batch_size = Q.shape[0]
        
        # 1. Linear projections and split into multiple heads
        Q = self.W_q(Q)  # [batch, seq_len, d_model]
        K = self.W_k(K)
        V = self.W_v(V)
        
        # Reshape for multi-head: [batch, seq_len, num_heads, d_k]
        Q = Q.view(batch_size, -1, self.num_heads, self.d_k).transpose(1, 2)
        K = K.view(batch_size, -1, self.num_heads, self.d_k).transpose(1, 2)
        V = V.view(batch_size, -1, self.num_heads, self.d_k).transpose(1, 2)
        # Now: [batch, num_heads, seq_len, d_k]
        
        # 2. Scaled dot-product attention
        scores = torch.matmul(Q, K.transpose(-2, -1)) / math.sqrt(self.d_k)
        # [batch, num_heads, seq_len, seq_len]
        
        # 3. Apply mask (for causal masking in decoder)
        if mask is not None:
            scores = scores.masked_fill(mask == 0, -1e9)
        
        # 4. Softmax
        attention_weights = torch.softmax(scores, dim=-1)
        attention_weights = self.dropout(attention_weights)
        
        # 5. Multiply by value
        context = torch.matmul(attention_weights, V)
        # [batch, num_heads, seq_len, d_k]
        
        # 6. Concatenate heads
        context = context.transpose(1, 2).contiguous()
        context = context.view(batch_size, -1, self.d_model)
        
        # 7. Final linear projection
        output = self.W_o(context)
        
        return output
```

### Step 4: Feed-Forward Network

```python
class FeedForward(nn.Module):
    def __init__(self, d_model, d_ff, dropout):
        super().__init__()
        self.linear1 = nn.Linear(d_model, d_ff)  # 512 → 2048
        self.linear2 = nn.Linear(d_ff, d_model)  # 2048 → 512
        self.relu = nn.ReLU()
        self.dropout = nn.Dropout(dropout)
        
    def forward(self, x):
        x = self.linear1(x)      # Expand
        x = self.relu(x)         # Non-linearity
        x = self.dropout(x)      # Regularization
        x = self.linear2(x)      # Compress
        return x
```

### Step 5: Causal Mask (for preventing future attendance)

```python
def create_causal_mask(seq_len, device):
    """
    Creates a mask that prevents attention to future positions.
    
    Output:
    [1, 0, 0, 0]
    [1, 1, 0, 0]
    [1, 1, 1, 0]
    [1, 1, 1, 1]
    
    Position i can only attend to positions 0...i
    """
    mask = torch.tril(torch.ones(seq_len, seq_len, device=device))
    return mask.unsqueeze(0).unsqueeze(0)  # [1, 1, seq_len, seq_len]

# Usage:
mask = create_causal_mask(seq_len=10, device='cuda')
```

---

# **Training Loop**

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
            
            # Calculate loss
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

# **Inference (Text Generation)**

```python
def generate_text(model, start_token, max_length=50, device='cuda'):
    """
    Generate text autoregressively using the trained transformer.
    """
    model.eval()
    generated = [start_token]
    
    with torch.no_grad():
        for _ in range(max_length):
            # Prepare input
            input_ids = torch.tensor(generated, device=device).unsqueeze(0)
            
            # Forward pass
            logits = model(input_ids)
            
            # Get logits for last position
            last_logits = logits[0, -1, :]  # [vocab_size]
            
            # Sample or greedy
            next_token = torch.argmax(last_logits).item()  # Greedy
            # Or: next_token = torch.multinomial(softmax(last_logits), 1).item()  # Sample
            
            generated.append(next_token)
            
            if next_token == end_token:
                break
    
    return generated
```

---

# **Complete Working Example**

```python
# Initialize model
model = TransformerDecoder(
    vocab_size=10000,
    d_model=512,
    num_layers=6,
    num_heads=8,
    d_ff=2048,
    max_seq_len=1024,
    dropout=0.1
).to('cuda')

# Create dummy data
batch_size, seq_len = 32, 128
input_ids = torch.randint(0, 10000, (batch_size, seq_len)).to('cuda')

# Forward pass
output = model(input_ids)
print(f"Output shape: {output.shape}")  # [32, 128, 10000]

# Create causal mask
mask = create_causal_mask(seq_len, 'cuda')

# Forward with mask
output_masked = model(input_ids, mask)
print(f"Masked output shape: {output_masked.shape}")

# Generate text
generated = generate_text(model, start_token=101, max_length=20)
print(f"Generated sequence: {generated}")
```

---

# **Key Components Summary**

| Component | Purpose | Size |
|-----------|---------|------|
| **Embedding** | Token → Vector | vocab_size → d_model |
| **Positional Encoding** | Add position info | d_model |
| **Multi-Head Attention** | Learn relationships | d_model → d_model |
| **Feed-Forward** | Non-linear transform | d_model → d_ff → d_model |
| **LayerNorm** | Stabilize training | per-element |
| **Output Layer** | Project to vocab | d_model → vocab_size |

---

# **Why This Architecture Works**

✅ **Parallel Processing:** All positions processed together (fast!)
✅ **Long-range Dependencies:** Direct attention to any position (no vanishing gradients!)
✅ **Interpretable:** Can visualize attention patterns
✅ **Scalable:** Can grow to billions of parameters

---

# **GPT2 Variants**

- **GPT-2 Small:** 117M parameters
- **GPT-2 Medium:** 345M parameters
- **GPT-2 Large:** 762M parameters
- **GPT-2 XL:** 1.5B parameters

All use the same decoder architecture, just scaled up!

---

# **Next Steps**

1. **Pre-training:** Train on large text corpus (Wikipedia, Books, etc.)
2. **Fine-tuning:** Adapt to specific tasks (translation, classification, etc.)
3. **Evaluation:** Measure quality (perplexity, BLEU, human evaluation)
4. **Deployment:** Use for real-world applications

---

# **Week 9 Summary**

- Lý do transformer thay thế RNN: xử lý song song, giải quyết bottleneck và gradient.  
- Kiến trúc tổng thể encoder–decoder và các biến thể.  
- Cơ chế scaled dot-product attention và các loại attention (self, masked, encoder–decoder).  
- Triển khai chi tiết các khối decoder và tính toán xác suất đầu ra.  
- Nền tảng cho các mô hình hiện đại như BERT, GPT, T5.
