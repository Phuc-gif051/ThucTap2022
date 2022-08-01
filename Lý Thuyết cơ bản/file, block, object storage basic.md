# File storage 

Dữ liệu được lưu trữ dưới dạng tệp, giống như cách thức các hệ điều hành lưu trữ dữ liệu của người dùng. Khi bạn cần truy cập vào phần dữ liệu đó, máy tính của bạn cần biết đường dẫn để tìm thấy nó. Dữ liệu được lưu trữ trong file được sắp xếp và truy xuất bằng cách sử dụng một lượng metadata giới hạn. Nó sẽ cho máy tính biết chính xác nơi file được lưu giữ.

Đây chính là cách thức lưu trữ mà bạn sử dụng hằng ngày trên điện thoại, máy tính,...

Nó có 1 lượng lớn dung lượng, có thể lưu trữ kể cả với các dữ liệu ít thay đổi hay thay đổi liên tục. Tuy nhiên nó vẫn phù hợp nhất với người dùng cá nhân, dùng để lưu trữ các dữ liệu cá nhân.

Trên môi trường mạng, muốn chia sẻ ở dạng thư mục cho người dùng khác lưu trữ, chỉnh sửa thì có thể dùng: NFS, CIFS/SMB. Người được chia sẻ có thể dùng toàn bộ dung lượng trống hiện có, tuy nhiên chỉ có thể truy cập và sử dụng duy nhất thư mục được chia sẻ.

___

# Block storage

Block storage services cung cấp một thiết bị block storage - giống như một hard drive - qua network. Các nhà cung cấp đám mây thường có các sản phẩm có thể cung cấp một thiết bị block storage có kích thước bất kỳ và đính kèm nó vào máy ảo của bạn.

Do đó, bạn sẽ sử dụng nó như một ổ cứng bình thường. Bạn có thể định dạng nó với một hệ thống tập tin và lưu trữ các tập tin trên đó, kết hợp nhiều thiết bị vào một mảng RAID, hoặc cấu hình một cơ sở dữ liệu để ghi trực tiếp vào block device. Ngoài ra, các thiết bị network-attached block storage thường có một số ưu điểm độc đáo so với các ổ đĩa cứng thông thường:

 - Các block storage có thể dễ dàng tăng giảm kích thước theo nhu cầu sử dụng.
 - Dễ dàng di chuyển các block từ máy này sang máy khác, mà không phải vận chuyển vật lý hay can thiệp vào phần cứng.
 - Các ngôn ngữ lập trình có thể dễ dàng đọc ghi trên các block storage.
 - Có độ trễ IO thấp, phù hợp để lưu trữ các dữ liệu có nhiều trường, thường xuyên thay đổi.
 - Dễ dàng backup dữ liệu.
 - Tuy nhiên khi được phân bổ 1 block storage bạn sẽ phải trả phí cho toàn bộ dung lượng của block đó, cho dùng bạn có dùng tới hay không.

Trên môi trường mạng, khi muốn chia sẻ 1 block storage thì có 2 cách phổ biến nhất đó là: iSCSI và Fibre (hệ thống SAN).

___

# Object storage




[github](https://github.com/meditechopen/meditech-thuctap/blob/master/Songle/Storage/Object%20Storage%20vs%20Block%20Storage.md)

[tong-quan-object-storage-va-block-storage](https://bizflycloud.vn/tin-tuc/tong-quan-object-storage-va-block-storage-la-gi-20180929092519105.htm)

[file-storage-block-storage-va-object-storage](https://vietnix.vn/file-storage-block-storage-va-object-storage-la-gi/)



