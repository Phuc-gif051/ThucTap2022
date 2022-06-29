# Mục lục 🧑‍💻

[I. Giới thiệu](#I)
 - [1. NFS là gì? ❓](#I.1)
 - [2. Bên trong NFS 🔎](#I.2)

[II. Thực hành 🖥️](#II)
 - [1. Chuẩn bị](#II.1)
 - [2. Tiến hành](#II.2)
    - [2.a) Trên server](#2.a)
    - [2.b) Trên client](#2.b)  
    - [2.c) Trên Windows](#2.c)

----

# <a name="I" >I. Giới thiệu 📰</a> 

## <a name="I.1" >1. NFS là gì? ❓</a>
 - Khi nhu cầu trao đổi, chia sẻ (sharing) dữ liệu phát sinh trên môi trường máy chủ Linux, bạn có thể sử dụng dịch vụ Network File System (NFS) được phát triển từ những năm 1984 bởi Sun Microsystems.

 - Dịch vụ NFS cho phép chia sẻ tập tin cho nhiều người dùng trên không gian mạng và người dùng có thể thao tác như với tập tin trên chính đĩa cứng của mình.

 - NFS sử dụng mô hình Client/Server. Trên server có các disk chứa các file hệ thống được chia sẻ và một số dịnh vụ chạy ngầm (daemon) phục vụ cho việc chia sẻ với Client.
Cung cấp chức năng bảo mật file và quản lý lưu lượng sử dụng (file system quota).
Các Client muốn sử dụng các file system được chia sẻ thì sử dụng giao thức NFS để mount các file đó về.

 - Khi triển khai hệ thống lớn hoặc chuyên biệt cần áp dụng NFSv3, còn người dùng ngẫu nhiên hoặc nhỏ lẻ thì áp dụng NFSv2, NFSv4. Với NFSv4, yêu cầu hệ thống phải có kernel phiên bản từ 2.6 trở lên. Đến thời điểnm hiện tại thì v4 đã đủ "cứng cáp" để sử dụng rộng rãi.

 - Để xử lý được những file lớn hơn 2GB, đòi hỏi hệ thống phải có phiên bản kernel lớn hơn hoặc bằng 2.4x và [Glibc](https://www.bing.com/search?q=glibc+l%c3%a0+g%c3%ac&qs=UT&pq=glibc+l%c3%a0&sc=3-8&cvid=73F8D3463B984F38920BFDE1A7B8A52A&FORM=QBRE&sp=1) từ 2.2.x trở lên. Với máy
Client từ phiên bản kernel 2.2.18 trở đi đều hỗ trợ NFS trên nền [TCP](https://viblo.asia/p/tim-hieu-giao-thuc-tcp-va-udp-jvEla11xlkw)

 - Một số vấn đề với NFS
   + Không bảo mật, mã hóa dữ liệu
   + Hiệu suất hoạt động trung bình ở mức khá, nhưng không ổn định
   + Dữ liệu phân tán có thể bị phá vỡ nếu có nhiều phiên sử dụng đồng thời

## <a name="I.2" >2. Bên trong NFS 🔎</a>

Các dịch vụ cấu thành NFS:

 - **Portmapper**: Quản lý các kết nối, dịch vụ chạy trên port 2049 và 111 ở cả server và client. xem chi tiết dùng lệnh `rpcinfo -p`.

 - **NFS**: Khởi động các tiến trình [RPC (Remote Procedure Call)](https://mindovermetal.org/rpc-la-gi-1637533962/) khi được yêu cầu để phục vụ cho chia sẻ file, dịch vụ chỉ chạy trên server.

 - **NFS lock**: Sử dụng cho client khóa các file trên NFS server thông qua RPC.

Dịch vụ NFS, cần có các daemon (dịch vụ chạy ngầm trên hệ thống) sau:

 - **nfsd**: thực hiện hầu hết mọi công việc. (quản lý các yêu cầu từ RPC, các tiến trình song song)
 - **rpc.mountd**: quản lý các yêu cầu gắn kết lúc ban đầu. đúng máy đúng file hay không và thông báo cho khách. Protocols used: rpc.mountd [-d] [-f] [-h] [-v] 
 - **rpc.rquotad**: quản lý các hạn mức truy cập file của người sử dụng trên server được truy xuất.
 - **rpc.lockd**: Được cung cấp bởi RPC và được gọi theo yêu cầu của nfsd. Vì thế bạn cũng không cần quan tâm lắm tới việc khởi động nó. Nó sử dụng NFS Lock Manager (NLM) Protocol • Các thủ tục được sử dụng: NLM_NULL, NLM_TEST, NLM_LOCK, NLM_GRANTED NLM_UNLOCK, NLM_FREE
 - **rpc.statd**: check trạng thái của máy (cả server và client), Rpc.lockd của máy chủ yêu cầu rpc.statd lưu trữ thông tin khóa (trong hệ thống tệp) - Và để theo dõi trạng thái khóa máy • Nếu máy khách gặp sự cố, hãy xóa ổ khóa khỏi máy chủ. Use Network Status Monitor (NSM) Protocol • Procedure used: SM_NULL,SM_STAT,SM_MON,SM_NOTIFY
 
_Các dịch vụ ngầm chủ yếu được cung cấp bởi RPC và NFS chỉ cần quản lý chúng_ 
 
NFS sẽ cung cấp và quản lý quyền hạn của các máy khách được chia sẻ tệp, các quyền hạn cơ bản như sau:

 - rw: quyền đọc và viết.

 - ro: quyền chỉ đọc.
 - sync: máy chủ sẽ không ghi nhận bất kỳ thay đổi nào cho đến khi thay đổi trước đó được hoàn thành. Việc này dễ gây mất mát dữ liệu, đặc biệt là khi làm việc với lượng dữ liệu lớn. Để tắt tính năng này thì khai báo `async`
 - root_squash: ngăn người dùng _root_ ở client có quyền root đối với tệp tin ở server, giảm thiểu tối đa các nguy cơ gây thiệt hại cho hệ thống. Khi này người dùng ở client khi truy cập vào server sẽ được NFS cấp cho 1 mã định danh gọi là _nfsnobody_. Để tắt tính năng này, khai báo `no_root_squash`.
 - subtree_check: kiểm tra các thư mục con của thư mục được chia sẻ xem có những gì ở trong và người được chia sẻ có quyền gì với thư mục con đó hay không. Nếu chia sẻ cả 1 ổ đĩa thì nên tắt đi bằng `no_subtree_check` để tối ưu hiệu năng.
 - wdelay: tạm dừng việc ghi vào đĩa khi NFS nghi ngờ có hành động ghi khác được yêu cầu. Có thể tắt nó đi khi `sync` được bật bằng cách khai báo `no_wdelay`

 - all_squash: Tất cả các tệp được tạo với tư cách là người dùng ẩn danh (anonymous user). Thích hợp cho việc chia sẻ file cho các hệ thống không phải là UNIX, nổi bật nhất là Windows, để các client có quyền đọc khi tạo file mới trên server khi đã được cấp quyền rw trước đó.

⚠️ Mặc định các quyền sẽ là tốt nhất cho hệ thống, như: root_squash, no_subtree_check, wdelay,...


**Các file quan trọng trong NFS cần lưu tâm đến:**
 - /etc/exports
       + Ví dụ: bạn cần chia sẻ thư mục /Share cho các máy có địa chỉ từ 192.168.1.1 đến 192.168.1.80 quyền đọc viết thì khai báo bên trong tập tin /etc/exports là: /Share 192.168.1.1/28(rw)

_Lưu ý: giữa tên máy hoặc địa chỉ IP của client với quyền hạn thường không có dấu cách._

  - Nếu bạn viết lại tập tin /etc/exports như sau: /Share 192.168.1.1/28 (rw)​thì các máy từ 192.168.1.1 đến 192.168.1.80 chỉ có quyền đọc, còn các máy khác (địa chỉ IP không thuộc dải trên) lại có quyền đọc và ghi đầy đủ. Khi cần chia sẻ cho nhiều máy thì tên các máy (hoặc địa chỉ IP) có thể viết trên cùng một dòng nhưng cách nhau bằng khoảng trắng

      + Ví dụ: Bạn muốn chia sẻ thư mục /Share cho các máy tính có địa chỉ IP là 192.168.1.[2-4] có quyền đọc, ghi là: /Share 192.168.1.2(rw) 192.168.1.3(rw) 192.168.1.4(rw) 

Để xem mình có quyền gì hoặc mình đang chia sẻ thư mục với những quyền gì thì sử dụng câu lệnh `exportfs -v`.

 - File /etc/hosts.allow và /etc/hosts.deny
Hai tập tin đặc biệt này giúp xác định các máy tính trên mạng có thể sử dụng các dịch vụ trên máy của bạn. Mỗi dòng trong nội dung file chứa duy nhất 1 danh sách gồm 1 dịch vụ và 1 nhóm các máy tính. Khi server nhận được yêu cầu từ client, các công việc sau sẽ được thực thi:

   + Kiểm tra file host.allow – nếu client phù hợp với 1 quy tắc được liệt kê tại đây thì nó có quyền truy cập.
   + Nếu client không phù hợp với 1 mục trong host.allow server chuyển sang kiểm tra trong host.deny để xem thử client có phù hợp với 1 quy tắc được liệt kê trong đó hay không (host.deny). Nếu phù hợp thì client bị từ chối truy cập.
   + Nếu client phù hợp với các quy tắc không được liệt kê trong cả 2 file thì nó sẽ được quyền truy cập.
Ví dụ: Muốn chặn hoặc cho phép một host hoặc network thì thêm vào file deny hoặc allow.


# <a name="II" >II. Thực hành 🖥️</a>
_Lưu ý: trong bài thực hành thì mình đã sử dụng tài khoản root để thực hành nên các câu lệnh sẽ không cần tiền tố sudo hay phải nhập mật khẩu root_
## <a name="II.1" >1. Chuẩn bị</a>
Ít nhất 2 máy chạy OS nhân Linux, ở đây 2 máy chạy CentOS 7. Xác định được IP của máy, Xác định IP của máy bằng câu lệnh `ip a`. Thường thì vẫn sử dụng IPv4, ta sẽ thấy IP của máy ở dòng `inet`.

Cài đặt NFS cho cả 2 máy, sử dụng câu lệnh `yum install nfs-utils nfs-utils-lib -y`.

## <a name="II.2" >2. Tiến hành lab</a>

#### <a name="2.a" ></a> 
_**a)**_ Trên máy 1, dùng để làm server chia sẻ thư mục.
Kiểm tra IP của máy chủ. `ip a`

![image](https://user-images.githubusercontent.com/79830542/173768880-7cb419a6-abbb-48da-85d2-30cab7951da6.png)

Chia sẻ thư mục có sẵn hoặc dùng câu lệnh `mkdir /share` để tạo thư mục chia sẻ có tên là share. 
Cài đặt NFS, kiểm tra version `nfsstat -s`. Ở đây là phiên bản v4, mới nhất tính đến thời điểm làm bài viết này.

<img src="https://user-images.githubusercontent.com/79830542/173769906-af841c15-b3ac-40b5-be5a-0d2e42ab2b67.png" width="600">

Tiến hành config cho server. Có 2 cách để nhận biết server hoặc client, đó là qua domain và IP. Bạn có thể cấu hình domain cho từng máy bằng cách khai báo với cú pháp `Domain = your_domain` vào trong file `/etc/idmapd.conf`.
Ở đây mình vẫn dùng IP để tiến hành config.

 - Khai báo thư mục (những thứ cần chia sẻ), máy nhận, và các quyền của máy nhận. Khai báo trong file `/etc/exports` với cú pháp:
    - `đường_dẫn_thư_mục IP-domain_của_client(quyền hạn)`, muốn public lên internet thì chỉ cần thay IP(domain) của client thành `*` là mọi máy trên internet có IP(domain) của server là có thể truy cập vào. Hay muốn chỉ định 1 domain có đuôi nhất định (ví dụ như facen.com, gulugulu.com,...) thì ta chỉ định thành `*.com` là được. Nhiều client thì các client cách nhau bởi khoảng trắng (phím tab, hay space đều được).
    - Cấu hình cho client có IP như trong hình truy cập vào thư mục `share` và quyền chỉ đọc (ro), các quyền khác là mặc định
    - Sử dụng `exportfs -a` để hệ thống cập nhật lại nội dung trong file exports.
    - ![image](https://user-images.githubusercontent.com/79830542/173772883-89448a58-e29c-4ac9-af85-55e4d1e09278.png)

 - Mở các cổng (port) mà NFS cần để vận hành. Điều này phải thông báo với firewall, khá là nguy hiểm nên cần phải để ý, không mở nhầm port.
    - Kiểm tra các port và các dịch vụ đang chạy `rpcinfo` hoặc `rpcinfo -p` [what is rpc](https://www.bing.com/search?q=rpc+l%C3%A0+g%C3%AC&cvid=e1da5b9986914b338a6a8211913737ad&aqs=edge.1.69i57j0l8.4294j0j1&pglt=299&FORM=ANNTA1&PC=U531) 
    - <img src="https://user-images.githubusercontent.com/79830542/173777277-526081d3-20ab-4b13-8fe2-626557d00c30.png" width="600">
    - Vì chưa có khai báo nên mặc định chỉ toàn là các port cần thiết của hệ thống.
    - Các port cần thiết để khởi chạy NFS: --add-service=nfs, --add-service=mountd, --add-service=rpc-bind
    - Đối với NFSv4 thì chỉ cần khai báo: `firewall-cmd --add-service=nfs --permanent` rồi `firewall-cmd --reload` để firewall cập nhật lại
    - ![image](https://user-images.githubusercontent.com/79830542/173779852-9a7a0981-328b-41c7-a55e-25921d2f7762.png)
 - Sau khi config ít điều như thế, ta sẽ start NFS `systemctl start rpcbind`, `systemctl start nfs-server.service` 
    - Dùng `systemctl status` để kiểm tra xem đã khởi chạy thành công hay chưa, như hình dưới là thành công, nếu chưa sẽ nhận thông báo đỏ (thường do lỗi cú pháp)
    - ![image](https://user-images.githubusercontent.com/79830542/173781654-98196d34-ed82-437f-b88f-fb3a9ea6d560.png)
    - Sau khi start dịch vụ thì lúc này firewall mới ghi nhận "sự có mặt" của NFS trong hệ thống và tiến hành cấp port cho các dịch vụ của NFS. Kiểm tra `rpcinfo -p`
    - <img src="https://user-images.githubusercontent.com/79830542/173785259-8ed9b2c8-f02d-45d3-822e-08e957d2d663.png" width="300">

#### <a name="2.b" ></a>
_**b)**_ Cơ bản về server thì ta sẽ config như thế, sau đây sẽ tiến hành config trên client.

 - Trên client cũng tiến hành cài đặt gói NFS như trên server. 
 - Kiểm tra xem server cung cấp các thư mục nào cho mình thì sử dụng `showmount -e <NFS_Server_IP>`
 - ![image](https://user-images.githubusercontent.com/79830542/173793121-312035f2-8968-4168-ab2e-b9ea10ba723e.png)
 - Lúc này thư mục trên server cũng là 1 thiết bị ngoại vi, muốn truy cập và sử dụng được ta cũng cần phải mount vào hệ thống. Cũng giống mount thông thường, thì có mount tạm thời và mount cố định, ở đây sẽ mount tạm thời.
    - Sử dụng câu lệnh mount với cấu trúc `mount -t nfs -o vers=<NFS_version> <Server_mount point> <client_mountpoint>`
    - ![image](https://user-images.githubusercontent.com/79830542/173795057-3fdbba9a-3b48-4f44-b9f1-6a5b57a21d3d.png)

#### <a name="2.c" >c) Trên Window</a>

  **🗒️Trên windows thì có 3 cách như sau:**
  
   - ▶️ C1: sử dụng NFS client được cài đặt sẵn trong windows 10 pro (trở lên) chỉ cần enable nó lên là được.
   
      1. Chọn Control Panel.
      2. Chọn Programs.
      3. Chọn Programs and Features.
      4. Chọn Turn Windows Features on or off.
      5. Chọn Services for NFS.
      6. Chọn the check box Client for NFS and click OK.
     
     <img src="https://user-images.githubusercontent.com/79830542/175890681-e974973a-811c-40c2-8a17-3204fbb7c5b5.png" width="">
     
      - Bây giờ bạn có thể mount bất kỳ chia sẻ NFS lên mạng của mình, Tuy nhiên khi mở ổ đĩa mount bạn thường nhân thông báo "Access is denied". Nguyên nhân là do Windows và linux sử dụng các phương thức quản lý khác nhau.

      - Bây giờ ta cần set mặc đinh anonymous UID và GID cho Client NFS để truy cập tới NFS share. Các bước thực hiện như sau:
mở hộp thoại Run bằng cách Windows + R.
      - Bật Registry Editor bặt cách gõ regedit vào run và Enter. Lưu ý nếu như có thông báo hỏi thì bạn ấn Yes trên cửa sổ User Account Control
      - Tìm đến HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default. thêm 2 giá tri DWORD: AnonymousUid và AnonymousGid.
      - Đặt giá trị cho UID và GID trên Ubuntu box. với giá trị là 1000 và 1000 (hệ thập phân) như hình dưới
      - Khởi động lại dịch vụ NFS client bằng cách khởi động lại máy. Hoặc chạy lệnh sau trong CMD với quyền Admin: nfsadmin client stop sau đó nfsadmin client start.
      - Bây giờ bạn có thể truy cập thư mục chia sẻ từ Linux trên windows
      ![image](https://user-images.githubusercontent.com/79830542/175891616-3abaa63f-64a5-4d19-9ef3-c4e52ccde7d5.png)


     Ví Dụ:
     - Trên linux:

        - Ta có thư mục chia sẻ NFS là /datachung
        - IP của máy chia sẻ linux là 66.0.0.199/24 và chia sẻ tới các máy trong mạng 66.0.0.0/24.
        - Bạn mở file etc/exports trên NFS server và thêm dòng: /datachung 66.0.0.0/24(rw,sync,no_subtree_check). Lưu lại
        - chạy lệnh exports -ra
        - Khởi động lại dịch vụ portmap và nfs

     - Trên windows:
       - Mở Command prompt (không nên chạy dưới quyền administrator).
       - Sử dụng câu lệnh: mount <tên hoặc địa chỉ máy chủ:/thư mục chia sẻ> <thư mục gắn kết (VD: X:, hay Y:, hay Z:)>
       - VD: 66.0.0.199/24:/datachung M:\
       
            ![image](https://user-images.githubusercontent.com/79830542/175895230-22b49598-9120-4afd-8a45-6bf9a52ffa00.png)
            
             Như vậy đã hoàn tất!
             Chúc bạn thành công!
             
            ![image](https://user-images.githubusercontent.com/79830542/175895360-e29e1122-7e2f-4422-b7a1-5810550dbb37.png)
            
_♨️ Chú ý: cách này khá là dài dòng vào khó hiểu cho người mới tìm hiểu, tuy nhiên ta có thể can thiệp sâu và quản lý tốt việc mount trên windows. Thường dành cho quản trị viên trên windows. Nếu có 2 người dùng cũng truy cập và chỉnh sửa 1 file thì sẽ lưu lại chỉnh sửa sau cùng.

  - ▶️ C2: dùng `Map network drive` trình tích hợp sẵn trong File Explorer trên Windows
    - Ví Dụ:
      - Trên linux: 
        - Ta có thư mục chia sẻ NFS là home/cuongnv
        - IP của máy chia sẻ linux là 192.168.0.10 và chia sẻ tới các máy trong mạng 192.168.0.0/24.
        - Bạn mở file etc/exports trên NFS server và thêm dòng: /home/cuongnv 192.168.0.0/24(rw,sync,no_subtree_check). Lưu lại
        - Chạy lệnh exports -ra (yêu cầu NFS cập nhật lại file exports)
        - Khởi động lại dịch vụ portmap và nfs

      - Trên windows:
        - Mở Computer (hoặc ấn Windows + E).
        - Click vào Map network drive trên toolbar. Hoặc chuột phải vào This PC sẽ thấy trong menu hiện ra ngay khi nhấn chuột phải.
        - Điền 192.168.0.10:/home/cuongnv vào Folder:
        - Ấn Finish. 
        - ![image](https://user-images.githubusercontent.com/79830542/175899400-8e82aa3c-e11e-4231-91ad-29505f522ccb.png)
        - Nếu kết nối thành công thì thư mục được chia sẻ cũng sẽ hiển thị như C1.

_♨️ Lưu ý: Cách này cũng khá phổ biến, nhưng trong 1 số trường hợp gây lỗi không xác định (config các port, filewall, dịch vụ TCP/IP,...), khó kiểm soát. Quyền với file tuỳ thuộc hoàn toàn vào người quản trị trên Linux._

   - ▶️ C3: Sử dụng NFSClient Application, đúng như cái tên gọi, ta sử dụng 1 ứng dụng hỗ trợ kết nối NFS trên Window. Có khá nhiều ứng dụng nhưng mình hay sử dụng NFSClient của `Decorawr`. 
      - [Link download](https://sourceforge.net/projects/nfsclient/) 
      - [Linh github](https://github.com/DeCoRawr/NFSClient) của dự án.
      - Dừng phát triển từ năm 2013 nên một số module đã cũ cần phải cài đặt lại trên môi trường Windows để có thể cài đặt được ứng dụng. [Link dowload module](https://www.microsoft.com/en-us/download/details.aspx?id=40784). 
      - <img src="https://user-images.githubusercontent.com/79830542/175906486-c9a4c941-b893-4b9f-b61c-4966a0bac32b.PNG" width="500">
      - Thông thường thì sẽ tài và cài gói x64, nếu đã cài gói x64 mà không cài đặt được ứng dụng thì đổi sang gói x86. Hiếm lắm mới gặp trường hợp phải cài gói arm.
      - Chú ý nhỏ là trong quá trình cài đặt thì sẽ có 1 hộp thoại khác hiện ra dưới Taskbar để yêu cầu cài đặt thư viện hỗ trợ. Hãy chú ý và tiến hành cài đặt thư viện đó.
      - Ứng dụng rất dễ để sử dụng, ngay khi vừa mở lên bạn chỉ cần nhập IP của server rồi connect là có thể connect được rồi. Nhấn `save` để lưu thông tin, rồi nhấn `Connect` để tiến hành kết nối.
      - ![image](https://user-images.githubusercontent.com/79830542/175907943-8f0df95b-183a-46c2-afdf-2cf9f043e5ae.png)
      - Ứng dụng còn rất nhiều chức năng hay ho có thể tự khám phá mà không sợ gây lỗi hệ thống hay gây lỗi dịch vụ mạng.
      - ![image](https://user-images.githubusercontent.com/79830542/175908349-76f23b15-6286-46aa-aed1-7060528ccb39.png)


 



# <a name="III" >III. Tài liệu tham khảo</a>
1) [Tài liệu đầy đủ về NFS (tiếng Anh)](http://nfs.sourceforge.net/nfs-howto/)

2) [huong-dan-cai-dat-va-cau-hinh-nfs-server-va-nfs-client](https://vinasupport.com/huong-dan-cai-dat-va-cau-hinh-nfs-server-va-nfs-client/)

3) [configure-nfsv3-and-nfsv4-on-centos-7](https://computingforgeeks.com/configure-nfsv3-and-nfsv4-on-centos-7/#:~:text=How%20To%20Configure%20NFSv3%20and%20NFSv4%20on%20CentOS,under%20the%20file%20%2Fetc%2Fexports.%20...%20More%20items...%20)

4) [Link trên github](https://github.com/hocchudong/ghichep-nfs/blob/master/NDChien_Baocao_NFS.md#)

5) [Link trên youtube](https://www.youtube.com/watch?v=CE_xjL_7IqA)

https://www.slideshare.net/udamale/nfsnetwork-file-system


6) [Bài lab về NFS](https://news.cloud365.vn/bai-lab-ve-nfs/)
7) [Kết nối nfs trên win](http://blog.vnaking.com/hoc-tap/linux/ket-noi-nfs-tren-win)
8) [Tài liệu tiếng Anh trên github về NFS và các thứ storage khác](https://github.com/LukeShortCloud/rootpages/blob/main/src/storage/file_systems.rst#nfs)

HaNoi, 15/6/2022

Edit, 27/06/2022
 
