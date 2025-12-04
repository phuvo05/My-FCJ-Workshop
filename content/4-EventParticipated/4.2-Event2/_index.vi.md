---
title: "Sự Kiện 2 - AWS GenAI Builder Club"
weight: 2
chapter: false
---

## AWS GenAI Builder Club: Vòng Đời Phát Triển Dựa trên AI - Tái Định Hình Kỹ Thuật Phần Mềm

**Ngày & Giờ:** Thứ Sáu, 3 tháng 10 năm 2025 | 14:00 (2:00 PM)

**Địa Điểm:** AWS Event Hall, L26 Tòa Nhà Bitexco, Thành phố Hồ Chí Minh

**Giảng Viên:** Toàn Huỳnh & Mỹ Nguyễn

**Điều Phối Viên:** Diễm Mỹ, Đại Trương, Định Nguyễn

---

## Tổng Quan Sự Kiện

Buổi gặp mặt AWS GenAI Builder Club này điều tra Vòng Đời Phát Triển Dựa trên AI (AI-DLC), một phương pháp sáng tạo cho kỹ thuật phần mềm tích hợp AI như một cộng tác viên cốt lõi trong suốt hành trình phát triển hoàn chỉnh. Phiên làm việc bao gồm các bản trình diễn tương tác về Amazon Q Developer và Kiro, trình bày các ứng dụng AI thực tế trong phát triển phần mềm đương đại.

---

## Chương Trình

| Giờ           | Phiên                                                                              | Giảng Viên |
| ------------- | ---------------------------------------------------------------------------------- | ---------- |
| 14:00 - 14:15 | Chào Mừng                                                                          | -          |
| 14:15 - 15:30 | Tổng Quan Vòng Đời Phát Triển Dựa trên AI & Bản Trình Diễn Amazon Q Developer | Toàn Huỳnh |
| 15:30 - 15:45 | Giải Lao                                                                           | -          |
| 15:45 - 16:30 | Bản Trình Diễn Kiro                                                                | Mỹ Nguyễn  |

---

## Các Khái Niệm & Bài Học Chính

### 1. Tổng Quan Vòng Đời Phát Triển Dựa trên AI (AI-DLC)

#### Triết Lý Cốt Lõi

Vòng Đời Phát Triển Dựa trên AI biểu thị một sự chuyển đổi căn bản trong phương pháp xây dựng phần mềm. Thay vì coi AI như một tính năng phụ hoặc tiện ích hoàn thành mã cơ bản, AI-DLC định vị AI như một cộng tác viên thông minh trong suốt quy trình phát triển hoàn chỉnh.

**Các Nguyên Tắc Chính:**

- **Bạn Duy Trì Quyền Kiểm Soát** - AI phục vụ như trợ lý của bạn, không phải người giám sát của bạn. Bạn cần giữ quyền ra quyết định về hướng dự án và chi tiết triển khai.

- **AI Là Đối Tác, Không Phải Thay Thế** - AI nên đặt những câu hỏi quan trọng về nhu cầu dự án, kiến trúc và mục tiêu của bạn. Mối quan hệ đối tác nên chảy hai chiều, với bạn định hướng các khuyến nghị của AI.

- **Thiết Kế Trước Khi Xây Dựng** - Luôn phát triển một kế hoạch toàn diện trước khi viết mã. AI có thể hỗ trợ trong việc tạo kế hoạch này, nhưng bạn phải kiểm tra, xác nhận và cải thiện nó.

#### Quy Trình Phát Triển

**Bước 1: Phát Triển Kế Hoạch Dự Án**

- Thiết lập các yêu cầu và ranh giới dự án rõ ràng
- Yêu cầu AI tạo kế hoạch dựa trên các thông số kỹ thuật của bạn
- Đánh giá phê phán kế hoạch và yêu cầu điều chỉnh
- Xác nhận kế hoạch toàn diện và rõ ràng

**Bước 2: Phân Tách Thành User Stories**

- Chuyển đổi kế hoạch thành user stories với tiêu chí chấp nhận rõ ràng
- Chia phạm vi lớn thành các đơn vị nhỏ hơn, có thể xử lý được
- Mỗi đơn vị trở thành một dự án nhỏ có thể giao cho các thành viên nhóm
- Tính toán thời gian cho mỗi đơn vị (trong khi cẩn thận về ước tính quá cao)

**Bước 3: Thiết Lập Ngăn Xếp Công Nghệ**

- Nêu rõ các công nghệ, framework và công cụ sẽ được sử dụng
- Thay vì hướng dẫn AI "đừng triển khai cái này," hãy nói "triển khai theo cách này"
- Hướng dẫn khẳng định tạo ra tỷ lệ thành công cao hơn các hạn chế tiêu cực

**Bước 4: Yêu Cầu & Thiết Kế Toàn Diện**

- Ghi lại yêu cầu với độ chính xác và rõ ràng
- Hợp tác với AI để phát triển các thông số kỹ thuật chi tiết
- Xác định các mô hình dữ liệu, hợp đồng API và kiến trúc hệ thống
- Tạo tài liệu thiết kế trước khi triển khai bắt đầu

**Bước 5: Triển Khai & Xác Nhận**

- Xây dựng các tính năng theo kế hoạch
- Áp dụng phương pháp phát triển mob (nhóm làm việc tập thể trên mã)
- Xác nhận tất cả mã được tạo ra như một nhóm
- Thực hiện đánh giá mã và kiểm tra chất lượng

**Bước 6: Kiểm Thử & Triển Khai**

- Tiến triển qua các môi trường: Development (Dev) → Testing (QA) → User Acceptance Testing (UAT) → Production (Prod)
- Duy trì các cổng chất lượng ở mỗi giai đoạn
- Xác nhận chức năng trước khi phát hành sản xuất

#### Các Yếu Tố Thành Công Quan Trọng

- **Phát Triển Kế Hoạch Trước** - Đừng giả định AI sẽ quản lý mọi thứ. Luôn bắt đầu với một kế hoạch xác định.
- **Xem Xét Liên Tục** - Liên tục xem xét các khuyến nghị và đầu ra của AI. Tỷ lệ lỗi đáng kể là có thể.
- **Bạn Là Người Chỉ Đạo** - Giá trị của bạn nằm ở xác nhận mã và giám sát dự án, không phải viết từng dòng mã.
- **Đặt Câu Hỏi Làm Rõ** - Xác nhận AI nắm bắt ngữ cảnh dự án của bạn bằng cách đặt những câu hỏi quan trọng về yêu cầu, kiến trúc và mục tiêu.
- **Áp Dụng Mẫu Prompt** - Thiết kế các prompt có cấu trúc bao gồm ngữ cảnh người dùng, user stories và các yêu cầu cụ thể để có được phản hồi AI rõ ràng hơn.
- **Lưu Kế Hoạch Thành Tệp** - Yêu cầu AI tạo kế hoạch dưới dạng tệp bạn có thể lưu trữ, xem xét và điều chỉnh. Điều này tạo ra một tài liệu sống cho việc tham khảo trong tương lai.
- **Lịch Sự Với AI** - Duy trì giao tiếp tôn trọng với các công cụ AI. Mối quan hệ tích cực có thể có lợi cho các tương tác trong tương lai (và đó chỉ đơn giản là thực hành tốt!).

---

### 2. Bản Trình Diễn Amazon Q Developer

#### Amazon Q Developer Là Gì?

Amazon Q Developer là một trợ lý được hỗ trợ bởi AI cách mạng hóa vòng đời phát triển phần mềm (SDLC) thông qua các khả năng tự chủ trên nhiều nền tảng:

- **AWS Console** - Hỗ trợ cấu hình hạ tầng và dịch vụ
- **IDE (Integrated Development Environment)** - Cung cấp các khuyến nghị tạo mã và tối ưu hóa
- **CLI (Command Line Interface)** - Hỗ trợ tạo lệnh và tự động hóa
- **Các Nền Tảng DevSecOps** - Tích hợp các thực hành bảo mật vào quy trình phát triển

#### Các Khả Năng Chính

**Tạo Mã & Chất Lượng**

- Đẩy nhanh tốc độ tạo mã với các gợi ý được hỗ trợ bởi AI
- Nâng cao chất lượng mã thông qua các khuyến nghị thông minh
- Duy trì tích hợp mượt mà với các quy trình làm việc hiện tại
- Hiểu các cơ sở mã phức tạp và khuyến nghị tối ưu hóa

**Tài Liệu & Kiểm Thử**

- Tự động tạo tài liệu toàn diện
- Tạo bài kiểm tra đơn vị với nỗ lực thủ công tối thiểu
- Cải thiện đáng kể khả năng bảo trì mã và độ tin cậy
- Giảm thiểu boilerplate và các tác vụ mã lặp lại

**Quan Hệ Đối Tác Thông Minh**

- Hoạt động như một đối tác thông minh sử dụng các mô hình ngôn ngữ lớn
- Kết hợp kiến thức dịch vụ AWS sâu sắc với năng lực mã hóa
- Hỗ trợ các nhà phát triển đẩy nhanh các chu kỳ phát triển
- Cải thiện chất lượng mã và củng cố tư thế bảo mật

**Tự Động Hóa Trong Suốt Vòng Đời Phát Triển**

- Tự động hóa các tác vụ tiêu chuẩn trong suốt vòng đời phát triển hoàn chỉnh
- Giảm công việc thủ công, lặp lại
- Cho phép các nhà phát triển tập trung vào các tác vụ sáng tạo có giá trị cao hơn
- Nâng cao năng suất và hiệu quả tổng thể

#### Thực Hành Tốt Nhất Khi Sử Dụng Amazon Q Developer

1. **Cung Cấp Ngữ Cảnh Rõ Ràng** - Cung cấp cho Q thông tin toàn diện về dự án, kiến trúc và yêu cầu của bạn
2. **Áp Dụng Prompt Cụ Thể** - Thay vì các yêu cầu mơ hồ, cung cấp các prompt cụ thể, chi tiết với các ví dụ
3. **Kiểm Tra Các Gợi Ý** - Luôn kiểm tra các gợi ý của Q trước khi áp dụng chúng
4. **Lặp Lại & Cải Thiện** - Nếu gợi ý ban đầu không lý tưởng, tinh chỉnh prompt của bạn và thử lại
5. **Tận Dụng Kiến Thức AWS** - Hưởng lợi từ sự hiểu biết sâu sắc của Q về các dịch vụ AWS và thực hành tốt nhất

---

### 3. Bản Trình Diễn Kiro

#### Kiro Là Gì?

Kiro là một IDE tự chủ (Integrated Development Environment) được tạo ra bởi Amazon Web Services kết nối tạo prototype nhanh được hỗ trợ bởi AI và phát triển phần mềm sẵn sàng cho sản xuất. Nó hiện đang ở giai đoạn xem trước công khai.

#### Triết Lý Cốt Lõi

Kiro đại diện cho nguyên tắc rằng AI nên tăng năng suất của nhà phát triển trong khi duy trì các tiêu chuẩn chuyên nghiệp, tổ chức rõ ràng, kiểm thử toàn diện, tài liệu và khả năng bảo trì lâu dài.

#### Các Tính Năng Chính

**Phát Triển Theo Đặc Tả**

- Khi bạn cung cấp một yêu cầu (ví dụ: "thêm hệ thống đánh giá sản phẩm"), Kiro chuyển đổi nó thành:
  - User stories với tiêu chí chấp nhận rõ ràng
  - Tài liệu thiết kế
  - Danh sách tác vụ và kế hoạch triển khai
  - Thông số kỹ thuật có tổ chức trước khi tạo mã

**Agent Hooks & Tự Động Hóa**

- Tự động khởi tạo các tác vụ dựa trên các sự kiện:
  - Lưu tệp khởi tạo cập nhật tài liệu
  - Commit khởi tạo tạo bài kiểm tra
  - Các hành động cụ thể khởi tạo tối ưu hóa hiệu năng
  - Giảm thiểu công việc thủ công, lặp lại

**Steering & Ngữ Cảnh Dự Án**

- Phát triển các tệp steering (markdown) để phác thảo:
  - Cấu trúc và sắp xếp dự án
  - Tiêu chuẩn mã hóa và quy ước
  - Các mô hình kiến trúc được ưa thích
  - Hướng dẫn nhóm và thực hành tốt nhất
- Hỗ trợ Kiro hiểu sâu sắc ngữ cảnh dự án của bạn

**Phân Tích Đa Tệp & Hiểu Ý Định**

- Kiểm tra nhiều tệp đồng thời
- Nắm bắt các mục tiêu chức năng trên toàn bộ cơ sở mã
- Triển khai các thay đổi phù hợp với các mục tiêu dự án tổng thể
- Mở rộng vượt ra ngoài hoàn thành mã cơ bản

**Tích Hợp VS Code**

- Được xây dựng dựa trên nền tảng mã nguồn mở của VS Code
- Nhập cài đặt, chủ đề và tiện ích mở rộng từ VS Code
- Giao diện quen thuộc cho người dùng VS Code hiện có
- Chuyển đổi dễ dàng cho các nhà phát triển

**Lựa Chọn Mô Hình AI Linh Hoạt**

- Hiện sử dụng Claude Sonnet 4 làm mặc định
- Chế độ "Auto" kết hợp nhiều mô hình dựa trên ngữ cảnh
- Cân bằng giữa chất lượng và chi phí
- Khả năng thích ứng để chọn các mô hình khác nhau cho các tác vụ khác nhau

#### Ưu Điểm Của Việc Sử Dụng Kiro

**Tính Minh Bạch & Kiểm Soát Được Nâng Cao**

- Bắt đầu với các thông số kỹ thuật trước khi tạo mã
- Kiểm tra và xác nhận các thông số kỹ thuật trước khi triển khai
- Giảm mã "ảo tưởng" hoặc triển khai không phù hợp
- Duy trì khả năng truy xuất rõ ràng từ yêu cầu đến mã

**Giảm Boilerplate & Các Tác Vụ Lặp Lại**

- Agent hooks tự động hóa tạo tài liệu
- Tạo bài kiểm tra đơn vị tự động
- Cập nhật thông tin tự động
- Giải phóng các nhà phát triển cho công việc có giá trị cao hơn

**Bảo Mật & Quyền Riêng Tư**

- Hầu hết các hoạt động mã xảy ra cục bộ
- Dữ liệu chỉ được truyền bên ngoài với sự cho phép rõ ràng
- Duy trì kiểm soát thông tin nhạy cảm

**Khả Năng Mở Rộng & Linh Hoạt**

- Kết nối các công cụ bên ngoài thông qua MCP (Model Context Protocol)
- Hỗ trợ nhiều mô hình AI
- Không bị giới hạn vào một môi trường AI duy nhất
- Có thể thích ứng với các quy trình làm việc nhóm khác nhau

#### Hạn Chế & Cân Nhắc

- **Trạng Thái Xem Trước** - Vẫn ở giai đoạn xem trước công khai; tính ổn định và tính năng có thể thay đổi
- **Các Dự Án Phức Tạp** - Có thể gặp thách thức với hiểu biết ngữ cảnh sâu sắc trong các dự án rất phức tạp
- **Cần Giám Sát** - Người dùng vẫn cần giám sát và xác nhận các quyết định của AI
- **Giá Cả Trong Tương Lai** - Các tầng giá dự kiến:
  - Miễn phí: ~50 tác vụ/tháng
  - Pro: ~1.000 tác vụ/tháng
  - Pro+: ~3.000 tác vụ/tháng

#### Khi Nào Nên Sử Dụng Kiro

- Bạn mong muốn một quy trình làm việc AI + lập trình duy trì tính chuyên nghiệp và tổ chức rõ ràng
- Xây dựng prototype nhanh nhưng lo ngại về độ bền sản xuất
- Điều tra cách AI có thể trở thành một đồng nghiệp lập trình thực sự, không chỉ là công cụ gợi ý mã
- Bạn cần phát triển theo đặc tả với tài liệu và kiểm thử tự động

---

## Các Lỗi Thường Gặp Khi Sử Dụng AI Trong Phát Triển

### 1. Kỳ Vọng AI Quản Lý Mọi Thứ

**Vấn Đề:** Nhiều nhà phát triển kỳ vọng AI hoàn thành toàn bộ dự án một cách tự chủ.

**Giải Pháp:** Luôn phát triển kế hoạch trước và kiểm tra thường xuyên. AI là công cụ để tăng năng suất, không phải thay thế phán đoán của nhà phát triển.

### 2. Tỷ Lệ Lỗi Cao

**Vấn Đề:** AI có thể mắc lỗi, đặc biệt trong các tình huống phức tạp.

**Giải Pháp:** Triển khai các chu kỳ kiểm tra thường xuyên. Xác nhận tất cả mã do AI tạo trước khi triển khai.

### 3. Thiếu Yêu Cầu Rõ Ràng

**Vấn Đề:** Yêu cầu mơ hồ hoặc không rõ ràng dẫn đến đầu ra AI mơ hồ.

**Giải Pháp:** Ghi lại yêu cầu với độ chính xác. Hợp tác với AI để phát triển các thông số kỹ thuật chi tiết trước khi triển khai.

### 4. Ràng Buộc Tiêu Cực Thay Vì Hướng Dẫn Khẳng Định

**Vấn Đề:** Hướng dẫn AI "đừng làm cái này" kém hiệu quả hơn "làm cái này."

**Giải Pháp:** Áp dụng các hướng dẫn tích cực, cụ thể. Tỷ lệ thành công cao hơn đến từ hướng dẫn khẳng định rõ ràng.

### 5. Ngữ Cảnh Dự Án Không Đủ

**Vấn Đề:** AI không hiểu các yêu cầu và ràng buộc độc đáo của dự án của bạn.

**Giải Pháp:** Phát triển các tệp steering, cung cấp ngữ cảnh chi tiết và đặt những câu hỏi quan trọng cho AI về dự án của bạn.

### 6. Xem AI Là Người Chỉ Đạo

**Vấn Đề:** Cho phép AI đưa ra tất cả các quyết định về hướng dự án và kiến trúc.

**Giải Pháp:** Nhớ: **Bạn là người chỉ đạo.** Giá trị của bạn nằm ở xác nhận mã và giám sát dự án, không phải viết từng dòng mã.

---

## Những Điểm Chính Rút Ra

1. **AI Là Trợ Lý Của Bạn** - Duy trì quyền kiểm soát các quyết định dự án và hướng triển khai

2. **Thiết Kế Trước, Mã Sau** - Luôn phát triển kế hoạch toàn diện trước khi triển khai

3. **Quan Hệ Đối Tác Hơn Tự Động Hóa** - AI nên đặt câu hỏi và hợp tác, không chỉ thực thi lệnh

4. **Yêu Cầu Rõ Ràng Quan Trọng** - Độ chính xác trong yêu cầu dẫn đến đầu ra AI tốt hơn

5. **Kiểm Tra Thường Xuyên Là Cần Thiết** - Đừng kỳ vọng AI hoàn hảo; kiểm tra và xác nhận liên tục

6. **Bạn Là Người Chỉ Đạo Mã** - Giá trị của bạn nằm ở xác nhận và giám sát, không phải viết từng dòng

7. **Áp Dụng Prompt Có Cấu Trúc** - Các mẫu với ngữ cảnh, user stories và yêu cầu tạo ra kết quả tốt hơn

8. **Lưu Kế Hoạch Thành Tệp** - Phát triển các tài liệu sống bạn có thể tham khảo và điều chỉnh

9. **Hướng Dẫn Khẳng Định Hiệu Quả Hơn** - Hướng dẫn AI phải làm gì, không phải tránh làm gì

10. **Kinh Nghiệm Quan Trọng** - Áp dụng các công cụ này thực tế để hiểu khả năng và hạn chế của chúng

---

## Công Cụ & Tài Nguyên Được Đề Xuất

- **Amazon Q Developer** - Trợ lý phát triển được hỗ trợ bởi AI tích hợp với các dịch vụ AWS
- **Kiro IDE** - Môi trường phát triển theo đặc tả với quan hệ đối tác AI
- **AWS CodeWhisperer** - Công cụ tạo mã và tối ưu hóa
- **MCP (Model Context Protocol)** - Khung công tác để kết nối các công cụ và dịch vụ bên ngoài

---

## Kết Luận

Vòng Đời Phát Triển Dựa trên AI thể hiện một mô hình mới trong kỹ thuật phần mềm nơi AI và con người hợp tác như những người bình đẳng. Thành công đòi hỏi lập kế hoạch rõ ràng, kiểm tra thường xuyên, yêu cầu chính xác và duy trì quyền kiểm soát của nhà phát triển đối với hướng dự án. Các công cụ như Amazon Q Developer và Kiro đang hỗ trợ quy trình làm việc mới này, nhưng chúng hoạt động tốt nhất khi các nhà phát triển hiểu khả năng và hạn chế của chúng, và duy trì vai trò của họ là người chỉ đạo dự án và xác nhận mã.
