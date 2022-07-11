# Mục lục 📚
[I. Chuẩn bị 🥖](#I)

[II. Tiến hành lab 🖥️](#II)
 - [1. Trên máy 1 💻](#II.1)
 - [2. Trên máy 2 💻](#II.2)
___
# <a name="I" >I. Chuẩn bị 🥖</a>
 - ít nhất 2 máy chạy Windows 10 pro, có kết nối mạng (có thể kết nối với internet hoặc không)
 - Các máy hoạt động trong cùng một dải mạng nếu không kết nối với internet.
 - Bật Network Discovery trên cả 2 máy, tham khảo [tại đây](https://quantrimang.com/3-cach-kich-hoat-hoac-vo-hieu-hoa-network-discovery-tren-windows-7810-130082)

# <a name="II" >II. Tiến hành lab 🖥️</a>
## <a name="II.1" >1. Trên máy 1 💻</a> 

_Bước 1: Kích chuột phải vào thư mục mà bạn muốn chia sẻ, sau đó click chọn Properties._
<img src="https://user-images.githubusercontent.com/79830542/178191373-ff274023-e2eb-464d-b663-b40c1cab64c6.png" width="500">

_Bước 2: Trên cửa sổ Sharing Properties, bạn click chọn thẻ Sharing. Dưới mục Network file and Folder Sharing, bạn click chọn Share._
<img src="https://user-images.githubusercontent.com/79830542/178191734-f48731b5-1593-48ab-9732-ca887e02a858.png" width="500">

_Bước 3: Nhập tên người mà bạn muốn chia sẻ thư mục. Tiếp theo sau khi đã thêm xong tên vào danh sách, bạn click chọn Share._
<img src="https://user-images.githubusercontent.com/79830542/178191853-c7eb1e09-e999-4020-b533-6054e3c794ce.png" width="500">

_Bước 4: Nếu muốn kiểm soát quyền truy cập đọc và viết (read and write) của thư mục trong quá trình chia sẻ, bạn click chọn Advanced Sharing trên cửa sổ Share Properties._

<img src="https://user-images.githubusercontent.com/79830542/178191920-240c84cb-01d5-421f-9288-bc803e4d241d.png" width="500">

_Bước 5: Đánh tích tùy chọn Share this folder, và click chọn Permissions._
<img src="https://user-images.githubusercontent.com/79830542/178192001-da41ce2b-eff8-4641-8a5b-f542830e8a99.png" width="500">

_Bước 6: Tiếp theo đánh tích chọn Full Control, sau đó click chọn OK._
<img src="https://user-images.githubusercontent.com/79830542/178192079-efa0851f-2cac-48c6-97f3-2ff0fb00f500.png" width="500">

Lưu ý:

 - Tiến hành chỉnh sửa quyền cho phép trong thẻ Security để cung cấp toàn quyền kiểm soát thư mục trong quá trình chia sẻ.
 - Nếu thiết lập Security không thay đổi, có ít nhất số lượng một người truy cập trong Sharing và Security sẽ được cân nhắc trong quá trình chia sẻ.

_Bước 7: Click chọn thẻ Security. Để thay đổi quyền cho phép, bạn click chọn Edit._
<img src="https://user-images.githubusercontent.com/79830542/178192235-978625b5-79a1-46cc-8fd6-0501a6e6ab83.png" width="500">


_Bước 8: Click chọn Add._

<img src="https://user-images.githubusercontent.com/79830542/178192302-54ccac18-c987-4b3f-8d78-9b4551ba55f7.png" width="500">

_Bước 9: Nhập Everyone vào khung Enter the object names to select rồi click chọn OK._
<img src="https://user-images.githubusercontent.com/79830542/178192377-920a9e1f-7bd6-4516-9de5-52627469b222.png" width="500">

_Bước 10: Trong mục Username, bạn chọn Everyone, sau đó đánh tích chọn Full Control. Cuối cùng click chọn OK để hoàn tất toàn bộ quá trình._

<img src="https://user-images.githubusercontent.com/79830542/178192468-26b8ee82-d545-4abc-89fd-9f20173cbf24.png" width="500">


Đó là tất cả những gì cần làm! Bạn đã chia sẻ thành công một thư mục với người dùng trong Windows 10. Sau đó, người dùng có thể truy cập thư mục đó từ bảng điều khiển Network trong File Explorer.

## <a name="II.2" >2. Trên máy 2 💻</a>
Mở bảng điều khiển Network trong File Explorer. OS sẽ tự tìm kiếm những thứ mà máy khác chia sẻ, có thể sẽ hơi lâu. Hoặc bạn dùng tổ hợp phím `Windows + R` mở lên hộp thoại `Run` rồi nhập `\\ip của máy share`

<img src="https://user-images.githubusercontent.com/79830542/178206028-fdc1bf6e-aaae-4db3-87fd-337445697146.png" width="500">

Để chứng thực việc SMB/CIFS được sử dụng trong việc chia sẻ file trên windows ta sử dụng công cụ bắt gói tin trên mạng - Wireshark để xác nhận. Việc download và sử dụng wireshark ta tự tìm kiếm trên internet.

<img src="https://user-images.githubusercontent.com/79830542/178205328-d5b60f8b-033b-48d1-a2f9-9d45d9617839.PNG" width="500">

Như hình trên, ta có thể thấy 2 máy với 2 địa chỉ ip 172.16.5.4 và 172.16.5.5 đã thực hiện việc giao tiếp trong quá trình chia sẻ file bằng SMBv2.

# <a name="III" >III. Tài liệu tham khảo</a>
1. [chia sẻ file trên windows 10](https://quantrimang.com/cach-chia-se-mot-thu-muc-folder-qua-mang-lan-tren-windows-10-124224)
