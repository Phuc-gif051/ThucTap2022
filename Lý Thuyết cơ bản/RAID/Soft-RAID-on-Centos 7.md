# Mục lục
[I. Giới thiệu chung](#I.GT)


<a name="I.GT"></a>
# I. Giới thiệu chung 📖
Nhắc lại kiến thức một chút, đầu tiên đó là RAID là gì?
RAID là viết tắt của Redundant Array of Independent Disks; 
là một cách ảo hóa nhiều ổ cứng độc lập thành một hoặc nhiều mảng để cải thiện hiệu năng, dung lượng và độ tin cậy (tính sẵn sàng, bảo vệ dữ liệu). 
Tổng dung lượng của mảng tùy thuộc vào loại RAID mà bạn xây dựng, cũng như số lượng và dung lượng ổ đĩa. 
Tổng dung lượng này không phụ thuộc vào RAID mềm hay RAID cứng mà bạn sử dụng. Các loại RAID phổ biến hiện nay là 0, 1, 5, 10, 01.

Qua khoảng 30 năm phát triển (khoảng năm 1990) đến nay thì RAID không chỉ được áp dụng cho các máy chủ, hay các hệ thống lớn nữa. Mà đến nay RAID 
đã có mặt trên hầu hết các thiết bị, từ các hệ thống nhỏ (văn phòng, công ty) cho đến tận người dùng cá nhân (các máy máy tính để bàn, thậm chí là cả laptop)

Để đáp ứng được nhu cầu của đa dạng khách hàng như thế thì RAID đã phải phát triển nhiều khả năng triển khai, từ RAID cứng, RAID phần mềm, RAID kết hợp.
Trong bài viết này sẽ chỉ đề cập đến RAID phần mềm (software RAID), và thực hành sử dụng trên môi trường Centos 7.

Cách đơn giản nhất để miêu tả RAID mềm đó là tác vụ RAID chạy trên CPU trong hệ thống máy tính của bạn.
Một số RAID mềm bao gồm một bo mạch phần cứng, thoạt nhìn trong nó giống như RAID cứng. Do đó, điều quan trọng cần phải hiểu là 
RAID mềm sử dụng sức mạnh tính toán của CPU. 
Mã này cung cấp các tính năng RAID chạy trên CPU hệ thống, chia sẻ sức mạnh tính toán của CPU với OS và tất cả những ứng dụng. 
Nó không có thể được xem như 1 ứng dụng được cài vào để ta sử dụng như bao ứng dụng khác.

<a name="II.Lab"></a>
# II. Thực hành (Lab) 🖥️
_Thực hành trên môi trường Centos 7_

<a name="II-1"></a>
## 1. Chuẩn bị
 - Một vài ổ cứng hoặc phân vùng không chứa dữ liệu (ít nhất là 2)
 - Công cụ RAID mềm, có khá là nhiều nhưng chủ yếu sử dụng `mdadm`
    - Kiểm tra xem hệ thống đã có mdadm chưa, sử dụng `mdadm --version`, nếu hiện version thì tức là đã có cài đặt
    - Nếu chưa có, ta cần cài đặt, dùng `yum install -y mdadm`
