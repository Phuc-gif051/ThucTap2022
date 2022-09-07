## Nội dung chính

[I. Giới thiệu chung](#I)

[II. 6 loại DNS record phổ biến nhất](#II)

[III. Thực hành](#III)

[IV. Tài liệu tham khảo](#IV)

___

## <a name="I" >I. Giới thiệu chung</a>

**_DNS_:** máy chủ phân giải tên miền, và để máy chủ phân giải tên miền có thể hoạt động được thì ta cần cấu hình các bản ghi (record). Để từ các record đấy ta có thể điều khiển máy chủ phân giản tên miền hoạt động với đúng mục đích của mình đặt ra.

**_record_**: DNS record là bản ghi nằm trong DNS servers cung cấp thông tin về cơ sở dữ liệu DNS, cho biết các tên miền, địa chỉ IP gắn với tên miền và cách xử lý các yêu cầu với tên miền đó… Tất cả các tên miền trên internet đều phải có một vài bản ghi DNS cần thiết để người dùng có thể truy cập trang web khi nhập tên miền và thực hiện các mục đích khác.

Có khá nhiều loại DNS record, vậy đâu là những loại record phổ biến nhất cần biết?

## <a name="II" >II. 6 loại DNS record phổ biến nhất</a>

### 1. A record

A record (viết tắt của Address record) là DNS record cơ bản và quan trọng nhất dùng để truy cập web. Nó giúp trỏ tên miền (domain) của website tới một địa chỉ IP cụ thể. A record có cú pháp như sau:

[Tên miền] IN A [địa chỉ IP của máy]

Ví dụ: bizflycloud.com IN A 172.217.5.78

Hầu hết các website chỉ có một bản ghi A, nhưng một số trang web sẽ có một vài bản ghi A không giống nhau. Điều này có nghĩa là một tên miền có thể được trỏ đến nhiều địa chỉ IP khác nhau… A record được dùng để chuyển tên miền sang địa chỉ IPv4, còn với IPv6 thì AAAA record sẽ được sử dụng. Cấu trúc của bản ghi AAAA cũng tương tự như bản ghi A.

### 2. CNAME record
CNAME (Canonical Name) record là một bản ghi DNS record quy định một tên miền là bí danh của một tên miền chính khác. Một tên miền chính có thể có nhiều bí danh CNAME. Cú pháp của DNS record này như sau:

[Tên bí danh] IN CNAME [tên miền chính]

Trong đó, tên miền chính là tên miền được khai báo trong A record đến IP của máy. Tên bí danh là tên miền khác mà bạn cho phép có thể trỏ đến máy tính (địa chỉ IP) này. Ví dụ:

```sh
www.bizflycloud.com IN CNAME bizflycloud.com

tức là khi người dùng gõ www.bizflycloud.com thì hệ thống cũng sẽ đưa về địa chỉ IP của tên miền chính bizflycloud.com.
```

### 3. MX record

MX (Mail Exchange) record là một DNS record giúp xác định mail server mà email sẽ được gửi tới. Một tên miền có thể có nhiều MX record, điều này giúp tránh việc không nhận được email nếu một mail server ngưng hoạt động.

MX record có cấu trúc khá đơn giản, ví dụ như:

bizflycloud.vn IN MX 10 mx20.bizflycloud.vn

bizflycloud.vn IN MX 30 mx30.bizflycloud.vn

Trong đó, các số 10, 30 là các giá trị ưu tiên. Chúng có thể là các số nguyên bất kì từ 1 đến 255, số càng nhỏ thì độ ưu tiên càng cao. Như trong ví dụ trên, các mail có cấu trúc địa chỉ là …@bizflycloud.vn sẽ được gửi đến mail server mx20.bizflycloud.vn trước. Nếu nó có vấn đề thì các mail mới được chuyển đến mail server mx30.bizflycloud.vn.

### 4. TXT record
TXT record là một loại DNS record giúp tổ chức các thông tin dạng text (văn bản) của tên miền. Một domain (tên miền) có thể có nhiều bản ghi TXT và chúng chủ yếu được dùng cho các Sender Policy Framework (SPF) codes, giúp email server xác định các thư được gửi đến có phải từ một nguồn đáng tin hay không. Ngoài ra, loại bản ghi DNS này còn dùng để xác thực máy chủ của một tên miền, xác minh SSL...

### 5. NS record
NS (Name Server) record là một loại DNS record giúp xác định thông tin của một tên miền cụ thể được khai báo và quản lý trên máy chủ nào. Cú pháp của bản ghi này như sau:

[Tên miền] IN NS [tên máy chủ tên miền]

Ví dụ:

bizflycloud.com IN NS ns1.bizflycloud.vn

bizflycloud.com IN NS ns2.bizflycloud.vn

Trong ví dụ trên, tên miền bizflycloud.com sẽ được quản lý bởi hai máy chủ tên miền là ns1.bizflycloud.vn và ns2.bizflycloud.vn. Điều này cũng có nghĩa là các DNS record (A record, MX record…) của tên miền bizflycloud.com sẽ được khai báo trên hai máy chủ này.

### 6. PTR record
PTR (Pointer) record có thể nói là một DNS record ngược lại với A record, cho phép chuyển đổi từ địa chỉ IP sang tên miền. Bản ghi PTR giúp xác thực IP của các hostname gửi tới, giúp hạn chế bị spam mail…

Ngoài 6 loại trên vẫn còn các loại bản ghi DNS khác ít phổ biến như SOA record, SRV record, APL record, CAA record, NAPTR record…Xem chi tiết hơn [tại đây](https://en.wikipedia.org/wiki/List_of_DNS_record_types) Hy vọng bài viết đã đem lại cho bạn những thông tin hữu ích về DNS record.

## <a name="III" >III. Thực hành</a>

1. [Video cách chỉnh sửa file hosts trên Windows 10](https://youtu.be/-4ZREGuGCok)
  - Bạn mở thư mục chứa file hosts theo đường dẫn sau, nếu cài Windows ở ổ khác thì bạn sửa lại đường dẫn cho đúng nhé.
  - `C:\Windows\System32\Drivers\etc\hosts`

2. []()

## <a name="IV" >IV. Tài liệu tham khảo</a>

1. [Giải nghĩa về DNS record, 6 loại DNS record phổ biến nhất](https://bizflycloud.vn/tin-tuc/giai-nghia-ve-dns-record-6-loai-dns-record-pho-bien-nhat-20200819112520598.htm)
2. [Các loại bản ghi trên DNS](https://blog.cloud365.vn/linux/dns-record/)

Date acced: 07/09/2022

