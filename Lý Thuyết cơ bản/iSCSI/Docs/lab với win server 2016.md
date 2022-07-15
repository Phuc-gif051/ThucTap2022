# Mục lục
[I. Chuẩn bị](#I)

[II. Thực hành](#II)
 - [1. Cấu hình máy chạy windows server](#II.1)
 - [2. Kết nối iSCSI Virtual Disk cho iSCSI Initiator trên Windows](#II.2)
 - [3. Kết nối iSCSI Virtual Disk cho iSCSI Initiator trên CentOS](#II.3)

___
# <a name="I" >I. Chuẩn bị</a>
ít nhất 3 máy:
 - 1 máy chạy windows server 2016
 - 1 máy chạy windows 10 pro
 - 1 máy chạy Linux, ở bài thực hành này là chạy CentOS 7.

Biết được địa chỉ IPv4 của các máy. Các máy có thể ping được cho nhau. 

# <a name="II" >II. Thực hành</a>
_Ta sẽ dùng máy chạy windows server 2016 làm máy target, tiến hành quản lý và chia sẻ tài nguyên lưu trữ_
## <a name="II.1" >1. Cấu hình máy chạy windows server</a>
Bước 1: Cài đặt iSCSI Target Server:

Để triển khai dịch vụ, chúng ta tiến hành cài đặt Server roles iSCSI Target Server. Tại Server Roles mở rộng File and Storage Services -> File and iSCSI  Services và chọn iSCSI Target Server.

<img src="https://user-images.githubusercontent.com/79830542/179170514-957bee2d-8234-4f0f-b700-8276b66c4459.png" width="600">

Sau khi cài đặt xong Server Roles, bạn chọn Close.

<img src="https://user-images.githubusercontent.com/79830542/179170818-11b915a5-ffce-4f99-8a4d-26bb70060941.png" width="600">

Bước 2: Lấy thông tin IQN (iSCSI Qualified Name) từ iSCSI Initiator (Client):

Truy cập iSCSI Initiator trên Windows 10  và Windows Server từ menu Windows:

<img src="https://user-images.githubusercontent.com/79830542/179171005-b2e60779-4e61-42ca-a94b-29e17196080f.png" width="600">

Mặc định dịch vụ iSCSI Initiator chưa được bật, sau khi chọn mở dịch vụ lần đầu trên hợp thoại Micrsoft iSCSI chọn Yes để start dịch vụ.

<img src="https://user-images.githubusercontent.com/79830542/179171600-0616cdbb-3d08-4350-8abe-b19a5580d7ec.png" width="600">

Trong iSCSI Initiator Properties chọn tab Configurations, copy Initiator name và lưu lại để sử dụng khi tạo iSCSI Virtual Disk.

<img src="https://user-images.githubusercontent.com/79830542/179172173-ac9e986c-290e-43cb-8da7-420a034586d0.png" width="600">

Bước 3: Tạo New iSCSI Virtual Disk…

Trong Server Manager, chọn lên File and Storage Services, chọn iSCSI. Trong iSCSI Virtual Disks, chọn Tasks -> New iSCSI Virtaul Disk…

<img src="https://user-images.githubusercontent.com/79830542/179172450-905256b0-da2b-43d3-a23d-a6f95fcaeac1.png" width="600">

Tiếp theo, chọn nơi lưu trữ cho iSCSI Virtual Disk

<img src="https://user-images.githubusercontent.com/79830542/179172552-f1064724-a84e-4ba9-b361-6d0de3d7820d.png" width="600">

Đặt tên cho iSCSI Virtual Disk

<img src="https://user-images.githubusercontent.com/79830542/179172675-b6b1fe4f-3bf4-4b25-81b2-7e52a7839944.png" width="600">

Tiếp theo, chọn size cho iSCSI Virtual Disk. Ở đây, nếu chọn Dynamically expanding thì dung lượng của fiile ổ cứng iSCSI Virtual Disk sẽ tăng theo dung lượng mà chúng ta sử dụng và cao nhất là bằng với số dung lượng mà bạn đã chọn ở mục Size. Dynamically expanding cho phép tiết kiệm dung lượng của phân vùng chưa file iSCSI Virtual Disk khi file này chưa sử dụng đến dung lượng mà bạn khai báo ở Size.

<img src="https://user-images.githubusercontent.com/79830542/179172795-17422c39-0105-4bbd-ae6f-8642095c09f9.png" width="600">

Tiếp theo, tạo New iSCSI target

<img src="https://user-images.githubusercontent.com/79830542/179172942-feccbd04-a316-4eab-8cd3-77297a1ed283.png" width="600">

Đặt tên cho iSCSI target

<img src="https://user-images.githubusercontent.com/79830542/179173056-d56757c9-b4a9-4f0b-8959-4cee84ae2da6.png" width="600">

Tiếp theo, mục Access Server chúng ta sẽ tiến hành khai báo iSCSI initiator, chọn Add.

<img src="https://user-images.githubusercontent.com/79830542/179173365-d7d1c731-48b5-4384-92ea-17e1c30b3b8f.png" width="600">

Tiếp theo, bạn điền IQN của iSCSI Initiator đã lấy ở Bước 2 từ phía client.

<img src="https://user-images.githubusercontent.com/79830542/179174403-8caca2c9-680f-438b-af42-d41b7e8b03da.png" width="600">

Sau khi khao báo xong, bạn sẽ thấy thông tin của IQN của iSCSI Initiator

<img src="https://user-images.githubusercontent.com/79830542/179174765-e19f4999-a7e5-4091-8d1d-79a60c159ac3.png" width="600">

Tiếp theo, bạn có thể chọn phương thức chứng thực cho kết nối từ iSCSI Initiator đến iSCSI Target. Ở đây, chúng ta bỏ qua tùy chọn này. Sẽ tìm hiểu về nó sau.

<img src="https://user-images.githubusercontent.com/79830542/179175044-16027f25-709f-4811-a792-e9b29fb4b76b.png" width="600">

Màn hình Confirmation, cho phép bạn có cái nhìn tổng thể về những cấu hình mà bạn đã chọn. Bạn click Create để tiến hành tạo iSCSI Virtual Disk.

<img src="https://user-images.githubusercontent.com/79830542/179175279-ea57390b-e2c9-4c0e-87db-829b4e590138.png" width="600">

Sau khi tạo xong, bạn chọn Cloes để đóng của sổ New iSCSI Virtual Disk Wizard.

<img src="https://user-images.githubusercontent.com/79830542/179175485-98ef3421-2b86-4c95-b655-f9ffe462b276.png" width="600">

Sau khi tạo xong iSCSI Virtual Disk, bạn sẽ thấy  ổ đỉa ảo này trong thư iSCSI của Server Manager.

<img src="https://user-images.githubusercontent.com/79830542/179175748-70179307-4944-4fa2-b3a4-a2ae767b1573.png" width="600">

Bạn có thể thấy file ổ cứng ảo iSCSI Virtual Disk được lưu trữ trong iSCSIVirtualDisks. File này chỉ có dung lượng khoản 4MB thay vì 10 GB do phía trên, khi khởi tạo, bạn đã chọn Dynamically expanding

<img src="https://user-images.githubusercontent.com/79830542/179176021-08d52694-530c-45d1-ad03-c08e56b62153.png" width="600">

_Lưu ý: Server dùng triển khai iSCSI target server không được bật dịch vụ iSCSI Initiator._

## <a name="II.2" >2. Kết nối iSCSI Virtual Disk cho iSCSI Initiator trên Windows 10</a>

Truy cập vào iSCSI Initiator như đã nói ở Bước 2. Trong cửa sổ iSCSI Initiator Properties chọn tab Discovery, chọn Discover Portal…, điền vào thông tin IP hoặc DNS name của máy đang chạy iSCSI target server.

<img src="https://user-images.githubusercontent.com/79830542/179176369-a4c55ef5-5659-4d07-a05e-390517ad0405.png" width="600">

Sau khi chỉ dịnh xong iSCSI target server, tiếp tục chuyển qua tab Targets của iSCSI Initiator Properties

<img src="https://user-images.githubusercontent.com/79830542/179176523-d22b95fe-5db0-48f8-93be-3da86662f369.png" width="600">

Ở tab Target, bạn chọn lên Target name muốn kết nối đến, chọn Conect.

<img src="https://user-images.githubusercontent.com/79830542/179176635-5cb5def0-efc1-4926-a2cd-173ff057fa20.png" width="600">

Sau khi kết nối thành công đến target, bạn truy cập vào Disk Management của Windows sẽ thấy ổ đĩa iSCSI Virtual Disk. Bạn tiến hành khởi tạo đỉa mới và tạo phân vùng là có thể sử dụng.

<img src="https://user-images.githubusercontent.com/79830542/179176774-da5ee291-318c-47b9-b1ac-44d717a08901.png" width="600">

Sau khi, tạo ra Volume mới, bạn có thể thấy các phân vùng của iSCSI Virtual Disk giống hệt như các ổ đỉa vật lý trên chính máy iSCSI Initiator (iSCSI Client)

<img src="https://user-images.githubusercontent.com/79830542/179176895-dcc7373a-e0d5-46c5-a5d8-024d3b2a397a.png" width="600">

## <a name="II.3" >3. Kết nối iSCSI Virtual Disk cho iSCSI Initiator trên CentOS 7</a>

Trên CentOS 7 cần cài thêm các gói Initiator để có thể sử dụng được iSCSI Initiator. Sử dụng câu lệnh:
```sh 
sudo yum install iscsi-initiator-utils* -y
```
Dùng lệnh `vi /etc/iscsi/initiatorname.iscsi` để vào chỉnh sửa tên IQN theo ý thích của bạn hoặc dùng câu lệnh 

```sh
echo "InitiatorName=iqn.2022-07.com.linux:CentOS7>" | sudo tee /etc/iscsi/initiatorname.iscsi
```
<img src="https://user-images.githubusercontent.com/79830542/179181307-b741b0ef-779b-4d09-88be-cd515f7b8de6.png" width="500">

Lưu lại IQN này theo cách của bạn dùng để cấu hình trên Windows server 2016 tương tự như ở [mục 1](#II.1)

Sau khi cấu hình xong trên server, tại máy centos ta cũng sẽ dò tìm xem có kết nối nào hay không bằng câu lệnh
```sh
iscsiadm --mode discovery --type sendtargets --portal <IP server> --discover
```
thay thế <IP server> bằng IP của Windows server 2016. Bạn sẽ nhận lại kết quả trả về tương tự thế này:
  
  <img src="https://user-images.githubusercontent.com/79830542/179185597-22501b5b-1829-45fa-947a-e892b0d8cf69.png" width="600">
  
  Nếu băn khoăn tại sao máy bạn không hiển thị là `centos7-target` thì lý do là lúc cấu hình trên win server, bạn đặt tên như nào thì nó sẽ hiển thị như vậy, ở đây mình đặt `Target name` là `centos7`

  Tìm kiếm thấy có kết nối khả dụng, ta có thể tiến hành kết nối tới chúng bằng câu lệnh:

  ```sh
sudo iscsiadm --mode node --targetname <iqn name server> --portal <IP server> --login
  ```
  

