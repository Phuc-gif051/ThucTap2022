_Tài liệu về mã hoá dữ hiệu nâng cao bảo mật trong Ansible với mở rộng: Ansible-vault_

## Giới thiệu

Về cơ bản tất cả mọi thứ cần được bảo mật, Ansible cũng thế. Các dữ liệu nhạy cảm cần phải được bảo mật trong một vài trường hợp nhất định để đảm bảo an toàn cho hệ thống mà ta triển khai.

Và ansible-vault hỗ trợ việc bảo mật này bằng cách mã hoá dữ liệu nhạy cảm với các thuật toán mã hoá, đặt mật khẩu cho file đã được mã hoá.

## Tạo file được mã hóa mới

Để tạo một file mới được mã hóa bằng Vault, hãy sử dụng lệnh ansible-vault create . Nhập tên của file bạn muốn tạo. Ví dụ: để tạo file YAML được mã hóa có tên là vault.yml để lưu trữ các biến nhạy cảm, có thể chạy lệnh:

```sh
ansible-vault create vault.yml
```

Bạn sẽ được yêu cầu nhập và xác nhận password:

```sh
New Vault password:  
Confirm New Vault password: 
```

Khi bạn đã xác nhận password của bạn , Ansible sẽ ngay lập tức mở một cửa sổ chỉnh sửa, nơi bạn có thể nhập nội dung mong muốn của bạn.

Để kiểm tra chức năng mã hóa, hãy nhập một số văn bản:

```sh
vault.yml
Secret information 
```

Ansible sẽ mã hóa nội dung khi bạn đóng file . Nếu bạn kiểm tra file , thay vì nhìn thấy các từ bạn đã nhập, bạn sẽ thấy một khối được mã hóa:

```sh
cat vault.yml
```

Output

```sh
$ANSIBLE_VAULT;1.1;AES256 65316332393532313030636134643235316439336133363531303838376235376635373430336333 3963353630373161356638376361646338353763363434360a363138376163666265336433633664 30336233323664306434626363643731626536643833336638356661396364313666366231616261 3764656365313263620a383666383233626665376364323062393462373266663066366536306163 31643731343666353761633563633634326139396230313734333034653238303166 
```

Ta có thể thấy một số thông tin tiêu đề mà Ansible sử dụng để biết cách xử lý file , tiếp theo là nội dung được mã hóa, hiển thị dưới dạng số.

## Mã hóa các file hiện có

Nếu bạn đã có một file mà bạn muốn mã hóa bằng Vault, hãy sử dụng lệnh ansible-vault encrypt để thay thế.

Để thử nghiệm, ta có thể tạo một file ví dụ bằng lệnh :

```sh
echo 'unencrypted stuff' > encrypt_me.txt
```

Bây giờ, bạn có thể mã hóa file hiện có bằng lệnh :

```sh
ansible-vault encrypt encrypt_me.txt
```

Bạn sẽ được yêu cầu cung cấp và xác nhận password . Sau đó, một thông báo sẽ xác nhận mã hóa:

```sh
New Vault password:  
Confirm New Vault password: 
Encryption successful 
```

Thay vì mở cửa sổ chỉnh sửa, ansible-vault sẽ mã hóa nội dung của file và ghi nó trở lại đĩa, thay thế version không được mã hóa.

Nếu ta kiểm tra file , ta sẽ thấy một mẫu mã hóa tương tự:

```sh
cat encrypt_me.txt
```

Output

```sh
$ANSIBLE_VAULT;1.1;AES256 66633936653834616130346436353865303665396430383430353366616263323161393639393136 3737316539353434666438373035653132383434303338640a396635313062386464306132313834 34313336313338623537333332356231386438666565616537616538653465333431306638643961 3636663633363562320a613661313966376361396336383864656632376134353039663662666437 39393639343966363565636161316339643033393132626639303332373339376664
```

Như bạn thấy , Ansible mã hóa nội dung hiện có giống như cách nó mã hóa các file mới.

## Xem các file được mã hóa

Đôi khi, bạn có thể cần phải tham chiếu đến nội dung của file được mã hóa vault mà không cần chỉnh sửa hoặc ghi nó vào hệ thống file không được mã hóa. Lệnh `ansible-vault view` cung cấp nội dung của file để chuẩn hóa. Theo mặc định, điều này nghĩa là nội dung được hiển thị trong terminal .

Chuyển file được mã hóa vault vào lệnh:

```sh
ansible-vault view vault.yml
```

Bạn cần nhập password của file . Sau khi nhập thành công, nội dung sẽ được hiển thị:

```sh
Vault password: Secret information 
```

Như bạn thấy , dấu nhắc password được trộn vào kết quả của nội dung file . Hãy nhớ điều này khi sử dụng `ansible-vault view` trong các quy trình tự động.

## Giải mã các file được mã hóa

Để giải mã file được mã hóa vault, hãy sử dụng lệnh ansible-vault decrypt .

>Lưu ý: Do khả năng vô tình đưa dữ liệu nhạy cảm của dự án tăng lên, lệnh `ansible-vault decrypt` chỉ được đề xuất khi bạn muốn xóa mã hóa vĩnh viễn khỏi file . Nếu bạn cần xem hoặc chỉnh sửa file được mã hóa vault, thường tốt hơn là sử dụng `ansible-vault view` hay `ansible-vault edit`.

Nhập tên của file được mã hóa:

```sh
ansible-vault decrypt vault.yml
```

Bạn sẽ được yêu cầu nhập password mã hóa cho file . Sau khi bạn nhập đúng password , file sẽ được giải mã:

```sh
Vault password: Decryption successful 
```

Nếu bạn xem lại file , thay vì mã hóa vault, bạn sẽ thấy nội dung thực của file :

```sh
cat vault.yml 
```

Output:

```sh
Vault password: Secret information 
```

Tệp của bạn bây giờ không được mã hóa trên đĩa. Đảm bảo xóa mọi thông tin nhạy cảm hoặc mã hóa lại file khi bạn hoàn tất.

## Thay đổi password của các file được mã hóa

Nếu bạn cần thay đổi password của file được mã hóa, hãy sử dụng lệnh `ansible-vault rekey` :

```sh
ansible-vault rekey encrypt_me.txt
```

Khi bạn nhập lệnh, trước tiên bạn sẽ được yêu cầu với password hiện tại của file :

```sh
Vault password:
```

Sau khi nhập nó, bạn cần chọn và xác nhận password vault mới :

```sh
New Vault password: 
Confirm New Vault password: 
```

Khi bạn đã xác nhận thành công password mới, bạn sẽ nhận được thông báo cho biết quá trình mã hóa lại thành công:

```sh
Rekey successful 
```

Bây giờ có thể truy cập file bằng password mới. Mật khẩu cũ sẽ không hoạt động nữa.

## Sử dụng dấu nhắc tương tác

Cách đơn giản nhất để giải mã nội dung trong thời gian chạy là Ansible nhắc bạn về thông tin đăng nhập thích hợp. Bạn có thể thực hiện việc này bằng cách thêm `--ask-vault-pass` vào bất kỳ ansible hoặc `ansible-playbook` . Ansible sẽ nhắc bạn nhập password mà nó sẽ sử dụng để cố gắng giải mã mọi nội dung được bảo vệ bởi vault mà nó tìm thấy.

Ví dụ: nếu ta cần sao chép nội dung của file được mã hóa vault sang server lưu trữ, ta có thể làm như vậy với module copy và cờ `--ask-vault-pass`. Nếu file thực sự chứa dữ liệu nhạy cảm, rất có thể bạn cần khóa quyền truy cập trên server từ xa với các hạn chế về quyền và quyền sở hữu.

Lưu ý: Ta đang sử dụng localhost làm server đích trong ví dụ này để giảm thiểu số lượng server được yêu cầu, nhưng kết quả sẽ giống như nếu server thực sự ở xa:

```sh
ansible --ask-vault-pass -bK -m copy -a 'src=secret_key dest=/tmp/secret_key mode=0600 owner=root group=root' localhost
```

Nhiệm vụ của ta chỉ định rằng quyền sở hữu của file phải được thay đổi thành root , do đó, quyền quản trị là bắt buộc. Cờ -bK yêu cầu Ansible nhắc nhập password sudo cho server đích, vì vậy bạn cần nhập password sudo của bạn . Sau đó, bạn cần nhập password Vault:

```sh
SUDO password: 
Vault password: 
```

Khi password được cung cấp, Ansible sẽ cố gắng thực thi tác vụ, sử dụng password Vault cho các file được mã hóa nào mà nó tìm thấy. Lưu ý tất cả các file được tham chiếu trong quá trình thực thi phải sử dụng cùng một password :

```sh
localhost | SUCCESS => {     "changed": true,      "checksum": "7a2eb5528c44877da9b0250710cba321bc6dac2d",      "dest": "/tmp/secret_key",      "gid": 0,      "group": "root",      "md5sum": "270ac7da333dd1db7d5f7d8307bd6b41",      "mode": "0600",      "owner": "root",      "size": 18,      "src": "/home/sammy/.ansible/tmp/ansible-tmp-1480978964.81-196645606972905/source",      "state": "file",      "uid": 0 }
```

Nhắc password là an toàn, nhưng có thể tẻ nhạt, đặc biệt là khi chạy lặp lại và cũng cản trở quá trình tự động hóa. Rất may, có một số lựa chọn thay thế cho những tình huống này.

## Sử dụng Ansible Vault với file password

Nếu bạn không muốn nhập password Vault mỗi khi thực thi một tác vụ, bạn có thể thêm password Vault của bạn vào một file và tham chiếu file trong quá trình thực thi.

Ví dụ: bạn có thể đặt password của bạn trong file .vault_pass như sau:

```sh
echo 'my_vault_password' > .vault_pass
```

Nếu bạn đang sử dụng kiểm soát version , hãy đảm bảo thêm file password vào file bỏ qua của phần mềm kiểm soát version của bạn để tránh vô tình phạm phải:

```sh
echo '.vault_pass' >> .gitignore
```

Bây giờ, bạn có thể tham chiếu file thay thế. `--vault-password-file` có sẵn trên dòng lệnh. Ta có thể hoàn thành nhiệm vụ tương tự từ phần cuối cùng bằng lệnh :

```sh
ansible --vault-password-file=.vault_pass -bK -m copy -a 'src=secret_key dest=/tmp/secret_key mode=0600 owner=root group=root' localhost 
```

Bạn sẽ không được yêu cầu nhập password Vault lần này.

## Tự động đọc file password

Để tránh phải cung cấp cờ, bạn có thể đặt biến môi trường ANSIBLE_VAULT_PASSWORD_FILE với đường dẫn đến file password :

```sh
export ANSIBLE_VAULT_PASSWORD_FILE=./.vault_pass 
```

Đến đây bạn có thể thực thi lệnh mà không có --vault-password-file cho phiên hiện tại:

```sh
ansible -bK -m copy -a 'src=secret_key dest=/tmp/secret_key mode=0600 owner=root group=root' localhost
```

Để làm cho Ansible biết vị trí file password qua các phiên, bạn có thể chỉnh sửa file ansible.cfg của bạn .

Mở file ansible.cfg local mà ta đã tạo trước đó:

```sh
vi ansible.cfg 
```

Trong phần `defaults` , hãy đặt cài đặt vault_password_file . Trỏ đến vị trí của file password của bạn. Đây có thể là một đường dẫn tương đối hoặc tuyệt đối, tùy thuộc vào đường dẫn nào hữu ích nhất cho bạn:

```sh
ansible.cfg
[defaults] 
. . . 
vault_password_file = ./.vault_pass 
```

Bây giờ, khi bạn chạy các lệnh yêu cầu giải mã, bạn sẽ không còn được yêu cầu nhập password vault nữa. Như một phần thưởng, ansible-vault sẽ không chỉ sử dụng password trong file để giải mã các file nào, mà nó sẽ áp dụng password khi tạo file mới với ansible-vault create và ansible-vault encrypt .

## Đọc password từ một biến môi trường

Bạn có thể lo lắng về việc vô tình chuyển file password của bạn vào repository khác của bạn. Thật không may, trong khi Ansible có một biến môi trường để trỏ đến vị trí của file password , nó không có biến môi trường để tự đặt password .

Tuy nhiên, nếu file password của bạn có thể thực thi, Ansible sẽ chạy nó dưới dạng tập lệnh và sử dụng kết quả kết quả làm password . Trong một vấn đề GitHub , Brian Schwind đề xuất có thể sử dụng tập lệnh sau để lấy password từ một biến môi trường.

Mở file .vault_pass trong editor :

```sh
vi .vault_pass
```

Thay thế nội dung bằng tập lệnh sau:

```sh
#!/usr/bin/env python  import os print os.environ['VAULT_PASSWORD']
```

Làm cho file có thể thực thi bằng lệnh :

```sh
chmod +x .vault_pass
```

Sau đó, bạn có thể đặt và xuất biến môi trường VAULT_PASSWORD , biến này sẽ có sẵn cho phiên hiện tại của bạn:

```sh
export VAULT_PASSWORD=my_vault_password
```


Bạn sẽ phải làm điều này vào đầu mỗi phiên Ansible, điều này nghe có vẻ bất tiện. Tuy nhiên, điều này bảo vệ hiệu quả khỏi việc vô tình sử dụng password mã hóa Vault của bạn, điều này có thể có những nhược điểm nghiêm trọng.


## Tài liệu tham khảo

<https://galaxyz.net/cach-su-dung-vault-de-bao-ve-du-lieu-nhay-cam-co-the-xem-duoc-tren-ubuntu-1604.2272.anews>

<https://docs.ansible.com/ansible/latest/cli/ansible-vault.html>

date accessed: 18/05/2023
