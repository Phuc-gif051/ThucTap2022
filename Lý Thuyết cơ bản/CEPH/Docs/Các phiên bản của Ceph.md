# Nội dung chính
[I. Nhắc lại kiến thức](#I)

[II. Cơ bản về các phiên bản của Ceph](#II)

   -  [1. Cách đặt tên](#II.1)
   -  [2. Cách đánh số thứ tự phiên bản](#II.2)
   -  [3. Chu kỳ phát hành](#II.3)

[III. Tài liệu tham khảo](#III)

___

# <a name="I" >I. Nhắc lại kiến thức</a>
Trên trang chủ hoặc wikipedia đều nói rằng CEPH là nền tảng để cung cấp hạ tầng lưu trữ, nó coi và nhìn data (dữ liệu) là các đối tượng (object) và quản lý dữ liệu này trên một hệ thống cluster (cụm gồm nhiều máy chủ hoạt động với 1 mục tiêu cụ thể) duy nhất, nó cung cấp đầy đủ các giao diện (API) để người dùng, để ứng dụng có thể thao tác với data theo các dạng (đầy đủ nhất hiện nay) là object, block và file. 
  >CEPH được sinh ra với mục tiêu cung cấp hạ tầng lưu trữ hợp nhất (gồm đẩy đủ các kiểu lưu trữ), xử lý dữ liệu phân tán trên nhiều máy chủ, thiết kế hệ thống khi triển khai CEPH là không có điểm gây nghẽn (single point of failure), có khả năng mở rộng tới exabyte và miễn phí. - TRÍCH WIKIPEDIA

# <a name="II" >II. Cơ bản về các phiên bản của Ceph</a>
## <a name="II.1" >1. Cách đặt tên</a>

Tên của các phiên bản CEPH bắt đầu bởi các chữ cái trong bảng chữ cái, tính tới thời điểm bài viết này (08.2022) thì phiên bản đầu tiên của Ceph có tên là ARGONAUT (như vậy phiên bản sau sẽ là B – BOBTAIL). Phiên bản mới nhất là Q - [QUINCY](https://docs.ceph.com/en/quincy/releases/quincy/), phát hành lần đầu ngày 19-04-2022, đã là phiên bản thứ 17 của Ceph.

Và từ "Ceph" là 04 chữ cái đầu trong tiếng Hy Lạp là CEPHALOPOD – tức là động vật chân đầu, ví dụ như: bạch tuộc, mực ống,...vì thế tên các phiên bản của Ceph ít nhiều liên quan đến bọn này 😃.

Hình ảnh về CEPHALOPOD (Động vật chân đầu)
<img src="https://user-images.githubusercontent.com/79830542/184058752-18240af5-4100-4fdb-a242-73fea262f8ec.png" width="300">

## <a name="II.2" >2. Cách đánh số thứ tự phiên bản</a>

Phiên bản hiện tại của Ceph có tên là Quincy và có số thứ tự 17. Số 17 này chính là số thứ tự của chữ cái Q trong bảng chữ cái Latinh.

Trong mỗi phiên bản của CEPH gồm 3 số và ngăn cách nhau bởi dấu chấm dạng X.Y.Z. Trong đó:
  - X: là số thứ tự của bản phát hành. Hiện nay là chữ cái Q và số là 17.
  - Y: gồm 3 giá trị 0,1,2, trong đó:
    - 0: là phiên bản thử nghiệm, dành cho các lập trình viên và tester. Có dạng: X.0.Z. Tiếng Anh gọi là DEVELOPMENT RELEASES  
    - 1: phiên bản đã ổn định hơn, tuy nhiên chưa sẵn sàng để phát hành ra thị trường. Thường dành cho cộng đồng người dùng đã có kinh nghiệm để kiểm thử và sửa lỗi. Có dạng: X.1.Z. Tiếng Anh gọi là RELEASE CANDIDATES.
    - 2: phiên bản ổn định (Stable), sẵn sàng để phát hành ra thị trường cho mục đích chạy để cung cấp dịch vụ (product).Phiên bản này chỉ còn các dạng fix các bug sau khi triển khai do người dùng phản hồi hoặc hỗ trợ các vấn đề về bug bảo mật. Sẽ có dạng X.2.Z. Tiếng Anh gọi là STABLE RELEASES.

  - Z: số lần đã được cập nhật của phiên bản đó trong suốt thời gian được hỗ trợ. Số lần cập nhật trong thời gian được hỗ trợ càng nhiều thì Z càng lớn. Ví dụ với phiên bản NAUTILUS - V14.2.22, được cập nhật tới 22 lần trong suốt thời gian được hỗ trợ.

  >Lưu ý: Cách đánh số này chỉ được bắt đầu từ bản Infernalis trở đi và bắt đầu là số 9, tức là 9.Y.Z. Trước đó team phát triển CEPH dùng là 0.Y cho bản phát triển và 0.Y.Z cho các bản ổn định (stable).

## <a name="II.3" >3. Chu kỳ phát hành</a>
Mỗi chu kỳ phát hành từng phiên bản sẽ có các khoảng thời gian cho các chu kỳ DEVELOPMENT, CANDIDATES và STABLE để đảm bảo việc phát triển và phát hành là hợp lý. Đơn vị tính sẽ là tuần, chi tiết [tại đây](https://docs.ceph.com/en/quincy/releases/general/)

Năm nào CEPH cũng được phát hành tùy vào tiến độ của các phiên bản trước đó và sẽ có bản stable cho tất cả các phiên bản. Trước bản Luminous các ổn định thường gắn dòng LTS (Long Time Support) nhưng kể từ sau đó team phát triển đã bỏ đi thay vào là từ stable. Bản stable của Ceph sẽ hỗ trợ trong 24 tháng, tính từ sau tháng đầu tiên phát hành phiên bản (nghĩa là sẽ hỗ trợ fixbug, cho phép upgrade, cập nhật bảo mật,...). Ví dụ như Quincy sẽ được hỗ trợ tới 01-06-2024.

Và các bản phát hành có thể EOL (end of life) sớm hơn con số 24 tháng, tuỳ thuộc vào bản stable của phiên bản tiếp theo được phát triển nhanh hay chậm. Thường thì các phiên bản stable của Ceph được chia làm 2 kiểu: phiên bản còn được hỗ trợ và phiên bản đã dừng hỗ trợ. Xem chi tiết hơn [tại đây](https://docs.ceph.com/en/quincy/releases/#active-releases)

# <a name="III" >III. Tài liệu tham khảo</a>
1. [Tài liệu tiếng Việt](https://news.cloud365.vn/ceph-ly-thuyet-dieu-it-de-y-ve-phien-ban-cua-ceph/)
2. [Từ trang docs của Ceph - CEPH RELEASES (GENERAL)](https://docs.ceph.com/en/quincy/releases/general/)
3. [Từ trang docs của Ceph - CEPH RELEASES (INDEX)](https://docs.ceph.com/en/quincy/releases/#active-releases)
