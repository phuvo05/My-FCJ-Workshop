---
title: "Blog 3"
weight: 1
chapter: false
pre: " <b> 3.3. </b> "
---

{{% notice warning %}}
⚠️ **Lưu ý:** Các thông tin dưới đây chỉ nhằm mục đích tham khảo, vui lòng **không sao chép nguyên văn** cho bài báo cáo của bạn kể cả warning này.
{{% /notice %}}

# Điều hướng các gói bảo vệ Amazon GuardDuty và Phát hiện mối đe dọa mở rộng

by Nisha Amthul, Shachar Hirshberg và Sujay Doshi on 15 SEP 2025 in [<u>Amazon GuardDuty</u>](https://aws.amazon.com/blogs/security/category/security-identity-compliance/amazon-guardduty/), [<u>Intermediate (200)</u>](https://aws.amazon.com/blogs/security/category/learning-levels/intermediate-200/), [<u>Security, Identity, & Compliance</u>](https://aws.amazon.com/blogs/security/category/security-identity-compliance/) [<u>Permalink</u>](https://aws.amazon.com/blogs/security/navigating-amazon-guardduty-protection-plans-and-extended-threat-detection/) [<u>Comments Chia sẻ</u>](https://aws.amazon.com/vi/blogs/security/navigating-amazon-guardduty-protection-plans-and-extended-threat-detection/)

Các tổ chức đang đổi mới và phát triển sự hiện diện trên đám mây của họ để mang lại trải nghiệm khách hàng tốt hơn và thúc đẩy giá trị kinh doanh. Để hỗ trợ và bảo vệ sự tăng trưởng này, các tổ chức có thể sử dụng [<u>Amazon GuardDuty</u>](https://aws.amazon.com/guardduty/), một dịch vụ phát hiện mối đe dọa liên tục giám sát hoạt động độc hại và hành vi trái phép trên môi trường AWS của bạn. GuardDuty sử dụng trí tuệ nhân tạo (AI), máy học (ML) và phát hiện bất thường bằng cách sử dụng cả AWS và thông tin về mối đe dọa hàng đầu trong ngành để giúp bảo vệ tài khoản, khối lượng công việc và dữ liệu AWS của bạn. Dựa trên các khả năng cơ bản này, GuardDuty cung cấp một bộ kế hoạch bảo vệ toàn diện và <u>[tính năng](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html)</u> Phát hiện mối đe dọa mở rộng.

Trong bài đăng này, chúng tôi khám phá cách sử dụng các tính năng này để cung cấp phạm vi bảo mật mạnh mẽ cho khối lượng công việc AWS của bạn, giúp bạn phát hiện các mối đe dọa tinh vi trên môi trường AWS của mình.

**Tìm hiểu về các gói bảo vệ GuardDuty**

GuardDuty bắt đầu với tính năng giám sát bảo mật cơ bản, phân tích các sự kiện quản lý [<u>AWS CloudTrail</u>](https://aws.amazon.com/cloudtrail), Nhật ký luồng [<u>Amazon Virtual Private Cloud (Amazon VPC</u>](https://aws.amazon.com/vpc)) và nhật ký DNS. Dựa trên nền tảng này, GuardDuty cung cấp một số gói bảo vệ giúp mở rộng khả năng phát hiện mối đe dọa sang các nguồn dữ liệu và dịch vụ AWS bổ sung. Các gói bảo vệ này là các tính năng tùy chọn phân tích dữ liệu từ các dịch vụ AWS cụ thể trong môi trường của bạn để cung cấp phạm vi bảo mật nâng cao. GuardDuty cung cấp sự linh hoạt để tùy chỉnh cách các tài khoản mới kế thừa các kế hoạch bảo vệ, vì vậy bạn có thể thêm bảo hiểm cho các tài khoản của mình hoặc chọn các tài khoản cụ thể dựa trên nhu cầu bảo mật của mình. Bạn có thể bật hoặc tắt các gói bảo vệ này bất kỳ lúc nào để phù hợp với các yêu cầu về khối lượng công việc đang phát triển của mình.

Dưới đây là các gói bảo vệ GuardDuty có sẵn và khả năng của chúng:

| Gói bảo vệ GuardDuty                                                                                                    | Sự mô tả                                                                                                                                                                                                                                                                                                                                                          |
|-------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [<u>Bảo vệ S3</u>](https://docs.aws.amazon.com/guardduty/latest/ug/s3-protection.html)                                  | Xác định các rủi ro bảo mật tiềm ẩn như nỗ lực lấy cắp và phá hủy dữ liệu trong <u>[vùng lưu trữ](https://aws.amazon.com/s3)</u> Amazon Simple Storage Service (Amazon S3) của bạn.                                                                                                                                                                               |
| [<u>Bảo vệ EKS</u>](https://docs.aws.amazon.com/guardduty/latest/ug/kubernetes-protection.html)                         | Giám sát nhật ký kiểm tra EKS phân tích nhật ký kiểm tra Kubernetes từ [<u>các cụm Amazon Elastic Kubernetes Service (Amazon EKS)</u>](https://aws.amazon.com/eks) của bạn để tìm các hoạt động đáng ngờ và độc hại tiềm ẩn.                                                                                                                                      |
| [<u>Giám sát thời gian chạy</u>](https://docs.aws.amazon.com/guardduty/latest/ug/runtime-monitoring.html)               | Giám sát và phân tích các sự kiện cấp hệ điều hành trên Amazon EKS, [<u>Amazon Elastic Compute Cloud (Amazon EC2)</u>](https://aws.amazon.com/ec2) và [<u>Amazon Elastic Container Service (Amazon ECS)</u>](https://aws.amazon.com/ecs) (bao gồm [<u>AWS Fargate</u>](https://aws.amazon.com/fargate)) để phát hiện các mối đe dọa tiềm ẩn trong thời gian chạy. |
| [<u>Bảo vệ phần mềm độc hại cho EC2</u>](https://docs.aws.amazon.com/guardduty/latest/ug/malware-protection.html)       | Phát hiện sự hiện diện tiềm ẩn của phần mềm độc hại bằng cách quét [<u>ổ đĩa Amazon Elastic Block Store (Amazon EBS)</u>](https://aws.amazon.com/ebs) được liên kết với các phiên bản EC2 của bạn. Có một tùy chọn để sử dụng tính năng này theo yêu cầu.                                                                                                         |
| [<u>Bảo vệ phần mềm độc hại cho S3</u>](https://docs.aws.amazon.com/guardduty/latest/ug/gdu-malware-protection-s3.html) | Phát hiện sự hiện diện tiềm ẩn của phần mềm độc hại trong các đối tượng mới tải lên trong vùng lưu trữ S3 của bạn.                                                                                                                                                                                                                                                |
| [<u>Bảo vệ RDS</u>](https://docs.aws.amazon.com/guardduty/latest/ug/rds-protection.html)                                | Phân tích và lập hồ sơ hoạt động đăng nhập RDS của bạn để tìm các mối đe dọa truy cập tiềm ẩn đối với [<u>cơ sở dữ liệu</u>](https://aws.amazon.com/aurora) Amazon Aurora <u>[và](https://aws.amazon.com/rds)</u> Amazon Relational Database Service (Amazon RDS) được hỗ trợ.                                                                                    |
| [<u>Bảo vệ Lambda</u>](https://docs.aws.amazon.com/guardduty/latest/ug/lambda-protection.html)                          | Giám sát nhật ký hoạt động mạng [<u>AWS Lambda</u>](https://aws.amazon.com/lambda), bắt đầu với Nhật ký luồng VPC, để phát hiện các mối đe dọa đối với các hàm Lambda của bạn. Ví dụ về các mối đe dọa tiềm ẩn này bao gồm khai thác tiền điện tử và giao tiếp với các máy chủ độc hại.                                                                           |

Hãy cùng khám phá cách các gói bảo vệ này giúp bảo mật các khía cạnh khác nhau của môi trường AWS của bạn.

**Bảo vệ S3**

S3 Protection mở rộng khả năng phát hiện mối đe dọa của GuardDuty cho vùng lưu trữ S3 của bạn bằng cách giám sát các hoạt động API cấp đối tượng. Ngoài giám sát cơ bản, nó phân tích các mẫu hành vi để phát hiện các mối đe dọa tinh vi. Khi tác nhân đe dọa cố gắng lấy cắp dữ liệu, GuardDuty có thể phát hiện các chuỗi lệnh gọi API bất thường, chẳng hạn như các hoạt động ListBucket, sau đó là các yêu cầu GetObject đáng ngờ từ các vị trí bất thường. Nó cũng xác định các rủi ro bảo mật tiềm ẩn như nỗ lực vô hiệu hóa ghi nhật ký truy cập máy chủ S3 hoặc các thay đổi trái phép đối với chính sách vùng lưu trữ có thể cho thấy nỗ lực đặt vùng lưu trữ ở chế độ công khai. Ví dụ: GuardDuty sẽ tạo kết quả truy cập trái phép nếu phát hiện các lệnh gọi API đáng ngờ này bắt nguồn từ các địa chỉ IP độc hại đã biết.

**Bảo vệ EKS**

Đối với khối lượng công việc trong bộ chứa, EKS Protection giám sát nhật ký kiểm tra mặt phẳng điều khiển của cụm Amazon EKS để tìm các mối đe dọa bảo mật. Nó được thiết kế đặc biệt để phát hiện khai thác dựa trên bộ chứa bằng cách phân tích nhật ký kiểm tra Kubernetes từ các cụm EKS của bạn. GuardDuty phát hiện các tình huống như bộ chứa được triển khai với các đặc điểm đáng ngờ (như hình ảnh độc hại đã biết), cố gắng leo thang đặc quyền thông qua các sửa đổi liên kết vai trò và các hoạt động tài khoản dịch vụ đáng ngờ có thể cho thấy môi trường Kubernetes của bạn bị xâm phạm. Khi phát hiện các hoạt động như vậy, GuardDuty sẽ tạo kết quả PrivilegeEscalation, cảnh báo bạn về các nỗ lực truy cập trái phép tiềm ẩn trong các cụm của bạn. Để hiểu toàn diện về chiến thuật, kỹ thuật và quy trình (TTP), hãy xem [<u>Danh mục kỹ thuật về mối đe dọa của AWS</u>](https://aws-samples.github.io/threat-technique-catalog-for-aws/).

**Giám sát thời gian chạy**

Giám sát thời gian chạy cung cấp khả năng hiển thị sâu hơn về các mối đe dọa tiềm ẩn bằng cách phân tích hành vi thời gian chạy trong các phiên bản EC2, cụm EKS và khối lượng công việc bộ chứa. Khả năng này phát hiện các mối đe dọa biểu hiện ở cấp hệ điều hành bằng cách giám sát việc thực thi quy trình, thay đổi hệ thống tệp và kết nối mạng. GuardDuty có thể xác định các chiến thuật trốn tránh phòng thủ, thực hiện các quy trình đáng ngờ và các mẫu truy cập tệp cho thấy hoạt động phần mềm độc hại tiềm ẩn. Ví dụ: nếu một phiên bản bị xâm nhập cố gắng vô hiệu hóa tính năng giám sát bảo mật hoặc tạo ra các quy trình bất thường, GuardDuty sẽ tạo kết quả Thời gian chạy cho biết hoạt động độc hại tiềm ẩn ở cấp hệ điều hành.

**Bảo vệ phần mềm độc hại**

Bảo vệ chống phần mềm độc hại cung cấp hai khả năng riêng biệt: quét ổ đĩa EBS được gắn vào phiên bản EC2 và quét các đối tượng được tải lên vùng lưu trữ S3. Đối với các phiên bản EC2, GuardDuty có thể thực hiện cả quét theo yêu cầu không tác nhân và quét liên tục ổ đĩa EBS, phát hiện cả phần mềm độc hại đã biết và các tệp độc hại tiềm ẩn bằng phương pháp phỏng đoán nâng cao. Đối với S3, nó tự động quét các đối tượng mới tải lên, giúp bảo vệ chống lại sự phân tán phần mềm độc hại thông qua vùng lưu trữ S3 của bạn. Khi phát hiện phần mềm độc hại, GuardDuty sẽ tạo ra phát hiện phần mềm độc hại, chỉ định xem mối đe dọa được tìm thấy trong phiên bản EC2 hay vùng lưu trữ S3, giúp bạn nhanh chóng xác định và ứng phó với mối đe dọa.

**Bảo vệ RDS**

RDS Protection tập trung vào bảo mật cơ sở dữ liệu bằng cách phân tích hoạt động đăng nhập cho [<u>cơ sở dữ liệu Amazon Aurora được hỗ trợ</u>](https://docs.aws.amazon.com/guardduty/latest/ug/rds-protection.html). Nó tạo ra các đường cơ sở hành vi của các mẫu truy cập cơ sở dữ liệu thông thường và có thể phát hiện các nỗ lực đăng nhập bất thường có thể cho thấy các nỗ lực truy cập trái phép. Điều này bao gồm phát hiện các mẫu đăng nhập bất thường, truy cập từ các vị trí không mong muốn và các nỗ lực xâm phạm cơ sở dữ liệu tiềm ẩn. Khi phát hiện truy cập cơ sở dữ liệu đáng ngờ, GuardDuty sẽ tạo kết quả RDS, cảnh báo bạn về khả năng truy cập trái phép hoặc xâm phạm thông tin đăng nhập.

**Bảo vệ Lambda**

Lambda Protection giám sát các ứng dụng phi máy chủ của bạn bằng cách phân tích hoạt động của hàm Lambda thông qua Nhật ký luồng VPC. Nó có thể phát hiện các mối đe dọa cụ thể đối với môi trường phi máy chủ, chẳng hạn như khi các hàm Lambda có dấu hiệu bị xâm phạm thông qua các kết nối mạng không mong muốn hoặc hoạt động khai thác tiền điện tử tiềm ẩn. Nếu hàm Lambda cố gắng giao tiếp với các địa chỉ IP độc hại đã biết hoặc có dấu hiệu cryptojacking, GuardDuty sẽ tạo kết quả Lambda, vì vậy bạn có thể nhanh chóng xác định và khắc phục các hàm bị xâm phạm.

Mỗi gói bảo vệ bổ sung các khả năng phát hiện chuyên biệt được thiết kế cho các loại khối lượng công việc cụ thể, phối hợp với nhau để cung cấp khả năng phát hiện mối đe dọa toàn diện trên môi trường AWS của bạn. Bằng cách bật các gói bảo vệ liên quan đến khối lượng công việc của mình, bạn có thể giúp đảm bảo rằng GuardDuty cung cấp khả năng giám sát bảo mật có mục tiêu cho các trường hợp sử dụng cụ thể của mình

**Điều chỉnh các kế hoạch bảo vệ GuardDuty cho phù hợp với loại khối lượng công việc của bạn**

Để tối đa hóa phạm vi phát hiện mối đe dọa, hãy cân nhắc bật tất cả các gói bảo vệ GuardDuty hiện hành trên môi trường AWS của bạn. Cách tiếp cận này giúp cung cấp phạm vi bảo vệ toàn diện trong khi vẫn duy trì hiệu quả chi phí vì bạn chỉ bị tính phí cho các biện pháp bảo vệ đang hoạt động đối với các tài nguyên tồn tại trong tài khoản của mình. Ví dụ: nếu bạn không sử dụng Amazon EKS, bạn sẽ không phải trả phí cho Bảo vệ EKS ngay cả khi nó được bật. Chiến lược này cũng giúp tạo điều kiện bảo mật tự động nếu các nhóm triển khai dịch vụ mới mà không yêu cầu sự can thiệp của nhóm bảo mật ngay lập tức. Bạn có thể linh hoạt điều chỉnh các kế hoạch bảo vệ của mình bất cứ lúc nào khi yêu cầu khối lượng công việc của bạn phát triển.

Dựa trên các biện pháp thực hành tốt nhất về bảo mật của AWS, chúng tôi đưa ra các đề xuất cho các kết hợp gói bảo vệ khác nhau phù hợp với hồ sơ khối lượng công việc phổ biến. Những đề xuất này giúp bạn hiểu cách các gói bảo vệ khác nhau hoạt động cùng nhau để bảo mật các kiến trúc cụ thể của bạn. Đối với khối lượng công việc Amazon EC2 và Amazon S3, GuardDuty khuyến nghị Foundational, Amazon S3 Protection và Amazon GuardDuty Malware Protection cho Amazon EC2 để phát hiện các mối đe dọa đối với các phiên bản điện toán, lưu trữ dữ liệu và <u>[lạm dụng AWS](https://aws.amazon.com/iam/)</u> Identity and Access Management (IAM).

Các môi trường sử dụng nhiều bộ chứa sử dụng Amazon EKS và Amazon ECS được hưởng lợi từ Foundational, Amazon EKS Protection, Amazon GuardDuty Runtime Monitoring và Amazon GuardDuty Malware Protection for Amazon EC2. Các kế hoạch này hoạt động cùng nhau để giám sát mặt phẳng điều khiển bộ chứa và thời gian chạy để tìm các mối đe dọa và phần mềm độc hại.

Đối với các kiến trúc ưu tiên phi máy chủ được xây dựng trên Lambda, GuardDuty đề xuất Foundational, AWS Lambda Protection và Amazon S3 Protection (nếu sử dụng trình kích hoạt Amazon S3) để xác định hành vi chức năng bất thường và các mẫu lưu lượng truy cập đáng ngờ.

Các hệ thống dữ liệu sử dụng Amazon Aurora hoặc Amazon RDS nên xem xét Foundational, Amazon RDS Protection, Amazon S3 Protection và Amazon GuardDuty Malware Protection for Amazon S3. Sự kết hợp này giúp phát hiện đăng nhập cơ sở dữ liệu bất thường và khả năng sử dụng sai vùng lưu trữ S3.

Đối với các môi trường được quản lý hoặc những môi trường triển khai kiến trúc không tin cậy, việc bật tất cả các gói bảo vệ GuardDuty giúp cung cấp phạm vi phát hiện mối đe dọa toàn diện có thể hỗ trợ các yêu cầu chương trình tuân thủ và giám sát bảo mật rộng hơn của bạn.

Để tham khảo nhanh, đây là những gói bảo vệ bạn nên sử dụng để chủ động theo dõi các loại khối lượng công việc khác nhau của mình:

| Hồ sơ khối lượng công việc                       | Kết quả bảo mật dự kiến                                                                                 | Các gói GuardDuty được đề xuất                                                                                                                              |
|--------------------------------------------------|---------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Amazon EC2 và Amazon S3                          | Phát hiện các mối đe dọa đối với phiên bản điện toán, lưu trữ dữ liệu và lạm dụng IAM                   | Bảo vệ nền tảng, Amazon S3 Protection và Bảo vệ phần mềm độc hại Amazon GuardDuty cho Amazon EC2                                                            |
| Nặng bộ chứa (Amazon EKS, Amazon ECS)            | Giám sát mặt phẳng điều khiển bộ chứa và thời gian chạy để phát hiện các mối đe dọa và phần mềm độc hại | Nền tảng, Bảo vệ Amazon EKS, Giám sát thời gian chạy của Amazon GuardDuty và Bảo vệ chống phần mềm độc hại của Amazon GuardDuty cho Amazon EC2              |
| Ưu tiên phi máy chủ (AWS Lambda)                 | Xác định hành vi chức năng bất thường và các mẫu lưu lượng đáng ngờ                                     | Nền tảng, GuardDuty Lambda Protection, GuardDuty S3 Protection (nếu sử dụng trình kích hoạt Amazon S3) và GuardDuty Runtime Monitoring cho ECS trên Fargate |
| Hệ thống dữ liệu (Amazon Aurora hoặc Amazon RDS) | Phát hiện đăng nhập cơ sở dữ liệu bất thường và khả năng sử dụng sai vùng lưu trữ S3                    | Nền tảng, Bảo vệ Amazon RDS, Bảo vệ GuardDuty S3 và Bảo vệ chống phần mềm độc hại của Amazon GuardDuty cho Amazon S3                                        |
| Được quản lý và không tin cậy                    | Phát hiện mối đe dọa toàn diện để hỗ trợ các yêu cầu tuân thủ                                           | Tất cả các gói bảo vệ Amazon GuardDuty                                                                                                                      |

**Sức mạnh của GuardDuty Phát hiện mối đe dọa mở rộng**

Dựa trên các kế hoạch bảo vệ này, GuardDuty cung cấp tính năng Phát hiện mối đe dọa mở rộng theo mặc định mà không mất thêm phí, sử dụng các chức năng AI/ML để cải thiện khả năng phát hiện mối đe dọa cho các ứng dụng, khối lượng công việc và dữ liệu của bạn. Khả năng này tương quan các tín hiệu bảo mật để xác định chuỗi mối đe dọa đang hoạt động, cung cấp cách tiếp cận toàn diện hơn đối với bảo mật đám mây.

Phát hiện mối đe dọa mở rộng bao gồm mức độ nghiêm trọng nghiêm trọng đối với các mối đe dọa khẩn cấp và có độ tin cậy cao nhất dựa trên nhiều bước tương quan do đối thủ thực hiện, chẳng hạn như khám phá đặc quyền, thao túng API, hoạt động liên tục và đánh cắp dữ liệu. Tích hợp với khung MITRE ATT&CK® cho phép GuardDuty ánh xạ các hoạt động quan sát được với các chiến thuật và kỹ thuật, cung cấp bối cảnh cho các nhóm bảo mật. Để giúp các nhóm phản ứng nhanh chóng, GuardDuty cung cấp các đề xuất khắc phục cụ thể dựa trên các biện pháp thực hành tốt nhất của AWS cho từng mối đe dọa đã xác định.

**Bảo vệ trong thế giới thực: Phát hiện mối đe dọa mở rộng đang hoạt động**

Để hiểu cách các kế hoạch bảo vệ GuardDuty và Phát hiện mối đe dọa mở rộng hoạt động cùng nhau trong thực tế, chúng ta hãy xem xét hai tình huống đe dọa phức tạp mà các nhóm bảo mật thường gặp phải: xâm phạm dữ liệu và xâm phạm cụm container.

**Phát hiện xâm phạm dữ liệu**

Phát hiện mối đe dọa mở rộng của GuardDuty liên tục phân tích và tương quan các sự kiện trên nhiều gói bảo vệ, cung cấp khả năng hiển thị toàn diện khi xảy ra nỗ lực xâm phạm dữ liệu trong Amazon S3. Ví dụ: trong một sự cố gần đây, GuardDuty đã xác định một chuỗi tấn công nghiêm trọng kéo dài 24 giờ. Trình tự bắt đầu với các hành động khám phá thông qua các lệnh gọi API S3 bất thường, tiến triển đến việc trốn tránh phòng thủ thông qua các sửa đổi CloudTrail và lên đến đỉnh điểm là các nỗ lực lấy cắp dữ liệu tiềm năng.

Trong giai đoạn khám phá, S3 Protection đã phát hiện một vai trò IAM thực hiện các lệnh gọi API ListBucket và GetObject bất thường trên nhiều vùng lưu trữ—một sai lệch đáng kể so với mô hình thông thường của họ là chỉ truy cập vào các vùng lưu trữ được chỉ định cụ thể. Sau đó, Phát hiện mối đe dọa mở rộng tương quan hoạt động đáng ngờ này với các hành động tiếp theo từ cùng một vai trò IAM: cố gắng tắt tính năng ghi nhật ký CloudTrail và sửa đổi chính sách vùng lưu trữ (dấu hiệu ẩn tránh phòng thủ cổ điển), sau đó là tạo khóa truy cập mới. Chuỗi sự kiện được kết nối này, tất cả đều từ cùng một danh tính, cho thấy một khai thác tiến triển chuyển từ khám phá ban đầu đến thiết lập sự bền bỉ thông qua việc tạo thông tin xác thực.

**Xâm phạm môi trường container**

Bảo vệ môi trường trong bộ chứa đòi hỏi khả năng hiển thị trên nhiều lớp cơ sở hạ tầng Amazon EKS của bạn. GuardDuty kết hợp các tín hiệu từ mặt phẳng điều khiển EKS (thông qua EKS Protection), hành vi thời gian chạy của bộ chứa (thông qua Giám sát thời gian chạy) và nhật ký cơ sở hạ tầng cơ bản để phát hiện mối đe dọa toàn diện cho các cụm Kubernetes của bạn. Ví dụ: Bảo vệ EKS phát hiện các hoạt động đáng ngờ ở cấp mặt phẳng điều khiển Kubernetes, chẳng hạn như các nỗ lực xác thực máy chủ API Kubernetes bất thường hoặc tạo tài khoản dịch vụ có quyền nâng cao. Giám sát thời gian chạy cung cấp khả năng hiển thị hành vi của bộ chứa, xác định các lệnh đặc quyền không mong muốn hoặc truy cập hệ thống tệp đáng ngờ. Cùng với nhật ký cơ bản, các thành phần này cung cấp khả năng phát hiện mối đe dọa nhiều lớp cho khối lượng công việc bộ chứa của bạn.

Dưới đây là cách các thành phần này hoạt động cùng nhau trong việc phát hiện chuỗi tấn công: Khai thác bắt đầu khi EKS Protection phát hiện các nỗ lực xác thực máy chủ API Kubernetes bất thường từ một vùng chứa trong cụm. Giám sát thời gian chạy đồng thời quan sát các lệnh sai lệch so với hành vi cơ bản của bộ chứa, chẳng hạn như nỗ lực leo thang đặc quyền và lệnh gọi hệ thống trái phép. Khi quá trình khai thác diễn ra, GuardDuty đã phát hiện việc tạo tài khoản dịch vụ Kubernetes với các quyền nâng cao, sau đó là các nỗ lực gắn các đường dẫn máy chủ nhạy cảm vào các vùng chứa.

Kịch bản sau đó leo thang khi Kubernetes Pod bị xâm nhập thiết lập kết nối với các Pod khác trên các không gian tên, gợi ý chuyển động ngang. Phát hiện mối đe dọa mở rộng của GuardDuty tương quan các sự kiện này với Pod truy cập bí mật Kubernetes nhạy cảm và thông tin xác thực AWS được lưu trữ trong Kubernetes ConfigMaps. Giai đoạn cuối cùng cho thấy Pod bị xâm nhập thực hiện các lệnh gọi API AWS bằng cách sử dụng thông tin xác thực bị đánh cắp, nhắm mục tiêu các tài nguyên nằm ngoài phạm vi hoạt động bình thường của cụm.

Việc phát hiện cuộc tấn công nhiều giai đoạn này, bao gồm khai thác vùng chứa, leo thang đặc quyền và đánh cắp thông tin đăng nhập, thể hiện sức mạnh của khả năng tương quan của Phát hiện mối đe dọa mở rộng. Các nhóm bảo mật đã nhận được một phát hiện quan trọng duy nhất ánh xạ toàn bộ trình tự khai thác với chiến thuật MITRE ATT&CK®, cung cấp khả năng hiển thị rõ ràng về tiến trình khai thác và các bước khắc phục cụ thể.

Các tình huống thực tế này minh họa cách các kế hoạch bảo vệ GuardDuty hoạt động phối hợp với Phát hiện mối đe dọa mở rộng để cung cấp thông tin chuyên sâu về bảo mật. Sự kết hợp giữa các kế hoạch bảo vệ có mục tiêu và mối tương quan do AI cung cấp giúp các nhóm bảo mật xác định và ứng phó với các mối đe dọa tinh vi có thể không được chú ý hoặc khó ghép lại với nhau theo cách thủ công.

**Kết thúc**

Các gói bảo vệ GuardDuty, cùng với tính năng Phát hiện mối đe dọa mở rộng tích hợp, cung cấp một bộ phát hiện được quản lý mạnh mẽ để bảo mật môi trường AWS của bạn. Bằng cách điều chỉnh chiến lược bảo mật cho phù hợp với các loại khối lượng công việc cụ thể và sử dụng thông tin chi tiết do AI cung cấp, bạn có thể nâng cao đáng kể khả năng phát hiện và ứng phó với các mối đe dọa tinh vi. Để bắt đầu với các gói bảo vệ GuardDuty và Phát hiện mối đe dọa mở rộng, hãy truy cập bảng điều khiển GuardDuty. Mỗi gói bảo vệ bao gồm bản dùng thử 30 ngày miễn phí cho mỗi tài khoản AWS và Khu vực AWS, cho phép bạn đánh giá phạm vi bảo mật cho các nhu cầu cụ thể của mình. Hãy nhớ rằng bạn có thể điều chỉnh các gói đã bật của mình bất kỳ lúc nào để phù hợp với các yêu cầu bảo mật đang phát triển và thay đổi khối lượng công việc. Bằng cách sử dụng các chức năng này, bạn có thể tăng cường khả năng phát hiện và ứng phó với mối đe dọa của tổ chức khi đối mặt với các rủi ro bảo mật ngày càng phát triển.



### **Nisha Amthul**
<img src = "media/image1.jpg">
Nisha là Giám đốc Tiếp thị Sản phẩm Cấp cao tại AWS Security, chuyên về các giải pháp phát hiện và phản ứng sự cố. Cô có nền tảng vững chắc trong quản lý sản phẩm và tiếp thị sản phẩm trong các lĩnh vực an ninh thông tin và bảo vệ dữ liệu. Khi không làm việc, Nisha thích trang trí bánh, tập luyện sức mạnh, và chăm sóc hai đứa con năng động của mình.

### 

### 

### **Sujay Doshi**
<img src = "media/image3.png">
Sujay là Giám đốc Sản phẩm Cấp cao tại AWS, tập trung vào các dịch vụ bảo mật. Với hơn 10 năm kinh nghiệm trong lĩnh vực quản lý sản phẩm và phát triển phần mềm, anh dẫn dắt chiến lược sản phẩm cho Amazon GuardDuty. Trước khi gia nhập AWS, Sujay từng đảm nhiệm các vị trí lãnh đạo tại nhiều công ty công nghệ khác nhau. Anh đam mê bảo mật đám mây và tự mô tả mình là “một người yêu dữ liệu với sở thích tìm kim trong đống cỏ mạng.”



### **Shachar Hirshberg**
<img src = "media/image2.jpeg">
Shachar từng là Giám đốc Sản phẩm Cấp cao cho Amazon GuardDuty với hơn một thập kỷ kinh nghiệm trong việc xây dựng, thiết kế, ra mắt và mở rộng phần mềm doanh nghiệp. Anh đam mê việc giúp khách hàng khai thác tối đa các dịch vụ AWS để thúc đẩy đổi mới và nâng cao bảo mật cho môi trường đám mây của họ. Ngoài công việc, Shachar là người đam mê du lịch và trượt tuyết.