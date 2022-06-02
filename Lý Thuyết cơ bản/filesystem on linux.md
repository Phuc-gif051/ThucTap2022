# Mục lục
[I. Định dạng file phổ biến trên linux](#I) 
 - [1. Các định nghĩa cơ bản](#I.1) 


[III. Tài liệu tham khảo](#III) 

# <a name="I">I. Định dạng file phổ biến trên linux</a>

## <a name="I.1">1. Các định nghĩa cơ bản</a>
 - Filesystem là các phương pháp và các cấu trúc dữ liệu mà một hệ điều hành sử dụng để theo dõi các tập tin trên ổ đĩa hoặc phân vùng. Có thể tạm dịch filesystem là hệ thống tập tin. File system được dùng để quản lý cách dữ liệu được đọc và lưu trên thiết bị. Thuật ngữ này cũng được sử dụng để chỉ một phân vùng hoặc ổ đĩa được sử dụng để lưu trữ các tập tin hoặc loại hệ thống tập tin. Với mỗi OS khác nhau thì ta cũng sẽ phải sử dụng các định dạng filesystem khác nhau:
    + Trên Window thì là NTFS, FAT..., 
    + Trên MacOS là HFS+,..., 
    + Trên Linux là ext, xfs,...
 - The journaling file system (JFS) công nghệ đi kèm trong hệ thống file system được IDM đề ra và phát triển từ những năm 1990. Về cơ bản nó là một “journal” của dữ liệu, mục đích của nó là theo dõi các thay đổi chưa được ghi lại (commit) đối với hệ thống file. Ngay cả sau khi có sự cố hoặc tắt máy đột xuất, bạn vẫn có thể truy cập phiên bản file mới nhất với khả năng bị lỗi thấp hơn.
 - Sector: đơn vị nhỏ nhất của 1 thiết bị lưu trữ chiếm một vị trí thực trên thiết bị lữu trữ và thường được tạo thành từ 3 phần: Header, ECC(Error-correcting Code), và khu vực thực sự lưu trữ dữ liệu. một sector của ổ đĩa cứng hoặc đĩa mềm có thể chứa 4096 byte thông tin.
 - Cluster size: về cơ bản đây là 1 cụm các sector, đây là thứ người dùng hay thấy. Nó đại diện cho lượng không gian đĩa nhỏ nhất có thể được sử dụng để chứa một tệp. Trên giao diện người dùng thì đây còn được gọi là Allocation unit size (AUS)


# <a name="III">III. Tài liệu tham khảo</a>

[1](https://www.howtogeek.com/443342/how-to-use-the-mkfs-command-on-linux/#:~:text=The%20modern%20way%20of%20using,displayed%20in%20the%20terminal%20window.)

[2](https://www.howtogeek.com/howto/33552/htg-explains-which-linux-file-system-should-you-choose/)

[3. Tìm hiểu khái niệm cơ bản về hệ thống file trong Linux](https://quantrimang.com/tim-hieu-khai-niem-co-ban-ve-he-thong-file-trong-linux-84900) 

[4. Tìm hiểu hệ thống tập tin và thư mục trên hệ điều hành Linux](https://quantrimang.com/he-thong-tap-tin-va-thu-muc-tren-linux-45046) 

