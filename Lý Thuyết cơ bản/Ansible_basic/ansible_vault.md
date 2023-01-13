_Tài liệu về mã hoá dữ hiệu nâng cao bảo mật trong Ansible với mở rộng: Ansible-vault_

####

Về cơ bản tất cả mọi thứ cần được bảo mật, Ansible cũng thế. Các dữ liệu nhạy cảm cần phải được bảo mật trong một vài trường hợp nhất định để đảm bảo an toàn cho hệ thống mà ta triển khai.

Và ansible-vault hỗ trợ việc bảo mật này bằng cách mã hoá dữ liệu nhạy cảm với các thuật toán mã hoá, đặt mật khẩu cho file đã được mã hoá.

Thông thường có 2 cách triển khai mã hoá đó là:

- Tạo 1 file mới với khai báo là file mã hoá:

```sh
ansible-vault create <name/path-file>
```

