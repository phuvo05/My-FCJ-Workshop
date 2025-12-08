---
title: "Blog 1"
weight: 1
chapter: false
pre: " <b> 3.1. </b> "
---

# Di chuyển từ AWS CodeDeploy sang Amazon ECS để triển khai xanh/xanh

bởi Mike Rizzo, Islam Mahgoub và Olly Pomeroy vào ngày 16 tháng 9 năm 2025 trong [Amazon Elastic Container Service](https://aws.amazon.com/blogs/containers/category/compute/amazon-elastic-container-service/), [AWS CodeDeploy](https://aws.amazon.com/blogs/containers/category/developer-tools/aws-codedeploy/), [Phương pháp thực hành tốt nhất](https://aws.amazon.com/blogs/containers/category/post-types/best-practices/), [Công cụ dành cho nhà phát triển](https://aws.amazon.com/blogs/containers/category/developer-tools/), [DevOps](https://aws.amazon.com/blogs/containers/category/devops/), [ Chia sẻ](https://aws.amazon.com/blogs/containers/category/post-types/technical-how-to/)  [liên kết cố định](https://aws.amazon.com/blogs/containers/migrating-from-aws-codedeploy-to-amazon-ecs-for-blue-green-deployments/)  [hướng dẫn kỹ thuật](https://aws.amazon.com/vi/blogs/containers/migrating-from-aws-codedeploy-to-amazon-ecs-for-blue-green-deployments/)

Với triển khai màu xanh lam/xanh lá cây, bạn có thể phát hành phần mềm mới bằng cách chuyển lưu lượng truy cập giữa hai môi trường giống hệt nhau đang chạy các phiên bản khác nhau của ứng dụng. Điều này giảm thiểu rủi ro phổ biến liên quan đến việc triển khai các bản phát hành phần mềm mới, bằng cách tạo điều kiện cho việc kiểm tra an toàn các triển khai mới và cung cấp khả năng khôi phục với thời gian ngừng hoạt động gần như bằng không.

Cho đến gần đây, [Amazon Elastic Container Service](https://aws.amazon.com/ecs/) (Amazon ECS) chỉ hỗ trợ các bản cập nhật luân phiên như một chiến lược triển khai gốc và bạn cần sử dụng [AWS CodeDeploy](https://aws.amazon.com/codedeploy/) nếu muốn triển khai các triển khai xanh/xanh. Điều này đã thay đổi với sự ra mắt gần đây của [triển khai ECS xanh/xanh lá cây](https://aws.amazon.com/blogs/aws/accelerate-safe-software-releases-with-new-built-in-blue-green-deployments-in-amazon-ecs/).

Triển khai ECS màu xanh lam/xanh lá cây cung cấp chức năng tương tự như CodeDeploy, nhưng có một số khác biệt về các tính năng có sẵn và cách triển khai chúng. Bài đăng này nhắm mục tiêu đến các tổ chức hiện đang sử dụng CodeDeploy để triển khai xanh/xanh trên Amazon ECS và đang xem xét việc di chuyển sang khả năng Amazon ECS mới. Nó cung cấp hướng dẫn về (1) các yếu tố cần xem xét khi lập kế hoạch di chuyển của bạn, (2) ánh xạ các khái niệm CodeDeploy tương đương trong triển khai ECS xanh/xanh lá cây và (3) chiến lược di chuyển.

**Lập kế hoạch di chuyển**

Khi di chuyển từ CodeDeploy sang triển khai xanh/xanh ECS, bạn nên xem xét các điểm sau đây như một phần của quy trình lập kế hoạch:

·        Khả năng mới: Triển khai ECS xanh/xanh cho phép một số trường hợp sử dụng không được hỗ trợ với CodeDeploy. Chúng bao gồm những điều sau:

o   Tùy chọn khám phá dịch vụ: CodeDeploy chỉ hỗ trợ các dịch vụ do [Elastic Load Balancing](https://aws.amazon.com/elasticloadbalancing/) (ELB) cung cấp, trong khi triển khai ECS xanh/xanh lá cây hỗ trợ cả ELB và [ECS ServiceConnect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html).

o   Hỗ trợ dịch vụ không giao diện: Triển khai ECS xanh/xanh lá cây có thể được sử dụng trong các tình huống không cần tiếp xúc với dịch vụ, ví dụ như dịch vụ xử lý hàng đợi.

o   Hỗ trợ Amazon EBS: Triển khai ECS xanh/xanh hỗ trợ cấu hình  ổ đĩa [Amazon Elastic Block Store (Amazon EBS](https://aws.amazon.com/ebs/)) khi triển khai dịch vụ.

o   Nhiều nhóm mục tiêu: bộ điều khiển triển khai ECS cho phép một dịch vụ được liên kết với nhiều nhóm mục tiêu, có nghĩa là nó có thể được truy cập đồng thời thông qua nhiều cân bằng tải (ví dụ: để tách tiếp xúc với dịch vụ bên trong và bên ngoài).

o   Cấu hình trình nghe ALB linh hoạt: CodeDeploy cần các trình nghe riêng biệt cho các dịch vụ khác nhau cũng như cho các điểm cuối sản xuất và thử nghiệm. ECS màu xanh lam/xanh lá cây hoạt động ở cấp độ quy tắc trình nghe, có nghĩa là bạn có thể hưởng lợi từ việc sử dụng một trình nghe duy nhất với [định tuyến yêu cầu nâng cao](https://aws.amazon.com/blogs/aws/new-advanced-request-routing-for-aws-application-load-balancers/) dựa trên tên máy chủ, tiêu đề HTTP, đường dẫn, phương thức, chuỗi truy vấn hoặc IP nguồn. Ví dụ: bạn có thể sử dụng cổng listener chung cho nhiều dịch vụ bằng cách sử dụng định tuyến dựa trên đường dẫn và hỗ trợ thử nghiệm A/B bằng cách sử dụng định tuyến dựa trên chuỗi truy vấn. Bạn cũng có thể hỗ trợ sản xuất màu xanh lam/xanh lá cây và kiểm tra lưu lượng truy cập trên cùng một cổng trình nghe.

·        Cải tiến hoạt động: Triển khai ECS xanh/xanh lá cây cung cấp (1) sự liên kết tốt hơn với các tính năng hiện có của Amazon ECS (chẳng hạn như bộ ngắt mạch, lịch sử triển khai và móc vòng đời), giúp chuyển đổi giữa các chiến lược triển khai Amazon ECS khác nhau, (2) thời gian thực thi móc vòng đời dài hơn (móc CodeDeploy được giới hạn trong 1 giờ) và (3) [ hỗ trợ AWS CloudFormation](https://aws.amazon.com/cloudformation/) được cải thiện  (không cần các tệp AppSpec riêng biệt để sửa đổi dịch vụ và móc vòng đời).

·        Giới hạn cấu hình triển khai: CodeDeploy hỗ trợ cấu hình triển khai canary, tuyến tính và tất cả cùng một lúc. Khi viết bài này, ECS xanh lam / xanh lá cây chỉ hỗ trợ tất cả cùng một lúc. Nếu đang sử dụng triển khai tuyến tính hoặc canary CodeDeploy, trước tiên bạn cần chuyển sang cấu hình CodeDeploy tất cả cùng một lúc trước khi di chuyển sang triển khai xanh lam/xanh ECS.

·        Sự khác biệt về API / CLI: Có sự khác biệt về API (và các lệnh CLI liên quan) giữa hai cách tiếp cận. Việc ánh xạ từ API này sang API khác thường đơn giản nhưng hãy lưu ý rằng việc triển khai ECS xanh lam/xanh lá cây dựa nhiều hơn vào các móc vòng đời để kiểm soát các bước triển khai. Ví dụ: khi CodeDeploy hỗ trợ tùy chọn thời gian chờ để kiểm tra triển khai mới (trước khi định tuyến lại lưu lượng sản xuất đến nó), bạn cần sử dụng hook để đạt được điều này với triển khai ECS màu xanh lam/xanh lá cây.

·        Sự khác biệt của bảng điều khiển: Nếu bạn đang sử dụng bảng điều khiển CodeDeploy như một phần của hoạt động của mình, thì hãy lưu ý rằng bảng điều khiển Amazon ECS không cung cấp các tùy chọn ghi đè thủ công tiến trình triển khai (ví dụ: buộc định tuyến lại hoặc chấm dứt sớm thời gian nướng). Thay vào đó, bạn có thể tạo giao diện người dùng tùy chỉnh (tích hợp với các quy trình hoạt động rộng hơn) thông qua móc vòng đời Amazon ECS (được cho là cách tiếp cận an toàn hơn).

·        Đường dẫn di chuyển: Có một số tùy chọn có sẵn để di chuyển dịch vụ từ CodeDeploy sang triển khai xanh/xanh ECS và bạn cần xem xét tùy chọn nào phù hợp nhất với môi trường của mình. Các tùy chọn này, cùng với những ưu và nhược điểm liên quan của chúng, sẽ được đề cập chi tiết hơn ở phần sau của bài đăng này.

·        Hỗ trợ quy trình: Hỗ trợ triển khai ECS màu xanh lam/xanh lá cây ban đầu có thể bị hạn chế trong các công cụ quy trình hiện có. Tích hợp quy trình nâng cao hơn có thể yêu cầu sử dụng các hành động tùy chỉnh trong một khoảng thời gian tạm thời. Khi viết bài này, hành động "tiêu chuẩn" của Amazon ECS của CodePipeline có thể được sử dụng để triển khai các thay đổi hình ảnh bộ chứa thông qua triển khai ECS màu xanh lam/xanh lá cây (nhưng không phải các thay đổi cấu hình dịch vụ khác).

**Từ CodeDeploy đến triển khai ECS xanh/xanh lá cây**

Khi ước tính chi phí triển khai để di chuyển sang triển khai ECS màu xanh lam/xanh lá cây, bạn phải hiểu sự khác biệt của API và cách bạn có thể ánh xạ các tính năng CodeDeploy với các tính năng triển khai màu xanh lam/xanh lá cây tương đương của ECS. Giả sử bạn đang bắt đầu từ cấu hình "tất cả cùng một lúc" của CodeDeploy, phần này sẽ hướng dẫn bạn qua những điểm khác biệt chính.

**Cấu hình cân bằng tải và tạo dịch vụ**

Khi tạo dịch vụ Amazon ECS bằng CodeDeploy, trước tiên bạn tạo cân bằng tải với trình nghe sản xuất và (tùy chọn) trình nghe thử nghiệm. Mỗi trình nghe được cấu hình với một quy tắc (mặc định) duy nhất định tuyến tất cả lưu lượng truy cập đến một nhóm mục tiêu duy nhất (nhóm mục tiêu chính) như trong Hình 1 (a). Sau đó, bạn tạo một dịch vụ Amazon ECS được định cấu hình để sử dụng trình nghe và nhóm đích, với  loại deploymentController được đặt thành CODE\_DEPLOY. Việc tạo dịch vụ dẫn đến việc tạo ra một TaskSet (màu xanh lam) được đăng ký với nhóm mục tiêu được chỉ định.

<img src="/images/3-BlogsTranslated/3.1-Blog1/image1.png" style="width:6.26772in;height:2.66667in" alt="Figure 1: Application Load Balancer initial configuration" />

*Hình 1: Cấu hình ban đầu của cân bằng tải*

Với dịch vụ được tạo, bạn tạo một nhóm triển khai CodeDeploy (như một phần của ứng dụng CodeDeploy) và định cấu hình nhóm đó với các chi tiết về cụm ECS, tên dịch vụ, trình nghe cân bằng tải, hai nhóm mục tiêu (nhóm mục tiêu chính được sử dụng trong quy tắc trình nghe sản xuất và nhóm mục tiêu phụ được sử dụng cho các tác vụ thay thế),  vai trò dịch vụ [AWS Identity and Access Management (IAM)](https://aws.amazon.com/iam/)  [để cấp quyền CodeDeploy thao tác tài nguyên Amazon ECS và ELB](https://docs.aws.amazon.com/codedeploy/latest/userguide/getting-started-create-service-role.html)và các tham số khác nhau kiểm soát hành vi triển khai.

Triển khai ECS xanh/xanh chỉ định cấu hình triển khai trong chính dịch vụ Amazon ECS. Trình nghe sản xuất cân bằng tải phải được định cấu hình trước với quy tắc bao gồm hai nhóm mục tiêu có trọng số lần lượt là 1 và 0\. Là một phần của quá trình tạo dịch vụ, bạn chỉ định [Tên tài nguyên Amazon (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html) của quy tắc trình nghe này, hai nhóm đích, [vai trò IAM (để cấp quyền Amazon ECS thao tác với nhóm nghe và nhóm đích),](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AmazonECSInfrastructureRolePolicyForLoadBalancers.html)  loại deploymentController được đặt thành ECS và deploymentConfiguration.strategy được đặt thành BLUE\_GREEN. Điều này tạo ra một ServiceRevision (màu xanh lam)  với các nhiệm vụ được đăng ký với nhóm mục tiêu chính.

Mặc dù cả hai cách tiếp cận đều dẫn đến việc tạo ra một tập hợp tác vụ ban đầu, nhưng cách triển khai cơ bản khác nhau ở chỗ CodeDeploy sử dụng[Bộ nhiệm vụ](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_TaskSet.html), trong khi Amazon ECS sử dụng[Sửa đổi dịch vụ](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ServiceRevision.html). Sau này được giới thiệu như một phần của[API triển khai dịch vụ Amazon ECS](https://aws.amazon.com/blogs/containers/improving-deployment-visibility-for-amazon-ecs-services/), cung cấp khả năng hiển thị tốt hơn về quy trình triển khai và lịch sử triển khai dịch vụ.

**Triển khai bản sửa đổi dịch vụ**

Hình 2 cho thấy cách triển khai một bản sửa đổi dịch vụ mới. CodeDeploy triển khai phiên bản mới của dịch vụ bằng cách sử dụng CreateDeployment(), chỉ định tên ứng dụng CodeDeploy, tên nhóm triển khai và chi tiết sửa đổi trong tệp AppSpec. Điều này phải chứa định nghĩa tác vụ cho phiên bản mới, tên vùng chứa và cổng để sử dụng. Triển khai ECS màu xanh lam/xanh lá cây tạo triển khai dịch vụ mới bằng cách gọi UpdateService(), chuyển thông tin chi tiết về định nghĩa tác vụ thay thế.

![Hình 2: Triển khai bản sửa đổi dịch vụ](/images/3-BlogsTranslated/3.1-Blog1/image2.png)

*Hình 2: Triển khai bản sửa đổi dịch vụ*

Theo tùy chọn, tệp CodeDeploy AppSpec cũng có thể được sử dụng để chỉ định các thay đổi cấu hình dịch vụ khác, chẳng hạn như cấu hình mạng và chiến lược nhà cung cấp dung lượng, đồng thời để chỉ định các móc vòng đời (xem phần sau). Khi sử dụng Amazon ECS, bạn chỉ định những thay đổi này bằng cách sử dụng UpdateService().

![Hình 3: Định tuyến lại lưu lượng truy cập](/images/3-BlogsTranslated/3.1-Blog1/image3.png)

*Hình 3: Định tuyến lại lưu lượng truy cập*

Hình 3 cho thấy sự khác biệt trong cách đạt được định tuyến lại giao thông. Trong CodeDeploy, việc triển khai tạo một TaskSet thay thế (màu xanh lá cây) và đăng ký các tác vụ của nó với nhóm mục tiêu phụ. Khi điều này trở nên lành mạnh, nó có sẵn để thử nghiệm (tùy chọn) và sản xuất. Trong cả hai trường hợp, việc định tuyến lại đạt được bằng cách thay đổi quy tắc listener tương ứng để trỏ vào nhóm mục tiêu phụ được liên kết với TaskSet màu xanh lá cây. Khôi phục đạt được bằng cách thay đổi quy tắc trình nghe sản xuất trở lại nhóm mục tiêu chính.

Ngược lại, với triển khai ECS xanh/xanh lá cây, việc triển khai dịch vụ tạo ra một ServiceRevision mới  với các tác vụ (màu xanh lá cây) và đăng ký chúng với nhóm mục tiêu phụ. Sau đó, định tuyến lại và khôi phục đạt được bằng cách chuyển đổi trọng số trên quy tắc listener.

**Móc vòng đời**

Cả triển khai CodeDeploy và ECS xanh/xanh đều hỗ trợ hook vòng đời (tùy chọn), trong đó  các hàm [AWS Lambda](https://aws.amazon.com/lambda/) có thể được kích hoạt bởi các sự kiện vòng đời cụ thể. Hook rất hữu ích để tăng cường quy trình triển khai với logic tùy chỉnh. Ví dụ: bạn có thể sử dụng móc vòng đời để tự động kiểm tra trên cổng thử nghiệm, trước khi tiến hành định tuyến lại lưu lượng truy cập trực tiếp đến cổng sản xuất.

Triển khai CodeDeploy và ECS xanh lam/xanh lục thường tuân theo các vòng đời tương tự nhau, nhưng có sự khác biệt về cách chỉ định các tùy chọn cấu hình và móc vòng đời:

·        CodeDeploy chỉ định các móc vòng đời như một phần của tệp AppSpec được cung cấp cho CreateDeployment(). Điều này có nghĩa là các hook cần được cấu hình cho mọi triển khai. Triển khai ECS màu xanh lam/xanh lá cây chỉ định các hook (cùng với [vai trò IAM cấp quyền cho Amazon ECS để gọi các hàm Lambda được liên kết](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/blue-green-permissions.html)) như một phần của cấu hình dịch vụ và mọi thay đổi sẽ cần lệnh  gọi UpdateService().

·        Các sự kiện vòng đời CodeDeploy và Amazon ECS tương đương nhau, nhưng chúng có tên khác nhau, như được hiển thị trong bảng dưới đây:

| Sự kiện vòng đời | Triển khai mã | ECS xanh lam / xanh lá cây |
| :---- | :---- | :---- |
| Trước khi tạo nhiệm vụ mới | Trước khi cài đặt | PRE\_SCALE\_UP |
| Nhiệm vụ mới đã sẵn sàng | Sau khi cài đặt | POST\_SCALE\_UP |
| Trước khi cổng kiểm tra được bật | Không tương đương | TEST\_TRAFFIC\_SHIFT |
| Cổng kiểm tra đã sẵn sàng nhận lưu lượng truy cập | SauAllowTestTraffic | POST\_TEST\_TRAFFIC\_SHIFT |
| Trước khi định tuyến lại lưu lượng truy cập sản phẩm sang màu xanh lá cây | TrướcCho phép lưu lượng truy cập | PRODUCTION\_TRAFFIC\_SHIFT |
| Đã hoàn tất việc định tuyến lại lưu lượng sản phẩm sang màu xanh lá cây | AfterAllowLưu lượng truy cập | POST\_PRODUCTION\_TRAFFIC\_SHIFT |

·        Cả triển khai CodeDeploy và ECS xanh/xanh lá cây đều sử dụng Lambda để triển khai hook, nhưng đầu vào và đầu ra dự kiến khác nhau, đặc biệt là cách hàm Lambda trả về phản hồi trạng thái hook. Trong CodeDeploy, hàm phải gọi PutLifecycleEventHookExecutionStatus() để trả về trạng thái thực thi hook, có thể là Thành công hoặc Không thành công. Trong Amazon ECS, bản thân phản hồi Lambda được sử dụng để cho biết trạng thái thực thi hook.

·        CodeDeploy gọi mỗi hook dưới dạng lệnh gọi một lần và mong đợi trạng thái thực thi cuối cùng sẽ được trả về trong vòng một giờ. Hook Amazon ECS linh hoạt hơn ở chỗ chúng có thể trả về một  chỉ báo IN\_PROGRESS, báo hiệu rằng hook nên được gọi lại nhiều lần cho đến khi kết quả là THÀNH CÔNG hoặc THẤT BẠI. Hook được gọi sau mỗi 30 giây theo mặc định, nhưng thời gian của lệnh gọi tiếp theo có thể được định cấu hình bằng cách truyền một tham số trong phản hồi.

**Các cân nhắc triển khai khác**

CodeDeploy cung cấp một số [tùy chọn nâng cao cho các nhóm triển khai](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-groups-configure-advanced-options.html), bạn có thể cần ánh xạ đến các tùy chọn tương đương của Amazon ECS. Chúng bao gồm những điều sau:

·        [ Trình kích hoạt](https://aws.amazon.com/sns/) Amazon Simple Notification Service (Amazon SNS): [sử dụng các sự kiện Amazon EventBridge](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_cwe_events.html) từ Amazon ECS để phát hành các thay đổi trạng thái đối với chủ đề SNS.

·        [Phát hiện cảnh báo Amazon CloudWatch](https://aws.amazon.com/cloudwatch/) và tự động khôi phục: sử dụng [ các tính năng](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-failure-detection.html) phát hiện lỗi triển khai Amazon ECS.

**Đường dẫn di chuyển**

Sau khi xem xét sự khác biệt triển khai giữa triển khai CodeDeploy và ECS xanh/xanh, bạn cũng cần xác định phương pháp di chuyển phù hợp. Có một số tùy chọn có sẵn và bạn phải đánh giá tùy chọn nào phù hợp nhất với kiến trúc và yêu cầu của bạn. Các yếu tố liên quan bao gồm:

·        Thời gian ngừng hoạt động: Có bất kỳ thời gian ngừng hoạt động nào không, và nếu có trong bao lâu?

·        Khôi phục sang CodeDeploy: Bạn có cần giữ lại khả năng quay lại quá trình di chuyển nếu việc chuyển sang triển khai ECS màu xanh lam/xanh lá cây gặp trục trặc không? Bạn có thể coi đây là một "chiến lược xanh lam / xanh lá cây cho giải pháp xanh lam / xanh lá cây\!"

·        Khám phá dịch vụ: Bạn có thể thay đổi địa chỉ dịch vụ (URI ALB mới) hay bạn cần giữ nguyên địa chỉ?

·        Hiệu suất và/hoặc tốc độ triển khai

·        Chi phí

Nếu bạn dự định tiếp tục cung cấp dịch vụ của mình bằng cách sử dụng cân bằng tải, các tùy chọn di chuyển sau đây thể hiện các biến thể về mức độ sử dụng lại tài nguyên hiện có, xem xét cả bản thân dịch vụ Amazon ECS và tài nguyên cân bằng tải. Trong mọi trường hợp, bạn phải tạo [vai trò IAM](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AmazonECSInfrastructureRolePolicyForLoadBalancers.html) để chuyển đến bộ điều khiển triển khai Amazon ECS, cho phép bộ điều khiển này thao tác với các tài nguyên cân bằng tải cần thiết.

**Tùy chọn 1: Cập nhật tại chỗ**

Trong cách tiếp cận này, bạn cập nhật dịch vụ Amazon ECS hiện có để sử dụng bộ điều khiển triển khai Amazon ECS với chiến lược triển khai màu xanh lam/xanh lá cây thay vì bộ điều khiển triển khai CodeDeploy. Bạn sử dụng lại cùng một trình nghe cân bằng tải và các nhóm mục tiêu được sử dụng cho CodeDeploy. Như đã đề cập trước đây, CodeDeploy định cấu hình trình nghe của cân bằng tải được đính kèm với dịch vụ bằng một quy tắc (mặc định) duy nhất định tuyến tất cả lưu lượng truy cập đến một nhóm mục tiêu duy nhất (nhóm mục tiêu chính). Đối với triển khai ECS màu xanh lam/xanh lá cây, trình nghe cân bằng tải phải được định cấu hình trước với quy tắc bao gồm hai nhóm mục tiêu có trọng số là 1 và 0\. Theo đó, cần thực hiện các bước sau:

1\. 	Thay đổi quy tắc mặc định của trình nghe sản xuất/thử nghiệm để bao gồm nhóm mục tiêu thay thế và đặt trọng số của nhóm mục tiêu và nhóm mục tiêu thay thế lần lượt là 1 và 0\.

2\. 	Cập nhật dịch vụ Amazon ECS hiện có bằng cách gọi UpdateService(), đặt tham số deploymentController thành ECS và tham số deploymentStrategy thành BLUE/GREEN. Bạn chuyển ARN của vai trò IAM, nhóm đích, nhóm mục tiêu thay thế, quy tắc trình nghe sản xuất và quy tắc trình nghe thử nghiệm (không bắt buộc).

3\. 	Bộ điều khiển triển khai Amazon ECS tạo một bản sửa đổi dịch vụ mới với các tác vụ mới trong nhóm mục tiêu thay thế, sau đó ngay lập tức định tuyến lại lưu lượng truy cập đến nhóm mục tiêu này. Chờ cho quá trình hoàn tất, sau đó xác minh rằng dịch vụ đang hoạt động như mong đợi.

4\. 	Xóa tài nguyên CodeDeploy cho dịch vụ Amazon ECS này vì bạn hiện đang sử dụng triển khai ECS màu xanh lam/xanh lá cây.

Cập nhật tại chỗ là một hoạt động an toàn, nhưng bạn nên cẩn thận để (1) tự động hóa quy trình (đặc biệt là khi thay đổi cấu hình trình nghe) để giảm thiểu khả năng xảy ra lỗi thủ công và (2) kiểm tra quy trình này kỹ lưỡng trong môi trường nhà phát triển và/hoặc UAT. Bạn cũng cần lưu ý rằng lưu lượng truy cập sẽ được định tuyến lại ngay lập tức sau khi bộ điều khiển Amazon ECS hoàn tất việc tạo bản sửa đổi dịch vụ ban đầu. Hơn nữa, không có tùy chọn để kiểm tra bản sửa đổi này trước khi định tuyến lại (mặc dù các tác vụ phải giống với các tác vụ đang chạy trong bộ tác vụ CodeDeploy).

**Tùy chọn 2: Dịch vụ mới và cân bằng tải hiện có**

Cách tiếp cận này sử dụng chiến lược xanh lam / xanh lá cây cho việc di chuyển (nói cách khác, di chuyển màu xanh lam / xanh lá cây của giải pháp xanh lam / xanh lá cây). Bạn tạo một thiết lập song song màu xanh lam/xanh lục mới bằng cách sử dụng triển khai ECS màu xanh lam/xanh lá cây, xác minh, chuyển từ thiết lập CodeDeploy sang thiết lập triển khai ECS xanh/xanh lục mới, sau đó xóa tài nguyên CodeDeploy.

1\. 	Giữ nguyên trình nghe, nhóm mục tiêu và dịch vụ Amazon ECS cho thiết lập CodeDeploy để bạn có thể quay lại thiết lập này nếu cần.

2\. 	Tạo các nhóm mục tiêu mới và trình nghe mới (với các cổng khác với trình nghe ban đầu) trong cân bằng tải hiện có. Sau đó, tạo một dịch vụ Amazon ECS mới khớp với dịch vụ Amazon ECS hiện có, ngoại trừ việc bạn sử dụng ECS làm bộ điều khiển triển khai BLUE\_GREEN  làm chiến lược triển khai và chuyển ARN cho vai trò IAM, nhóm mục tiêu mới và quy tắc trình nghe mới.

3\. 	Xác minh thiết lập mới (sử dụng các cổng của trình nghe mới). Nếu mọi thứ suôn sẻ, hãy thay đổi các cổng của trình nghe ban đầu thành các số cổng khác nhau (để giải phóng các cổng ban đầu) và chuyển các cổng trên trình nghe mới sang các cổng gốc, do đó định tuyến lưu lượng truy cập đến thiết lập mới.

4\. 	Quan sát thiết lập mới và nếu mọi thứ tiếp tục hoạt động như mong đợi, bạn có thể xóa thiết lập CodeDeploy.

Hình 4 mô tả cách tiếp cận này.

![Hình 4: Phương án 2 – Dịch vụi mới và cân bằng tải hiện có](/images/3-BlogsTranslated/3.1-Blog1/image4.png)

*Hình 4: Phương án 2 – Dịch vụ mới và cân bằng tải hiện có*

**Tùy chọn 3: Dịch vụ mới và cân bằng tải mới**

Giống như cách tiếp cận trước, cách tiếp cận này sử dụng chiến lược xanh lam / xanh lá cây cho việc di chuyển. Sự khác biệt chính là việc chuyển từ thiết lập CodeDeploy sang thiết lập triển khai màu xanh lam/xanh lá cây ECS xảy ra ở một lớp định tuyến khác phía trên cân bằng tải (như trong Hình 5). Các triển khai có thể cho lớp này bao gồm [Amazon Route 53](https://aws.amazon.com/route53/), [Amazon API Gateway](https://aws.amazon.com/api-gateway/) và [Amazon CloudFront](https://aws.amazon.com/cloudfront/).

Cách tiếp cận này phù hợp với người dùng đã có lớp định tuyến này và nếu tất cả giao tiếp với dịch vụ Amazon ECS đang diễn ra thông qua nó (nói cách khác là không có giao tiếp trực tiếp ở cấp cân bằng tải). Khi so sánh với Tùy chọn 2, tùy chọn này có lợi ích là không có thời gian chết nhưng đắt hơn một chút.

![Hình 5: Tùy chọn 3 – Dịch vụ mới và cân bằng tải mới](/images/3-BlogsTranslated/3.1-Blog1/image5.png)

*Hình 5: Tùy chọn 3 – Dịch vụ mới và cân bằng tải mới*

**Sự so sánh**

Bảng dưới đây so sánh ba phương pháp di chuyển này trên một số yếu tố có thể có mức độ quan trọng khác nhau đối với bạn. Bạn có thể sử dụng bảng này để đánh giá tùy chọn nào phù hợp nhất với hoàn cảnh và ưu tiên cụ thể của riêng bạn.

|  | Tùy chọn 1: Cập nhật tại chỗ | Tùy chọn 2: Dịch vụ mới và cân bằng tải hiện có | Tùy chọn 3: Dịch vụ mới và cân bằng tải mới |
| :---- | ----- | ----- | ----- |
| Độ phức tạp của quá trình di chuyển | Cập nhật đơn giản : Chiến lược triển khai và bộ điều khiển triển khai dịch vụ Amazon ECS hiện có | Phức tạp hơnTạo dịch vụ Amazon ECS mới, nhóm mục tiêu và trình nghe cũng như hoán đổi cổng | Phức tạp hơnTạo dịch vụ Amazon ECS mới, nhóm đích, cân bằng tải và trình nghe cũng như thay đổi cấu hình lớp định tuyến |
| Các lựa chọn giảm thiểu rủi ro | Trung bìnhKhông có thiết lập song song màu xanh lam / xanh lá cây để thử nghiệm. Tập trung vào tự động hóa quy trình và kiểm tra | Thiết lập xanh lam / xanh lá cây StrongParallel, hãy kiểm tra thiết lập mới trước khi định tuyến lại lưu lượng truy cập | Thiết lập xanh lam / xanh lá cây StrongParallel, hãy kiểm tra thiết lập mới trước khi định tuyến lại lưu lượng truy cập |
| Khôi phục bộ điều khiển triển khai | Đơn giảnThay đổi bộ điều khiển triển khai dịch vụ trở lại CODE\_DEPLOY | SimpleĐảo ngược hoán đổi cổng | SimpleRollback các thay đổi cấu hình lớp định tuyến |
| Downtime | Không có thời gian ngừng hoạt động | Giảm thiểu gián đoạn trong quá trình hoán đổi cổng | Không có thời gian ngừng hoạt động |
| Ứng dụng | Không có ràng buộc | Không có ràng buộc | Yêu cầu lớp định tuyến bổ sung |
| Chi phí | Không phát sinh thêm chi phí | Chi phí bổ sungHai dịch vụ Amazon ECS cùng tồn tại với các tác vụ liên quan | Chi phí bổ sungHai dịch vụ Amazon ECS cùng tồn tại với các tác vụ liên quan và cân bằng tải bổ sung |

**Kết thúc**

Trong bài đăng này, chúng tôi đã thảo luận về việc di chuyển từ AWS CodeDeploy sang Amazon ECS để triển khai xanh/xanh. Cuộc thảo luận này bao gồm những nội dung sau:

·        Các yếu tố cần xem xét trước khi quyết định di chuyển,

·        sự khác biệt chính về kiến trúc và các cân nhắc triển khai liên quan,

·        Ba cách khác nhau để tiếp cận di cư.

Nếu bạn hiện đang sử dụng CodeDeploy và đang cân nhắc chuyển sang triển khai ECS xanh/xanh lá cây, thì bạn có thể sử dụng bài đăng này làm hướng dẫn để đánh giá tính khả thi và lập kế hoạch di chuyển của mình. Để biết thêm thông tin về triển khai ECS xanh/xanh, hãy xem hướng [dẫn dành cho nhà phát triển Amazon ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-blue-green.html).

# **About the authors**

### 

### 

### 

### 

### Mike Rizzo
![Mike Rizzo](/images/3-BlogsTranslated/3.1-Blog1/author1.png)

**Mike Rizzo** là Kiến trúc sư Giải pháp Chính (Principal Solutions Architect) trong nhóm Dịch vụ Tài chính tại AWS Vương quốc Anh. Anh đặc biệt quan tâm đến việc hiện đại hóa ứng dụng, đặc biệt là sử dụng container, serverless và trí tuệ nhân tạo để hỗ trợ triển khai trên nền tảng đám mây. Trong thời gian rảnh, bạn sẽ thấy anh chạy bộ và đạp xe quanh vùng nông thôn Suffolk, nấu món ăn Malta, và chơi Fortnite!

### Islam Mahgoub
![Islam Mahgoub](/images/3-BlogsTranslated/3.1-Blog1/author2.jpeg)

**Islam Mahgoub** là Kiến trúc sư Giải pháp Cấp cao (Senior Solutions Architect) tại AWS với hơn 15 năm kinh nghiệm trong lĩnh vực kiến trúc ứng dụng, tích hợp và công nghệ. Tại AWS, anh giúp khách hàng xây dựng các giải pháp tập trung vào đám mây mới và hiện đại hóa các ứng dụng kế thừa bằng cách sử dụng các dịch vụ AWS. Ngoài công việc, Islam thích đi bộ, xem phim và nghe nhạc.
### Olly Pomeroy
![Olly Pomeroy](/images/3-BlogsTranslated/3.1-Blog1/author3.jpeg)

**Olly Pomeroy** là Kiến trúc sư Giải pháp Chuyên gia về Container Cấp cao (Senior Container Specialist Solution Architect) tại AWS.
