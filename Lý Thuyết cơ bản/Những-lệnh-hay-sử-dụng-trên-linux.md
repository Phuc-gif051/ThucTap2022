Lệnh ssh (remote tới server linux)

ssh user@host – kết nối đến máy host với tài khoản user.
ssh -p port user@host – kết nối đến máy host qua cổng port với tài khoản user.
ssh-copy-id user@host – thêm khóa công cộng của tài khoản user vào máy host để thiết lập đăng nhập không cần mật khẩu (đăng nhập có khóa).
ssh -N -L port_local:ip_server:port_server username@ip_jump_server – forward port_server từ server về local qua jump_server, sau đó bạn có thể truy cập vào dịch vụ ở port_local.
Lệnh scp (copy file giữa các server linux)

scp filename1 user@servername:filename2 – copy file tới server
Ex: scp c:/textfile1.txt root@10.1.11.112:/root/textfile2.txt
scp -r foldername1 user@servername:foldername2 – copy folder tới server (bao gồm tất cả các file và thư mục con)
scp -u filename1 user@servername:filename2 – copy file tới server (xóa file nguồn sau khi thực hiên xong)
Lệnh liên quan đến hệ thống

shutdown now – Tắt máy
shutdown -h now – Tắt máy
telinit 0: Tắt máy – tương tự các lệnh trên
init 0: Tắt máy – tương tự các lệnh trên
halt: Tắt máy (tương tự shutdown)
shutdown -h 9:30 – Hẹn giờ tắt máy (schedule) vào lúc 9h30 (tính theo khung 24h)
shutdown -r now – Khởi động lại máy (tương đương với lệnh reboot)
shutdown -c – Hủy bỏ tất cả các lệnh tắt máy trước đó (các lệnh tắt máy theo schedule)
reboot – Khởi động lại máy
sleep 15 – Cho hệ thống ngừng hoạt động trong 15s (ngủ – tương tự Windows)
exit – thoát khỏi cửa sổ dòng lệnh.
logout – tương tự exit.
startx – khởi động chế độ xwindows từ cửa sổ terminal.
mount – gắn hệ thống tập tin từ một thiết bị lưu trữ vào cây thư mục chính.
unmount – ngược với lệnh mount.
who – hiện những user đang đăng nhập
w – hiện những user đang đăng nhập – tương tự who
whoami – hiện tên tài khoản của bạn
id – hiển thị user id
logname – Hiển thị tên user đang login
last – Hiện thị nhật ký của các phiên đăng nhập (user đăng nhập, thời gian đăng nhập, đăng xuất) vào hệ thống (lệnh này sẽ đọc từ file /var/log/wtmp)
last -10 – Tương tự như lệnh last nhưng chỉ hiện 10 kết quả gần nhất
Lệnh liên quan đến thời gian của hệ thống

uptime: hiện thời gian từ lúc bật máy
date: Xem lịch ngày, giờ hệ thống
Kiểm tra xem hệ thống có những múi giờ nào
Bước 1: cd /usr/share/zoneinfo/
Bước 2: ls
cp /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime: Chỉnh múi giờ sang Tp. Hồ Chí Minh (GMT+7)
sudo timedatectl list-timezones: Xem danh sách các múi giờ hiện có
sudo timedatectl set-timezone Asia/Ho_Chi_Minh: Chỉnh múi giờ sang Tp. Hồ Chí Minh (GMT+7)
cal: Xem lịch hệ thống
date –s “1 JAN 2018 15:29:00”: Đặt ngày giờ hệ thống theo string
date +%Y%m%d -s “20180101″: Đặt ngày hệ thống (không thay đổi giờ)
date +%T -s “00:29:00″: Đặt giờ hệ thống, không thay đổi ngày
Lệnh liên quan đến xem thông tin hệ thống

uname -a – thông tin phiên bản linux kernel
cat /etc/os-release – Kiểm tra phiên bản hệ điều hành Linux
cat /proc/cpuinfo – thông tin CPU
nproc – In ra số lượng vi xử lý
cat /proc/meminfo – thông tin bộ nhớ
cat /proc/swaps – kiểm tra thông tin SWAP của máy (tương tự như virtual RAM của Windows)
df – thông tin đĩa cứng
df -h – thông tin đĩa cứng (hiển thị trực quan hơn dưới dạng GB)
df -m – thông tin đĩa cứng (hiển thị trực quan hơn dưới dạng MB)
df -BM – thông tin đĩa cứng
free – thông tin bộ nhớ trống và swap
free -m – thông tin bộ nhớ trống và swap (hiển thị trực quan hơn dưới dạng MB)
Lệnh liên quan đến network

ip a – xem địa chỉ IP version 4
ip route – xem default gateway
cat /etc/resolv.conf – xem khai báo DNS server
ping ip_host – ping đến host
dig domain – lấy thông tin DNS cho domain
wget file – tải file
curl url – Xem mã html của URL
curl --head url – xem phần header của URL
wget – Tải các ứng dụng từ một website về
telnet ip port – kiểm tra xem port đó có hoạt động không
netstat -tulpn | grep LISTEN – Xem các cổng đang hoạt động
netstat -n | grep :port_number – Hiển thị các kết nối ở một port cụ thể
Lệnh này có thể kết hợp thêm một số tùy chọn để kiểm tra server khi bị DDoS
netstat -n | grep :80 | wc -l – Đếm số connection vào port 80
netstat -n | grep :80 | grep SYN_RECV | wc -l – Kiểm tra số lượng connection đang ở trạng thái SYN_RECV
netstat -an | grep :80 | awk ‘{print $5}’ | cut -d”:” -f1 | sort | uniq -c | sort -rn – Hiển thị tất cả các IP đang kết nối và số lượng kết nối từ mỗi IP.
nslookup – Truy vấn DNS để lấy thông tin về tên miền hoặc địa chỉ IP
dig – Truy vấn DNS để lấy thông tin về tên miền hoặc địa chỉ IP
nmap – Quét mạng để khám phá máy chủ và dịch vụ
tcpdump – Chụp và hiển thị các gói trên mạng
Lệnh liên quan đến tìm kiếm

grep ‘word’ file1 file2 … – tìm kiếm ‘word’ trong file1, file2 …
grep -rnw ‘/path/to/somewhere/’ -e ‘word’ – tìm kiếm các file chứa ‘word’ trong thư mục
locate “*.png” – tìm vị trí theo tên file
find / -type d -name ‘folder_name’ – tìm kiếm folder trên toàn hệ thống
grep -r “word” path – tìm kiếm “word” trong tất cả các file ở path
Lệnh liên quan đến quản lý các dịch vụ trên hệ thống

systemctl list-units – Hiển thị tất cả các services trên hệ thống
systemctl start service-name – Khởi động dịch vụ
systemctl stop service-name – Dừng dịch vụ
systemctl restart service-name – Khởi động lại dịch vụ
systemctl status service-name – Kiểm tra trạng thái của dịch vụ
systemctl show service-name – Xem các thông tin chi tiết về dịch vụ
systemctl cat service-name – Xem các file cấu hình của dịch vụ
systemctl enable service-name – Khởi động dịch vụ cùng OS
systemctl disable service-name – Ngăn dịch vụ khởi động cùng OS
Lệnh liên quan đến firewall

systemctl status firewalld – Kiểm tra trạng thái firewall
systemctl disable firewalld – Không khởi động firewall cùng OS
systemctl stop firewalld – Dừng firewall
systemctl enable firewalld – Khởi động firewall cùng OS
systemctl start firewalld – Khởi động firewall
Mở cổng 8080 trên linux
firewall-cmd - -permanent --zone=public --add-port=8080/tcp
firewall-cmd --reload
Lệnh liên quan đến tiến trình

top – xem các tiến trình đang chạy
htop – xem các tiến trình đang chạy một cách trực quan hơn (phải cài htop)
ps – liệt kê các tiến trình
ps -aux – xem toàn bộ các tiến trình đang chạy
ps -ef | grep keyword – lọc các tiến trình đang chạy theo keyword (Ex: ps -ef | grep java – xem các app java đang chạy)
Ctrl + Z – tạm ngưng 1 tiến trình
kill -15 PID – dừng tiến trình theo PID (-15 tức là gửi tín hiệu SIGTERM cho process)
kill -9 PID – dừng tiến trình theo PID (-9 tức là gửi tín hiệu SIGKILL cho process)
pkill -15 process_name – dừng tiến trình theo process name (-15 tức là gửi tín hiệu SIGTERM cho process) – các tín hiệu khác tương tự lệnh kill
killall [process name] – dừng tiến trình theo process name – tương tự như pkill nhưng khác ở chỗ killall sẽ chấm dứt tất cả các tiến trình theo tên chính xác, còn pkill chỉ cần đúng đoạn đầu của tên process là được. Theo mặc định killall sẽ gửi tín hiệu SIGTERM tới process. Nếu muốn gửi tín hiệu SIGKILL cho process thì dùng chỉ định thêm -s (killall -s [process name]).
Lệnh liên quan đến file, thư mục

ncdu: (NCurse Disk Usage) thống kê dung lượng ổ cứng.
Nếu chưa có ncdu thì phải cài đặt
Ubuntu: apt-get install ncdu
CentOS: yum install ncdu
du -sh file_path: xem dung lượng của thư mục hoặc file.
du -sh .[!.]* * | sort -h – xem dung lượng của thư mục hoặc file (gồm cả file ẩn) và sắp xếp theo thứ tự tăng dần.
du – hiển thị danh sách tất cả các file và dung lượng của chúng trong thư mục hiện tại
du -sh – thông tin dung lượng của thư mục hiện tại
du --max-depth=1 -B M | sort -rn – thông tin thư mục, xếp theo dung lượng
du -sh * – hiển thị danh sách các file và dung lượng của chúng trong thư mục hiện tại (không bao gồm các file và thư mục ẩn)
du -sh $(ls -A) – hiển thị danh sách các file và dung lượng của chúng trong thư mục hiện tại (bao gồm các file và thư mục ẩn)
find /path/to/folder -mtime +90 -print – Hiển thị danh sách các file không được chỉnh sửa trong vòng 90 ngày
find /path/to/folder -mtime +90 -delete – Xóa các file không được chỉnh sửa trong vòng 90 ngày
find /path/to/folder -mtime +90 -exec rm {} + – Xóa các file không được chỉnh sửa trong vòng 90 ngày, tương tự lệnh trên, sử dụng cho các version lệnh find không hỗ trợ option -delete
ls: lấy danh sách tất cả các file và thư mục trong thư mục hiện hành.
pwd: xuất đường dẫn của thư mục làm việc.
cd: thay đổi thư mục làm việc đến một thư mục mới.
cd /: thay đổi đến thư mục gốc
cd /etc: thay đổi đến thư mục etc
cd -: quay lại thư mục trước đó
mkdir: tạo thư mục mới.
rmdir: xoá thư mục rỗng.
rm : xóa file hoặc thư mục.
rm -f: xóa file không cần hỏi
cp file1 file2: copy một hay nhiều tập tin đến thư mục mới.
cp -a source_folder/. dest_folder/: chỉ copy nội dung từ thư mục source_foler sang thư mục dest_folder (có dấu chấm nhé, nếu không thì sẽ copy thư mục source_folder vào thư mục dest_folder :D)
mv file1 file2: – di chuyển file, đổi tên file.
mv: đổi tên hay di chuyển tập tin, thư mục.
rm file: xóa tập tin.
wc: đếm số dòng, số kí tự… trong tập tin.
touch file: tạo một tập tin.
cat file: xem nội dung tập tin.
vi: khởi động trình soạn thảo văn bản vi.
nano: Khởi dộng trình soạn thảo văn bản nano
less: Hiển thị nội dung của tệp trên một trang tại một thời điểm
tail filename: Xem nội dung tập tin (mặc định xem 10 dòng cuối, muốn xem 100 dòng cuối thì dùng lệnh sau: tail 100 tenfile)
head filename: Xem nội dung tập tin (mặc định xem 10 dòng đầu, muốn xem 100 dòng đầu thì dùng lệnh sau: head 100 tenfile)
tail -100 filename: Xem 100 dòng cuối cùng của file.
tail -f -n 100 filename: Xem 100 dòng cuối cùng và follow tiếp nội dung được thêm vào của file (rất thuận tiện để xem log và trace lỗi)
more: Xem nội dung tập tin theo trang
ln -s file link: tạo symbolic link (‘link’ trỏ đến file)
Lệnh liên quan đến làm việc với các thiết bị

lsblk – Liệt kê các thiết bị lưu trữ (ví dụ: ổ cứng, ổ USB)
lspci – Liệt kê các thiết bị PCI (ví dụ: card mạng, card đồ họa)
lsusb – Liệt kê các thiết bị USB
lshw – Liệt kê các thiết bị phần cứng và thuộc tính của chúng
lsscsi – Liệt kê các thiết bị SCSI (ví dụ: ổ cứng, ổ băng từ)
dmesg – Hiển thị nhật ký thông báo nhân của hệ điều hành OS kennel
Lệnh liên quan đến user, group

cat /etc/passwd – Xem danh sách user
cat /etc/group – Xem danh sách group
passwd user – Đổi mật khẩu (standard user có thể đổi pass của họ còn user root thì thay đổi được password của mọi user)
pwck – Kiểm tra syntax và định dạng của dữ liệu user/password (/etc/passwd)
useradd user – Tạo user mới, ví dụ: useradd -c “test user 1” -g group1
useradd --comment 'User 1' --create-home user1 --shell /bin/bash – Tạo user mới, tạo thư mục /home/user1 cho user và chỉ định shell cho user là bash (co thể để là /bin/sh nếu muốn để shell cho user là sh)
userdel user – Xóa User
userdel -r user – Xóa user và data đính kèm (thư mục /home/user)
usermod – Thay đổi thông tin user (group, name…)
groupadd group – Tạo một nhóm user mới
groupdel group – Xóa nhóm user
groupmod – Thay đổi thông tin group, ví dụ, groupmod -n “old group name” “new name”
usermod -a -G groupname username: Thêm user vào group
gpasswd -d user group – Xóa user khỏi group
id user – Kiểm tra xem user thuộc các group nào
su user – Cho phép đăng nhập với tên user khác (tương tự secondary logon của Windows)
groups– Hiển thị nhóm của user hiện tại
chmod [folder_name][/file_name] – Thay đổi quyền cho thư mục/file (chỉ user sở hữu file mới thực hiện được)
chown user [folder_name][/file_name] – Thay đổi chủ sở hữu thư mục/file
Ex: chown -R user:user folder
chgrp group [folder_name][/file_name] – Thay đổi group sở hữu thư mục/file
Lệnh liên quan đến nén file

tar -cvf /tenfilenen.tar /thu-muc-can-nen – nén thư mực vào .tar
c – Tạo file .tar mới
v – Hiển thị quá trình lên màn hình
f – Tên file
tar -zcvf /tenfilenen.tar.gz /thu-muc-can-nen – nén thư mục vào file .tar.gz (nén file .tar.gz thậm chí còn mạnh hơn file .tar và cho ra dung lượng file nén nhỏ hơn)
tar -xvf file-nen.tar[file-nen.tar.gz] – giải nén cho cả file .tar và file .tar.gz
gzip file – nén file thành file.gz
gzip cho phép bạn chọn mức nén trong khoảng từ 1 => 9
-1 (–fast) là tốc độ nén nhanh nhất và tỉ lệ nén dung lượng tối thiểu nhất.
-9 (-best-) là tốc độ nén chậm nhất và tỉ lệ nén dung lượng tốt nhất.
Mặc định mức nén là 6
Example: gzip -9 file (Lưu ý rằng khi bạn chạy thuật toán nén gzip thì CPU hoạt động rất cao, vì vậy nếu chạy trên VPS yếu thì nguy cơ CPU quá tải là điều có thể xảy ra.)
gzip -d file.gz – giải nén file.gz
Một số phím tắt, thủ thuật khi gõ lệnh linux

↑ or ↓ – nhắc lệnh vừa gõ
Ctrl + c – dừng hoàn toàn lệnh đang chạy
clear or Ctrl + l – Xóa màn hình
Ctrl + u – Xóa lệnh hiện tại đang gõ
Ctrl + a – Về lại đầu dòng lệnh
Ctrl + e – Đi đến cuối dòng lệnh
Ctrl + u – Cắt từ đầu dòng
Ctrl + k – Cắt đến cuối dòng
Tab – nhắc lệnh hoặc file
history – xem lịch sử các lệnh đã gõ
history | grep keyword – lọc lịch sử các lệnh đã theo keyword
Ctrl + r – tìm kiếm lại lệnh đã gõ
Ctrl + z – tạm ngưng một tiến trình
Ctrl + d – thoát khỏi phiên làm việc hiện tại – giống với exit
Ctrl + ] —> q – thoát khỏi lệnh telnet khi Ctrl + C không hoạt động
