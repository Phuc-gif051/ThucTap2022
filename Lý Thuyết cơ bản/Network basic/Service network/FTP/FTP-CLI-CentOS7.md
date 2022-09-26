## Sử dụng FTP bằng câu lệnh trên CentOS 7
[1. Tổng quan](#about)

[2. Thiết lập kết nối SFTP](#set-connection)

[3. Xem các lệnh SFTP hỗ trợ](#help)

[4. Điều hướng với SFTP](#control)

[5. Truyền file bằng SFTP](#tranfer)
      - [1. Upload](#upload)
      - [2. Download](#download)

[6. Thực hiện các tác vụ trên remote server với SFTP](#action)

[7. Tài liệu tham khảo](#referent)

___

<a name="about"></a>
### Tổng quan

SFTP (SSH File Transfer Protocol) là một giao thức truyền file an toàn được sử dụng để truy cập, quản lý và truyền file thông qua SSH được mã hóa.

Khi so sánh với giao thức FTP truyền thống, SFTP cung cấp tất cả các chức năng của FTP và được thêm bảo mật từ SSH.

Không giống như lệnh scp, chỉ cho phép truyền file, lệnh sftp cho phép bạn thực hiện một loạt các hoạt động trên các file từ xa.

<a name="set-connection"></a>
### Thiết lập kết nối SFTP
SFTP hoạt động trên mô hình client-server, hỗ trợ tất cả các cơ chế xác thực SSH.

Để mở kết nối SFTP với remote system, hãy sử dụng lệnh sftp theo sau là tên remote user và địa chỉ IP hoặc tên miền:

      # $sftp remote_username@server_ip_or_hostname
      
Sau khi kết nối, bạn sẽ thấy dấu nhắc sftp và bạn có thể bắt đầu tương tác với remote server:

      # Connected to remote_username@server_ip_or_hostname.
      # sftp>
      
Nếu máy chủ SSH từ xa không lắng nghe trên cổng 22, hãy sử dụng tùy chọn -oPort để chỉ định cổng thay thế:

      # sftp -oPort=port remote_username@server_ip_or_hostname

<a name="help"></a>
### Xem các lệnh SFTP hỗ trợ
Hầu hết các lệnh SFTP tương tự hoặc giống hệt với các lệnh bạn sẽ sử dụng trong dấu nhắc shell của Linux.

Bạn có thể nhận được danh sách tất cả các lệnh SFTP có sẵn bằng cách nhập `help` hoặc `?`

          sftp> help
          Available commands:
          bye                                Quit sftp
          cd path                            Change remote directory to 'path'
          ...
          ...
          version                            Show SFTP version
          !command                           Execute 'command' in local shell
          !                                  Escape to local shell
          ?                                  Synonym for help

<a name="control" ></a>
### Điều hướng với SFTP

- Khi bạn đăng nhập vào remote server, thư mục làm việc hiện tại của bạn là thư mục home của remote user. Bạn có thể kiểm tra bằng cách gõ:

        # sftp> pwd
        Remote working directory: /home/remote_username

 - Để liệt kê các tập tin và thư mục sử dụng lệnh ls:

        # sftp> ls
        
 - Để di chuyển đến thư mục khác, sử dụng lệnh cd. Ví dụ: để chuyển sang thư mục /tmp, bạn sẽ gõ lệnh như sau:

        # sftp> cd /tmp
        
Các lệnh trên được sử dụng để điều hướng và làm việc trên remote server.

 - sftp cũng cung cấp các lệnh để điều hướng cục bộ với việc sử dụng thêm tiền tố l ở phía trước các lệnh.

        # sfpt>cd lpwd
        # Local working directory: /home/local_username
 
 <a name="tranfer" ></a>
 ### Truyền file bằng SFTP
 
 Với SFTP, bạn có thể chuyển tập tin an toàn giữa hai máy. Lệnh sftp rất hữu ích khi bạn làm việc trên máy chủ không có giao diện GUI và bạn muốn chuyển file hoặc thực hiện các thao tác khác trên các tệp từ xa.
 
 <a name="upload" ></a>
 #### Upload file bằng lệnh SFTP
 
- Để upload một file từ local lên remote SFTP server, sử dụng lệnh put:

         # sftp>put filename.zip
         
 - Bạn sẽ thấy đầu ra như sau:

            Uploading filename.zip to /home/remote_username/filename.zip
            filename.zip                          100%   12MB   1.7MB/s   00:06

 - Để tải lên một thư mục từ local lên remote SFTP server:

         # sftp>put -r locale_directory

 - Để tiếp tục tải lên nếu bị gián đoạn:

         # sftp>reput filename.zip

<a name="download" ></a>
#### Tải file bằng lệnh SFTP

- Khi tải xuống file bằng lệnh sftp, các file được tải xuống thư mục mà bạn đã nhập lệnh sftp. Để tải xuống một file từ remote server, hãy sử dụng lệnh get:

            sftp>get filename.zip

- Bạn sẽ thấy đầu ra như sau:

            Fetching /home/remote_username/filename.zip to filename.zip
            /home/remote_username/filename.zip                           100%   24MB   1.8MB/s   00:13

- Để tải xuống một thư mục từ remote server, hãy sử dụng tùy chọn -r:

            sftp>get -r remote_directory

- Nếu quá trình truyền file không thành công hoặc bị gián đoạn, bạn có thể tiếp tục lại bằng lệnh reget. Cú pháp của reget giống với cú pháp của get:

            sftp>reget filename.zip

<a name="action" ></a>
### Thực hiện các tác vụ trên remote server với SFTP

Thông thường khi kết nối với server thông qua SSH ta cũng có quyền điều khiển các file hay thư mục như một người dùng local (với các quyền mà quản trị cấp). Tuy nhiên, với một số trường hợp thì ta chỉ có thể dùng SFTP để kết nối đến server, và chỉ được thực hiện các thao tác lưu trữ.
SFTP cho phép bạn thực hiện một số lệnh thao tác trên file cơ bản. Dưới đây là một số ví dụ về cách sử dụng shell SFTP:

 - Nhận thông tin về remote system disk usage:

            sftp>df

 - Đầu ra tương tự như sau

                Size         Used        Avail       (root)    %Capacity
            20616252      1548776     18002580     19067476           7%

 - Tạo một thư mục mới trên remote server:

            sftp>mkdir directory_name

 - Đổi tên một tệp trên remote server:

            sftp>rename file_name new_file_name

 - Xóa một tập tin trên remote server:
                  
            sftp>rm file_name

 - Xóa một thư mục trên remote server:

            sftp>rmdir directory_name

 - Thay đổi quyền của file trên remote server:

            sftp>chmod 644 file_name

 - Thay đổi chủ sở hữu của một file trên remote server:

            sftp>chown user_id file_name

 - Thay đổi chủ sở hữu nhóm của một file trên remote server:

            sftp>chgrp group_id file_name

**Khi bạn đã hoàn thành công việc của mình, hãy đóng kết nối bằng cách gõ `bye` hoặc `quit`.


<a name="referent" ></a>
### Tài liệu tham khảo

https://huudoanh.com/huong-dan-su-dung-lenh-sftp-tren-linux/

https://www.digitalocean.com/community/tutorials/how-to-use-sftp-to-securely-transfer-files-with-a-remote-server
