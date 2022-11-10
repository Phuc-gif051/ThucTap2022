## Nội dung chính

[1. Tổng quan về Database](#1)

- [Database là gì?](#1.1)
- [Thành phần chính của Database là gì?](#1.2)
- [Các dạng Database phổ biến](#1.3)
- [Tại sao phải sử dụng Database?](#1.4)

[2. Hai loại hình cơ sở dữ liệu phổ biến nhất hiện nay](#2)

- [2.1 Cơ sở dữ liệu quan hệ (SQL - Structured Query Language)](#2.1)
- [2.2 Cơ sở dữ liệu phi quan hệ (NoSQL - Non-Relationla SQL)](#2.2)
- [2.3 So sánh sự khác nhau giữa SQL và NoSQL](#2.3)


[Tài liệu tham khảo](#0)
___


## <a name="1" >1. Tổng quan về Database</a>

### <a name="1.1" >Database là gì?</a>

Database là một tập hợp dữ liệu có hệ thống hay còn được gọi là cơ sở dữ liệu. Database được hình dung như một kho sách ngăn nắp có chia đề mục và phân loại rõ ràng. Chỉ khác là Database hoạt động trên nền tảng điện tử có phần trừu tượng hơn. Tuy nhiên nó cũng sở hữu đủ các tính năng như quản lý, điều phối, trích xuất, tìm kiếm hay chỉnh sửa… dữ liệu.

Database có thể được lưu trữ trên các phần mềm online, offline dưới dạng một tệp tin hoặc một hệ thống dữ liệu. Database cũng thường được lưu trên các thiết bị có chức năng ghi nhớ như ổ cứng, thẻ nhớ, USB…

### <a name="1.2" >Thành phần chính của Database là gì?</a>

Thành phần của các Database khác nhau sẽ không giống nhau. Bởi nó không có một nguyên mẫu cố định nào cả, tất cả phụ thuộc vào cách xây dựng của người dùng. Tuy nhiên một Database lý tưởng sẽ có cấu tạo từ 5 thành phần: phần cứng, phần mềm, dữ liệu, quy trình và ngôn ngữ truy cập.

**Phần cứng**

Phần cứng được hiểu như các thiết bị vật lý giúp kết nối người dùng và hệ thống dữ liệu. Phần cứng thường là máy tính, điện thoại di động, các thiết bị I/O hay USB, thẻ nhớ… Ví dụ, nếu cơ sở dữ liệu của bạn nằm trên máy tính cá nhân thì máy tính này sẽ là phần cứng. Vẫn là cơ sở dữ liệu đó nhưng bạn lại tải về và bật nó trên điện thoại thì phần cứng sẽ là điện thoại.

**Phần mềm**

Ngược lại với phần cứng, phần mềm là các chương trình trừu tượng không thể có tiếp xúc vật lý với người dùng. Phần mềm được dùng để quản lý và điều khiển các Database. Có rất nhiều loại phần mềm khác nhau, có thể là phần mềm điều hành, phần mềm chia sẻ dữ liệu giữa nhiều người dùng khác nhau hoặc bản thân Database cũng được hiểu như một dạng phần mềm.

**Dữ liệu**

Dữ liệu còn được gọi là Data theo ngôn ngữ công nghệ. Các dữ liệu này đến từ nhiều nguồn khác nhau, được lưu trữ bằng nhiều cách khác nhau. Dữ liệu cũng có thể tồn tại dưới rất nhiều hình thức, ví dụ như hình ảnh, âm thanh, văn bản… và thậm chí là hệ ngôn ngữ nhị phân. Tuy nhiên Data vẫn chưa thể được sử dụng ngay lập tức, nó vẫn tồn tại dưới dạng “nguyên liệu thô” và đang chờ để được Database xử lý.

**Quy trình**

Một Database có thể được sử dụng bởi nhiều người dùng khác nhau, nhất là trong một team phát triển sản phẩm. Vì thế thật bất tiện nếu những thành viên trong nhóm cứ phải liên tục hỏi nhau về cách thao tác trong Database phải không nào? Để giải quyết vấn đề này, người tạo Database sẽ soạn một hướng dẫn chi tiết về cách mà Database vận hành cũng như cách sử dụng nó. Thường thì quy trình này sẽ được tài liệu hóa để người đọc có thể dễ hiểu hơn.

**Ngôn ngữ truy cập**

Ngôn ngữ truy cập được dùng để tham gia vào một Database. Nó cho phép người dùng truy cập vào dữ liệu cũ, cập nhật dữ liệu mới hoặc trích xuất và thực hiện nhiều thao tác khác trong Database. Ngôn ngữ truy cập thường sẽ được quy định bởi người khởi tạo ra Database. Nếu người dùng không biết cách sử dụng ngôn ngữ có sẵn của Database thì có thể dùng các trình biên dịch.

### <a name="1.3" >Các dạng Database phổ biến</a>

- Relational Database: Còn được gọi là cơ sở dữ liệu quan hệ, loại Database này được dùng phổ biến nhất.
- Object-oriented Databases: Cơ sở dữ liệu định hướng đối tượng được dùng để phân chia dữ liệu theo các thuộc tính, phục vụ cho quá trình tìm kiếm và trích xuất nhanh chóng hơn.
- Distributed Database: Cơ sở dữ liệu phân tán là để chỉ loại Database được xây dựng từ nhiều máy tính cục bộ khác nhau. Với loại Database này, dữ liệu không chỉ ở cố định một chỗ mà được phân tán khắp mọi nơi.
- Hierarchical: Giống như tên gọi của nó, cơ sở dữ liệu phân cấp dùng cách sơ đồ dạng phả hệ để thể hiện thông tin.
- Open-source Database: Cơ sở dữ liệu nguồn mở được dùng để lưu trữ các thông tin đối ngoại như Marketing, dịch vụ khách hàng, tuyển nhân sự…
- Cloud Database: Cơ sở dữ liệu đám mây cho phép dữ liệu được lưu trữ và thao tác trên hệ thống trực tuyến với độ bảo mật cao và tốn ít tài nguyên.
- Data Warehouse: Kho lưu trữ dữ liệu là nơi lưu lại lịch sử về thay đổi của Database. Nó giúp đơn giản hóa quy trình báo cáo tại các doanh nghiệp.
- Graph Database: Còn được gọi là cơ sở dữ liệu đồ thị. Như tên gọi, nó dùng đồ thị để phân tích các dữ liệu, những mối quan hệ…
- .v.v.

### <a name="1.4" >Tại sao phải sử dụng Database?</a>

**Lưu trữ khối lượng thông tin lớn**

Đối với các doanh nghiệp và tập đoàn lớn, khối lượng thông tin cần lưu trữ là không thể đếm hết. Việc lưu trữ nếu không biết cách thực hiện sẽ gây ra hao tốn tài nguyên và chi phí. Database sẽ giúp người dùng loại bỏ những dữ liệu không cần thiết, sắp xếp các thông tin quan trọng một cách có hệ thống. Như thế vừa tiết kiệm diện tích lưu trữ lại vừa rút ngắn thời gian thực hiện các thao tác chỉnh sửa và trích xuất dữ liệu.

**Chia sẻ thông tin**

Không chỉ được dùng để lưu trữ, Database còn được sử dụng trong cách hoạt động chia sẻ dữ liệu. Ví dụ như với loại cơ sở dữ liệu phân tán, nhiều máy tính cục bộ khác nhau đều có quyền cập nhật và thao tác với dữ liệu như nhau. Database lúc này đóng vai trò như một thư viện chung để nhiều thành viên vào tìm kiếm thông tin.

**Hạn chế trùng lặp**

Database có cơ chế tự động tìm kiếm ra những dữ liệu bị trùng lặp. Điều này giúp kho dữ liệu của doanh nghiệp trở nên ngăn nắp và gọn gàng hơn, không có những dữ liệu thừa chiếm chỗ. Như vậy sẽ cắt giảm được rất nhiều chi phí cho việc vận hành cơ sở dữ liệu.

## <a name="2" >2. Hai loại hình cơ sở dữ liệu phổ biến nhất hiện nay</a>

### <a name="2.1" >2.1 Cơ sở dữ liệu quan hệ (SQL - Structured Query Language)</a>

- Hệ quản trị cơ sở dữ liệu quan hệ (Relational Database Management System - RDBMS) ra đời vào những năm 70 của thế kỉ trước, cho phép các ứng dụng lưu trữ dữ liệu thông qua ngôn ngữ truy vấn và mô hình hóa dữ liệu tiêu chuẩn (Structured Query Language - SQL). Trong RDBMS, dữ liệu được lưu vào nhiều bảng. Mỗi bảng sẽ có nhiều cột, nhiều hàng. Ta sử dụng SQL để truy vấn như sau:

```sh
SELECT Field_name
FROM Table_name
WHERE Condition
```

Một số ứng dụng RDBMS: MySQL, Microsoft SQL Server, Oracle,… được sử dụng rất rộng rãi, vì:

- Tính ACID (Atomicity, Consistency, Isolation, Durability) của một transaction được đảm bảo.
- Hỗ trợ nhiều nền tảng khác nhau
- Số lượng lập trình viên sử dụng và hỗ trợ phát triển rất lớn.
- ...

Tuy nhiên, bên cạnh những ưu điểm thì RDBMS vẫn còn một số khuyết điểm:

- Không xử lí tốt các dữ liệu phi cấu trúc.
- Tốc độ xử lí dữ liệu khá chậm do phải join nhiều bảng để lấy dữ liệu.
- Việc thay đổi cơ sở dữ liệu cũng khá khó vì tính quy củ chặt chẽ của nó.
- RDBMS được thiết kế để chạy trên một máy chủ. Khi muốn mở rộng, nó khó chạy trên nhiều máy (clustering).

VD: như các quyển danh bạ điện thoại, menu thực đơn trong nhà hàng,...

Và như vậy, NoSQL đã ra đời để phục vụ những yêu cầu phù hợp với hiện tại. Hệ thống NoSQL lưu trữ và quản trị dữ liệu sao cho có thể hỗ trợ được tốc độ vận hành ở công suất cao và cung cấp tính linh hoạt tuyệt vời cho các nhà phát triển sử dụng. Không giống với cơ sở dữ liệu SQL, rất nhiều cơ sở dữ liệu NoSQL có thể mở rộng theo chiều ngang trên hàng trăm hoặc hàng ngàn máy chủ.

### <a name="2.2" >2.2 Cơ sở dữ liệu phi quan hệ (NoSQL - Non-Relationla SQL)</a>

NoSQL (viết tắt của Non-Relationla SQL) được sử dụng với mục đích gần giống với SQL. Nhưng nó là đối với cơ sở dữ liệu không quan hệ, không yêu cầu một lược đồ cố định, không tuân theo bất kỳ mô hình quan hệ nào và dễ dàng mở rộng. Cơ sở dữ liệu NoSQL được sử dụng cho các kho dữ liệu phân tán với nhu cầu lưu trữ dữ liệu khổng lồ. NoSQL được sử dụng cho Big Data và các ứng dụng web thời gian thực (google, facebook, youtube,...)

Một hệ thống cơ sở dữ liệu NoSQL bao gồm một loạt các công nghệ cơ sở dữ liệu có thể lưu trữ dữ liệu có cấu trúc, bán cấu trúc, không có cấu trúc và đa hình.

Các đặc điểm của NoSQL

- Phi quan hệ: không có ràng buộc nào cho việc nhất quán dữ liệu.
- Mô hình lưu trữ phân tán các tập tin hoặc dữ liệu ra nhiều máy khác nhau trong mạng LAN hoặc Internet dưới sự kiểm soát của phần mềm.
- NoSQL lưu trữ dữ liệu của mình theo dạng cặp giá trị “key – value”. Sử dụng số lượng lớn các node để lưu trữ thông tin.
- Tính nhất quán không theo thời gian thực: Sau mỗi thay đổi CSDL, không cần tác động ngay đến tất cả các CSDL liên quan mà được lan truyền theo thời gian.
- Mô hình dữ liệu và truy vấn linh hoạt.
- Triển khai đơn giản, dễ nâng cấp và mở rộng.

VD: các file video, hình ảnh, tệp pdf, tệp word,...Tuy có định dạng của các file nhưng dữ liệu bên trong rất khó để định dạng, không có 1 khuôn mẫu nhất định,...

Nói tóm lại, SQL và NoSQL có những sự đánh đổi khác nhau trong hệ thống của mình. Mặc dù cả hai có thể cạnh tranh trong bối cảnh của một dự án, nhưng khi đặt trong một bức tranh tổng thể thì lại có vai trò hỗ trợ, bổ sung cho nhau. Việc quyết định lựa chọn công cụ nào cần phụ thuộc vào tính chất công việc thực tế.

### <a name="2.3" >2.3 So sánh sự khác nhau giữa SQL và NoSQL</a>

- Loại hình:

  - SQL databases là cơ sở dữ liệu dựa trên bảng và các bảng này có quan hệ với nhau. Chẳng hạn thông tin books trong bảng được đặt tên books. Mỗi một row (hàng) ứng với một record (bản ghi), mỗi column (cột) ứng với mỗi field (trường) dữ liệu.
  - NoSQL databases là cơ sở dữ liệu có thể dựa trên các cặp tài liệu, các cặp khóa - giá trị (từng cặp một), cơ sở dữ liệu biểu đồ...

- Ngôn ngữ Query:

  - SQL: Structured Query Language.
  - NoSQL: Không có ngôn ngữ Query.

- Khả năng mở rộng:
  
  - SQL: Có thể mở rộng theo chiều dọc thường là cách tăng lưu lượng phần cứng. Trong SQL databases, bạn có thể thêm dữ liệu nếu tạo bảng và field types tương ứng được gọi là schema. Schema chứa những thông tin về database mà bạn đang sử dụng như: indexes, primary keys, relationships,… Do đó schema phải được design và implements đầu tiên. Tuy nhiên nó cũng có thể update sau nhưng những thay đổi lớn sẽ trở nên phức tạp hơn khi nhìn vào file schema.
  - NoSQL: Có thể mở rộng theo chiều ngang. Dữ liệu có thể được add mọi nơi và bất kỳ lúc nào. Chính vì vậy mà nó phù hợp hơn cho các dự án mà yêu cầu dữ liệu ban đầu rất khó để xác định.

- Mục đích sử dụng:

  - SQL: Được thiết kế dành cho các ứng dụng xử lý giao dịch trực tuyến, trong giao dịch có độ ổn định cao và thích hợp để xử lý phân tích trực tuyến. Phù hợp cho các đối tượng có các thuộc tính nhất định, ít thay đổi.
  - NoSQL: Dự án yêu cầu các dữ liệu có thể không liên quan, khó xác định, đơn giản mềm dẻo khi đang phát triển. Dễ dàng mở rộng, thu hẹp database, các thuộc tính của đối tượng nhiều, dễ dàng thay đổi, không nhất quán,...

- Hiệu suất:
Thường thì không có nhiều khác biệt, nhưng khi xử lý big data thì NoSQL có vẻ nhỉnh hơn vì nó cho phép ta lấy ra thông tin về 1 đối tượng cụ thể mà không cần truy vấn quá phức tạp.


## <a name="0" >Tài liệu tham khảo</a>

<https://teky.edu.vn/blog/database-la-gi/>

<https://viblo.asia/p/nhung-diem-khac-biet-giua-sql-va-nosql-gGJ59b4rKX2>

<https://codelearn.io/sharing/sql-hay-nosql-dau-la-su-lua-chon-tot-hon>

<https://codelearn.io/sharing/ban-biet-gi-ve-nosql-database>

<https://blog.kdata.vn/so-sanh-sql-va-nosql-hai-loai-hinh-co-so-du-lieu-pho-bien-nhat-262/>

[NGÔN NGỮ TRUY VẤN SQL - Học Liệu VNUF2](http://tailieu.vnuf2.edu.vn/claroline/backends/download.php?url=L0M3X1NRTC5wZGY%3D&cidReset=true&cidReq=HQTCSDL)


Date accessed: 06/11/2022
