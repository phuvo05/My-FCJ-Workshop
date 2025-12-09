---
title: "Bản đề xuất"
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

# FitAI Challenge  
## Ứng dụng hỗ trợ người dùng giảm cân dựa trên các thử thách về bài tập thể dục, tích hợp AI để theo dõi, đánh giá

### 1. Tóm tắt điều hành 
FitAI Challenge là website được phát triển dành cho người Việt Nam, nhằm thúc đẩy phong trào tập luyện thể dục thể hình thông qua các thử thách thể thao có yếu tố gamification và trí tuệ nhân tạo (AI). Website sử dụng AI Camera để nhận diện và đếm động tác tập luyện như push-up, squat, plank, jumping jack,... đồng thời phân tích tư thế nhằm đưa ra đánh giá chính xác.
Người dùng có thể tham gia thử thách cá nhân để nhận điểm thưởng FitPoints khi hoàn thành nhiệm vụ, và quy đổi chúng thành voucher, quà tặng, hoặc ưu đãi từ các đối tác thương mại.
FitAI Challenge hướng đến đối tượng sinh viên, giới trẻ, và người đi làm - những người cần động lực duy trì thói quen tập luyện trong cuộc sống bận rộn.

### 2. Tuyên bố vấn đề 
*Vấn đề hiện tại*  
Tại Việt Nam, các ứng dụng tập luyện hiện có phần lớn tập trung vào hướng dẫn hoặc đếm bước cơ bản, chưa có nền tảng nào kết hợp giữa AI nhận diện động tác, gamification và cộng đồng thử thách thể thao online.
Người dùng thường thiếu động lực để tập đều đặn, không có công cụ đánh giá chính xác hiệu suất tập luyện. Ngoài ra, các phòng gym hoặc thương hiệu thể thao cũng thiếu kênh tương tác sáng tạo với nhóm khách hàng trẻ năng động. 

*Giải pháp*  
FitAI Challenge sử dụng AI Camera để nhận diện, đếm và đánh giá độ chính xác của động tác tập luyện thông qua Computer Vision.
Toàn bộ dữ liệu tập luyện của người dùng được lưu trữ và xử lý qua AWS Cloud với kiến trúc serverless:

AWS Lambda: xử lý dữ liệu AI và yêu cầu backend.
AWS S3: lưu trữ video, hình ảnh, và kết quả tạm thời.
Website được phát triển bằng React Native với giao diện thân thiện, trực quan.
Người dùng có thể:
Tham gia thử thách cá nhân, nhóm hoặc toàn quốc.
Nhận FitPoints khi hoàn thành bài tập.
Đổi FitPoints lấy voucher hoặc quà từ đối tác (Shopee, Grab, CGV,…).
Theo dõi bảng xếp hạng và chia sẻ thành tích lên mạng xã hội.

*Lợi ích và hoàn vốn đầu tư (ROI)*  
Đối với người dùng:
Tạo động lực luyện tập mỗi ngày thông qua cơ chế thử thách và phần thưởng.
Được AI hỗ trợ đánh giá và ghi nhận thành tích minh bạch.
Gắn kết cộng đồng tập luyện thông qua leaderboard và feed chia sẻ.
Đối với doanh nghiệp đối tác:
Kênh quảng bá thương hiệu gắn liền với lối sống lành mạnh.
Tiếp cận tệp khách hàng trẻ – năng động – có ý thức về sức khỏe.
Đối với đội ngũ phát triển:
Mở ra mô hình kinh doanh “Fitness + Gamification + Thương mại điện tử” độc đáo tại Việt Nam.
Cấu trúc cloud serverless giúp giảm chi phí vận hành và dễ mở rộng.
MVP có thể phát triển trong 3 tháng đầu, với chi phí hạ tầng thấp (ước tính 0,80 USD/tháng trên AWS). 

### 3. Kiến trúc giải pháp
FitAI Challenge là nền tảng huấn luyện thể thao thông minh áp dụng kiến trúc AWS Serverless kết hợp AI/ML pipeline trong một Private VPC.

Mục tiêu của hệ thống là:

Ghi nhận dữ liệu luyện tập (video, ảnh, thông số).

Phân tích hiệu suất và tư thế bài tập.

Sinh phản hồi tự động bằng AI để huấn luyện người dùng một cách cá nhân hóa.

Dữ liệu từ ứng dụng web được gửi đến Amazon API Gateway, xử lý bởi AWS Lambda (Java) bên trong Private Subnet, lưu trữ trong Amazon RDS MySQL và Amazon S3.

Các tác vụ phân tích AI được điều phối qua AWS Step Functions và Amazon SQS, gọi Amazon Bedrock thông qua Interface Endpoint. Kiến trúc bám sát sơ đồ mới của nhóm:

![FitAI Challenge Architecture](/images/2-Proposal/2.jpg)

**Dịch vụ AWS sử dụng:**

| Dịch vụ | Vai trò |
| --- | --- |
| Amazon Route 53 | Quản lý tên miền và định tuyến lưu lượng đến CloudFront. |
| AWS WAF | Bảo vệ tầng frontend và API khỏi các tấn công phổ biến (DDoS, OWASP Top 10). |
| Amazon CloudFront | Phân phối nội dung tĩnh (web app build từ React/Next.js, HTML, CSS, JS) với độ trễ thấp. |
| Amazon S3 | Lưu trữ web tĩnh, video/ảnh bài tập, kết quả phân tích AI. |
| Amazon API Gateway | Tiếp nhận yêu cầu từ frontend và chuyển tiếp đến các Lambda backend. |
| Amazon Cognito | Xác thực người dùng, quản lý phiên đăng nhập và phân quyền. |
| AWS Lambda (Java) | Xử lý logic nghiệp vụ (đăng ký, đăng nhập, upload dữ liệu, scoring, kích hoạt AI pipeline). |
| Amazon RDS MySQL | Cơ sở dữ liệu quan hệ chính, lưu người dùng, thử thách, lịch sử luyện tập, FitPoints. |
| VPC Gateway Endpoint (S3) | Cho phép Lambda trong Private Subnet truy cập S3 nội bộ mà không ra Internet công cộng. |
| Interface Endpoint (Bedrock) | Kết nối riêng (PrivateLink) từ VPC đến Amazon Bedrock để gọi mô hình AI một cách bảo mật. |
| Amazon SQS | Hàng đợi lưu trữ nhiệm vụ phân tích AI từ Lambda. |
| AWS Step Functions | Điều phối workflow xử lý AI: trích xuất frame, phân tích, chấm điểm, gọi Bedrock. |
| Amazon Bedrock | Sinh phản hồi bằng ngôn ngữ tự nhiên: nhận xét tư thế, gợi ý cải thiện, tổng kết kết quả. |
| Amazon SES | Gửi email xác thực tài khoản, thông báo kết quả thử thách và tổng kết tuần/tháng. |
| Amazon CloudWatch | Theo dõi log, giám sát Lambda, API Gateway, chi phí và hiệu suất hệ thống. |
| AWS IAM | Quản lý quyền truy cập và bảo mật giữa các dịch vụ. |
| AWS CodeCommit / CodeBuild / CodeDeploy / CodePipeline | Thiết lập CI/CD để tự động build, test và deploy backend, frontend và Lambda. |

**Thiết kế thành phần**

Frontend Layer:

Web app hiển thị giao diện người dùng (React/Next.js), kết nối đến API Gateway.

Nội dung được build và deploy lên S3, phân phối qua CloudFront.

Người dùng truy cập qua Route 53 → WAF → CloudFront → API Gateway.

Application Layer:

API Gateway tiếp nhận yêu cầu từ frontend.

Lambda (Java) thực thi các chức năng nghiệp vụ chính:

AuthLambda: đăng nhập / xác thực người dùng qua Cognito.

UploadLambda: nhận metadata và thông tin file/video bài tập.

AIPipelineLambda: gửi nhiệm vụ phân tích vào SQS và kích hoạt Step Functions.

SaveResultLambda: ghi kết quả luyện tập và phản hồi AI vào RDS + S3.

Data & AI Layer:

RDS MySQL lưu dữ liệu cấu trúc: tài khoản, lịch sử bài tập, FitPoints, leaderboard.

S3 lưu trữ video/ảnh thô và kết quả phân tích.

SQS + Step Functions điều phối pipeline AI.

Bedrock sinh phản hồi thông minh cho từng phiên luyện tập.

### 4. Triển khai kỹ thuật
**Các giai đoạn triển khai**

| Giai đoạn | Mô tả | Kết quả đạt được |
|---|---|---|
| 1. Cấu hình hạ tầng AWS | Triển khai VPC, Private Subnet, Route 53, WAF, S3, API Gateway, Lambda, Cognito, RDS MySQL, các VPC Endpoint (S3, Bedrock). | Hạ tầng cơ bản sẵn sàng, bảo mật và tách biệt mạng. |
| 2. CI/CD Pipeline | Thiết lập CodeCommit + CodeBuild + CodeDeploy + CodePipeline cho backend Java và Lambda, build & deploy web lên S3/CloudFront. | Tự động hóa triển khai backend và frontend. |
| 3. Xây dựng Lambda Functions (Java) | Tạo các Lambda cho Auth, Upload, AI Pipeline, Save Result; kết nối RDS MySQL và S3. | Hoàn thiện backend serverless. |
| 4. AI Pipeline | Kết nối SQS, Step Functions, Bedrock; xây dựng workflow: nhận nhiệm vụ → phân tích dữ liệu → chấm điểm → sinh phản hồi AI. | AI hoạt động trơn tru, phản hồi tự động cho người dùng. |
| 5. Triển khai Web App | Build web app → Deploy lên S3 + CloudFront → cấu hình domain với Route 53. | Giao diện người dùng hoạt động online ổn định. |
| 6. Giám sát & Tối ưu chi phí | Dùng CloudWatch + Cost Explorer để theo dõi log, hiệu suất, chi phí; tinh chỉnh cấu hình Lambda, RDS, CloudFront. | Hệ thống ổn định, chi phí thấp và được giám sát chặt chẽ. |


### 5. Lộ trình & Mốc triển khai
**Trước thực tập (Tháng 0):**

Thiết kế kiến trúc chi tiết dựa trên sơ đồ mới.

Thử nghiệm pipeline AI đơn giản với Bedrock (text feedback).

**Thực tập (Tháng 1–3):**

Tháng 1:

Thiết lập hạ tầng: VPC, Subnet, RDS MySQL, Cognito, API Gateway, Lambda, S3, CloudFront.

Cấu hình CI/CD (CodeCommit, CodeBuild, CodeDeploy, CodePipeline).

Tháng 2:

Phát triển Java backend, Lambda functions.

Xây dựng AI pipeline với SQS, Step Functions, Bedrock.

Tháng 3:

Tích hợp frontend với backend.

Kiểm thử hiệu suất, chạy thử với 10–20 người dùng, chuẩn bị demo cuối kỳ.

**Sau triển khai:**

Tiếp tục tối ưu mô hình AI, bổ sung tính năng gamification trong vòng 1 năm.

### 6. Ước tính ngân sách
Có thể xem chi phí trên AWS Pricing Calculator hoặc tải tệp ước tính ngân sách đính kèm.

**Chi phí hạ tầng (ước tính giai đoạn MVP)**

- Dịch vụ AWS:
    - Amazon API Gateway: 0,38 USD / tháng (≈300 requests/tháng, 1 KB/request).
    - Amazon Bedrock: 0,32 USD / tháng (1 req/phút, 350 input tokens, 70 output tokens).
    - Amazon CloudFront: 1,20 USD / tháng (5 GB transfer, 500 000 HTTPS requests).
    - Amazon CloudWatch: 1,85 USD / tháng (5 metrics, 0,5 GB logs).
    - Amazon Cognito: 0,00 USD / tháng (≤100 MAU).
    - Amazon Route 53: 0,51 USD / tháng (1 hosted zone).
    - Amazon S3: 0,04 USD / tháng (1 GB storage, 1000 PUT/POST/LIST, 20 000 GET).
    - Amazon SES: 0,30 USD / tháng (3 000 emails from EC2/Lambda).
    - Amazon Simple Queue Service (SQS): ≈0,00 USD / tháng (0,005 triệu requests/tháng).
    - AWS Lambda: 0,00 USD / tháng (≈300 000 requests/tháng, 512 MB ephemeral storage).
    - AWS Step Functions: 0,00 USD / tháng (500 workflows, 5 state transitions/workflow).
    - AWS Web Application Firewall (WAF): 6,12 USD / tháng (1 Web ACL, 1 rule).
    - Amazon RDS MySQL (chế độ auto-stop): 0–3 USD / tháng (tùy thời gian hoạt động).

**Tổng:** khoảng 10,7 – 12 USD / tháng tùy mức sử dụng RDS; tương đương 128 – 144 USD / 12 tháng.

### 7. Đánh giá rủi ro
**Ma trận rủi ro**

- Kỹ thuật: AI nhận diện sai động tác hoặc lỗi xử lý dữ liệu ảnh/video; cấu hình VPC/Endpoint sai gây gián đoạn dịch vụ.
- Người dùng: Không duy trì thói quen luyện tập, tỷ lệ quay lại thấp.
- Thị trường & Đối tác: Khó mở rộng mạng lưới đối tác thưởng và thương hiệu đồng hành; thay đổi chính sách từ đối tác.
- Chi phí: Tăng chi phí bất ngờ khi lượng người dùng tăng đột biến (CloudFront, Bedrock).

**Chiến lược giảm thiểu**

- Tối ưu mô hình AI qua huấn luyện liên tục, theo dõi chất lượng qua log; thêm bước kiểm tra cơ bản trước khi chấm điểm.
- Triển khai gamification sâu hơn (chuỗi streak, nhóm bạn, thử thách theo mùa, phần thưởng hấp dẫn).
- Chuẩn bị đề xuất giá trị rõ ràng cho đối tác, đa dạng hóa nhóm đối tác (thể thao, đồ ăn healthy, giải trí).
- Thiết lập AWS Budget + Alarm cho từng dịch vụ (CloudFront, Bedrock, Lambda, RDS).

**Kế hoạch dự phòng**

- Khi AI gặp lỗi → sử dụng fallback logic (chấm điểm đơn giản dựa trên thời gian/rep) và thông báo rõ cho người dùng.
- Khi lượng người dùng giảm → tung thử thách cộng đồng theo mùa, kết hợp chiến dịch social media.
- Khi đối tác thương mại rút lui → duy trì cơ chế FitPoints nội bộ đổi quà nhỏ (voucher nội bộ, huy hiệu trong app) trong khi tìm đối tác mới.

### 8. Kết quả kỳ vọng
**Cải tiến kỹ thuật:**

- Hoàn thiện hệ thống AI nhận diện động tác có độ chính xác > 90%.
- Ứng dụng ổn định, đáp ứng tới 10.000 người dùng hoạt động đồng thời trên kiến trúc serverless.
- Tối ưu kiến trúc giúp chi phí hạ tầng duy trì khoảng 10–12 USD/tháng ở giai đoạn đầu.

**Giá trị dài hạn:**

- Xây dựng cộng đồng người Việt yêu thích thể thao và sức khỏe bền vững, gắn kết qua các thử thách online.
- Trở thành nền tảng tiên phong "AI + Fitness + Gamification" tại Việt Nam.
- Tạo nền tảng dữ liệu luyện tập để mở rộng sang các bài toán phân tích sức khỏe, gợi ý chương trình tập cá nhân hóa và các dự án AI trong tương lai.

---

### 9. Tài liệu đính kèm

**Tài liệu đề xuất đầy đủ:**

- [FitAI Challenge Proposal (Bản tiếng Anh)](https://docs.google.com/document/d/1AeFEG8Jqn2Q0pHPuSP1duRDKY7Ofjm9a790m7R4-Gdc/edit?usp=sharing)
- [FitAI Challenge Proposal (Bản tiếng Việt)](https://docs.google.com/document/d/1o8jOyfRCc5Y6LWNi4c96bCFBOI5xPi3U7VQwM1WTOGs/edit?usp=sharing)

