# 🐡 Mục lục 🐡
[I. Tổng hợp](#Tonghop)
 - [1. Các loại RAID phổ biến](#1nhoI)
 - [2. RAID và non-RAID](#2nhoI)
 - 
[II. Thực hành (lab)](#II.Thuchanh)
 - [1. Sử dụng "racadm"](#1.racadm)
 - 
[Tài liệu tham khảo](#tailieuthamkhao)


___
<a name="Tonghop"></a>
# I. Tổng hợp 👓
<a name="1nhoI"></a>
## 1. Các loại RAID phổ biến 🧑‍💻
| Nội dung | RAID 0 | RAID 1 | RAID 5 | RAID 10|
|:---:|:---:|:---:|:---:|:---:|
| Ổ đĩa tối thiểu | 2-Hỏng 1 ổ là mất dữ liệu | 2-Hỏng tối thiếu 1 ổ | 3-Hỏng tối thiếu 1 ổ | 4-hỏng tối thiếu 1 ổ cùng cặp hoặc 2 ổ khác cặp|
| Dung lượng khả dụng|100%|50%|66,7%-94%|50%|
| Kỹ thuật lưu trữ | Striping (chia nhỏ tệp để ghi vào từng ổ đĩa) | Mirroring (trích ra 1 ổ đĩa trong cụm RAID để sao lưu) | Kết hợp striping và Mirroring (sử dụng thuật toán chẵn lẻ (parity)) | Kết hợp striping và Mirroring|
| Ưu điểm | Đọc ghi nhanh, ít chi phí ban đầu | Sao lưu dữ liệu tốt, ít chi phí ban đầu | Hiệu suất cao, bảo vệ dữ liệu tốt | Hiệu suất cao, bảo vệ dữ liệu tốt|
| Nhược điểm | Không bảo vệ được dữ liệu | Đọc ghi chậm hơn so với RAID 0 | Mất 1 phần dung lượng để sao lưu, chi phí ban đầu cao | Mất 1 nửa dung lượng để sao lưu, Chi phí ban đầu cao|
| Đối tượng hướng tới| Dịch vụ cần đọc/ghi tốc độ cao, phù hợp với người dùng cá nhân| Dịch vụ yêu cầu sự an toàn về dữ liệu mà chưa có nhiều chi phí, người dùng cá nhân hay văn phòng nhỏ| Vừa đọc/ghi cao vừa có bảo vệ dữ liệu, doanh nghiệp vừa, văn phòng,| Vừa đọc/ghi cao vừa có bảo vệ dữ liệu cao|
|:smile:|🍉|🍍|🍎| 🍌|

_Lưu ý_: Nên sử dụng ổ cứng cùng 1 công ty, cùng 1 seri khi có ý định triển khai RAID.

<a name="2nhoI"></a>
## 2. RAID và non-RAID 😶
| Col A | RAID | non-RAID|
|:---:|:---:|:---:|
| Đối tượng sử dụng | Các trung tâm, tổ chức, công ty lớn, vừa và nhỏ; người dùng phổ thông | Người dùng phổ thông|
| Cách thức hoạt động| Gộp nhiều ổ đĩa lại thành 1 ổ thống nhất| Mỗi ổ là độc lập, không có sự liên kết|
| Ưu điểm 🌻 | Quản lý ổ cứng một cách tốt nhất | Dễ dàng sử dụng, rẻ, không cần quản lý quá nhiều |
| 🌻| Bảo toàn dữ liệu với nhiều lựa chọn và phương pháp thích hợp| ---|
| 🌻| Tính liên tục không bị gián đoạn trong trường hợp lỗi phần cứng| ---|
| Nhược điểm 🐊| Phải là người có hiểu biết về quản trị hệ thống để triển khai| Không có các biện pháp để bảo vệ dữ liệu tức thời|
| 🐊| Chấp nhận giảm hiệu năng của CPU hoặc đầu tư về phần cứng (card RAID, ổ cứng)| Không có tính liên tục khi hỏng phần cứng|

<a name="II.Thuchanh"></a>
# II. Thực hành (lab) 🖥️
 
<a name="1.racadm"></a>
## 1. Sử dụng "racadm"
- Cài đặt DRAC Command Line Tool trên môi trường window
- Sử dụng "Open VPN" để kết nối đến server (thực hành với server từ xa, với điều kiện Server có sử dụng iDRAC)
- Tiến hành lab: 
  - sử dụng `storage get pdisks` để tiến hành lấy thông tin các ổ cứng đang có
  - các hệ số -r: địa chỉ của server -u: tên tk quản trị -p:mật khẩu của tk quản trị là không đổi.
<img src="https://user-images.githubusercontent.com/79830542/165014779-9061d138-35b1-4dab-ae8c-2ff28b8cc005.png" width="800">

  - Sử dụng `storage forceoffline` để buộc 1 ổ cứng vật lý offline (để online thì làm tương tự `storage forceonline`).
  - Ví dụ hình dưới buộc ổ 0 (Disk.Bay.0) offline. Tuy nhiên câu lệnh sẽ không được thực thi ngay lập tức mà được đưa vào hàng đợi, để được tiến hành xác nhận.

<img src="https://user-images.githubusercontent.com/79830542/165015371-674578a1-884d-40d4-8da0-78da576e668c.png" width="800">

  - Tiến hành xác nhận câu lệnh trên. Đầu tiên, ta phải kiểm tra xem bộ điều khiển đang hỗ trợ kiểu RAID nào. Để kiểm tra ta sử dụng lệnh `storage get controllers -o -p RealtimeConfigurationCapability`.
 Với `Capable` là hỗ trợ, `Incapable` là không hỗ trợ.

<img src="https://user-images.githubusercontent.com/79830542/165015984-5fb9b5a0-bac0-4b95-a2bd-83165c83d421.png" width="800">

  - Sau khi xác nhận thực hiện câu lệnh với hệ thống bằng lệnh `jobqueue create RAID.Integrated.1-1 -s TIME_NOW --realtime`
  - -s: sau bao lâu thì tiến hành reboot để áp dụng câu lệnh, thường tính bằng giây (ở đây là thực hành nên server có thể reboot ngay, để TIME_NOW)
  - --realtime: trong thời gian thực của hệ thống

<img src="https://user-images.githubusercontent.com/79830542/165016423-43dcbfa5-754b-478d-8785-6230822be493.png" width="800">

  - Đã xác nhận câu lệnh, hệ thống sẽ sinh ra 1 ID: JID_XXXX để lưu lại tiến trình thực hiện này. Xem chi tiết tiến trình ta dùng câu lệnh `jobqueue view -i JID_xxxxx`. Percent Complete đạt 100 nghĩa là tiến trình đã hoàn tất.

<img src="https://user-images.githubusercontent.com/79830542/165016853-ec68b145-9cfb-4b57-8593-436d4bf27fba.png" width="800">

  - Kiểm tra lại `storage get pdisks -o -p state` 

<img src="https://user-images.githubusercontent.com/79830542/165017322-9a7e26a0-23f0-4da1-a30d-ea4920935cc7.png" width="800">

Thành công buộc ổ 0 offline sử dụng "racadm" trên window 10

<a name="tailieuthamkhao"></a>
# Tài liệu tham khảo 📖
[1. Các loại RAID](https://hostingviet.vn/cong-nghe-raid-raid-0-raid-1-raid-5-raid-10)

[2.Tài liệu PDF](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwjuxPbbl673AhWds1YBHWliA2EQFnoECB0QAQ&url=https%3A%2F%2Fobjects.icecat.biz%2Fobjects%2Fmmo_8955)
