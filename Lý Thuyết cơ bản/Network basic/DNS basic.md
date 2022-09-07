# Giới thiệu cơ bản về DNS
[I. DNS (Domain Name System)](#I)

[II. Tên miền](#II)

[III. Các khái niệm trong hệ thống DNS](#III)

___

# <a name="I" >I. DNS (Domain Name System)</a>

Toàn bộ máy tính trên Internet, từ smart phone, laptop, PC đến các server phục vụ các service như websites, mail,.. đều giao tiếp với nhau thông qua địa chỉ IP. Tuy nhiên, địa chỉ IP này đối với các website có thể khác nhau và khó ghi nhớ đối với người dùng.

Hệ thống DNS nắm vai trò như một cuốn “danh bạ” để đối chiếu với tên miền và trả lại cho người dùng IP của máy chủ.

Địa chỉ IP của một tên miền cụ thể có thể kiểm tra thông qua việc sử dụng lệnh ping trong cmd (Windows):

<p align="center">
  <img src="https://user-images.githubusercontent.com/79830542/188809579-86f142d6-227d-4f34-868b-9c987ff2f833.png" width="">
</p>

# <a name="II" >II. Tên miền</a>

<p align="center">
  <img src="https://user-images.githubusercontent.com/79830542/188809804-6a9b5739-4caa-423e-9b8b-91ea0f7de17b.png" width="">
</p>  

  - `Tên miền gốc (root domain):` Nó là đỉnh của nhánh cây của tên miền. Nó có thể biểu diễn đơn giản chỉ là dấu chấm “.”
  - `Tên miền cấp cao nhất - Top-level domain (TLD):` op-level domain nằm ở đầu phân cấp về tên miền. ICANN (Internet Corporation for Assigned Names and Numbers) là tổ chức được cấp quyền kiểm soát quản lý đối với các tên miền cấp cao nhất. Sau đó có thể phân phối tên miền bên dưới TLD, thường thông qua một công ty đăng ký tên miền (domain registrar). Top-level domain là phần xa nhất ở bên phải (được phân tách bằng dấu chấm). Các tên miền cấp cao phổ biến là “com”, “net”, “org”, “gov”, “edu”,..
    - Com: Tên miền này được dùng cho các tổ chức thương mại.
    - Edu: Tên miền này được dùng cho các cơ quan giáo dục, trường học.
    - Gov: Tên miền này được dùng cho các tổ chức chính phủ.
    - Info: Tên miền này dùng cho việc phục vụ thông tin.
    - Xem chi tiết hơn về các đuôi tên miền [tại đây.](https://quantrimang.com/lang-cong-nghe/cac-duoi-ten-mien-com-net-org-co-y-nghia-gi-166016)

  - `Host:` Với tên miền, chủ sở hữu có thể tham chiếu đến các máy tính hoặc dịch vụ riêng biệt. Chẳng hạn, hầu hết chủ sở hữu tên miền làm cho máy chủ web của họ có thể truy cập được thông qua tên miền (cloud365.vn) và cũng thông qua định nghĩa “máy chủ” “www” (www.cloud365.vn).
  - `Tên miền con (Subdomain):` DNS hoạt động theo thứ bậc. TLD có thể có nhiều tên miền bên dưới. Chẳng hạn, TLD “com” có cả “google.com” và “nhanhoa.com” bên dưới nó. “Tên miền con” là tên miền thuộc một phần của tên miền lớn hơn. Trong trường hợp này, “nhanhoa.com” có thể được coi là tên miền con của “com”. Phần “nhanhoa” được gọi là SLD (second level domain), có nghĩa là tên miền cấp hai.

Hiển thị của tên miền trên thanh URL trình duyệt:
<p align="center">
  <img src="https://user-images.githubusercontent.com/79830542/188812114-04ad8bc0-7044-4aa9-80aa-4eaeef5bebcd.png" width="">
<p>
  
# <a name="III" >III. Các khái niệm trong hệ thống DNS</a>
  
`Zone File:` Zone files được coi là thành phần chính của một Name Server. Nó chứa các thông tin về các hosts, server trong domain. Các thông tin này sẽ được các name server software sử dụng để thực hiện các tác vụ đc yêu cầu. Tính đúng đắn của việc phân tích một request của name server phụ thuộc vào nội dung của các zone files.

`Bản ghi (record):` Trong một zone, bản ghi được lưu giữ dùng để ánh xạ một tên miền thành một địa chỉ IP, xác định máy chủ phân giải cho tên miền, xác định máy chủ mail cho tên miền, v.v.

`Tên miền (Domain)` vs `Zone:` Tên miền được chia thành các zone - thuộc quyền quản lý của các máy chủ DNS.

  - Domain đại diện cho toàn bộ tên miền / máy chủ thuộc cùng một tổ chức. Ví dụ: tất cả các tên miền kết thúc bằng “.com” là một phần của tên miền “com”.

  - Zone là một tên miền hoặc ít hơn tùy thuộc vào việc ủy quyền (delegated) tên miền con với những máy chủ DNS khác. Ví dụ: Máy chủ DNS có thể quản lý tất cả các bản ghi trong miền “cloud365.vn”, nhưng bằng cách xác định các bản ghi NS cho “abc.cloud365.vn”, phần này của miền được ủy quyền cho các máy chủ DNS khác - và có thể một công ty / thực thể khác nhau. Một zone chứa một bản ghi SOA mô tả các thuộc tính chung của vùng (zones) đó.
  
  Tham khảo tại [blog.cloud365.vn](https://blog.cloud365.vn/linux/dns-introduction/)
  
  Date acced: 07/09/2022
