## Nội dung chính

_Gửi cảnh báo của hệ thống từ server thông qua các kênh phổ biến_


___

## <a name="1" >I. Thông qua telegram</a>

>Chuẩn bị
>
> - Chuẩn bị ít nhất 1 tài khoản telegram
> - Một Zabbix server và 1 vài zabbix agent để kiểm thử cảnh báo có hoạt động hay không.

- B1: cần tạo bot chat trên tele để nhận các cảnh báo gửi về. Truy cập vào tele (có thể dùng trên nền web hoặc app), gõ vào thanh tìm kiếm `BotFather` để tiến hành tạo bot cho tài khoản.
  - <img src="Images/create_bot.jpg" width="">
  - Lần đầu gõ vào `/newbot`: để tạo bot mới
  - Tiếp tục tạo tên gọi của bot. Nhiều bot có thể trùng tên nhau.
  - Sau đó tạo ra username của bot để hệ thống của tele có thể phân biệt. Các username là khác nhau và bắt buộc kết thúc bởi `bot`.
  - Thành công thì ta sẽ được trả về đường dẫn tới box chat với bot và token để truy cập vào bot từ các ứng dụng khác. Kết quả tương tự trên hình.
  - Ta có thể thêm bot vào các nhóm chat theo yêu cầu với câu lệnh `@your-bot-name`. Tại bài viết này sẽ sử dụng khung chat với bot để nhận cảnh báo.
  - Lấy ID box chat với bot để sử dụng cho sau này. Bằng cách gửi 1 tin nhắn bất kỳ trong box chat với bot rồi truy cập vào đường link sau để lấy ID:
  - `https://api.telegram.org/bot<your-bot-token>/getMe`. Với: `<your-bot-token>` là access token bạn nhận được khi tạo Bot.

- B2: Di chuyển sang Zabbix server để cấu hình việc gửi cảnh báo bằng các sử dụng kênh khác. Ở đây sử dụng phiên bản 5.0 LTS.
  - Truy cập vào Zabbix server dashboard, truy cập `Administration >> Media types >> Telegram`.
  - <img src="Images/access_telegram_media.jpg" width="">
  - double chuột vào `Telegram` ta sẽ đưuọc chuyển sang trang cấu hình tương tự như:
  - <img src="Images/telegram_media_type.jpg" width="">
  - Cấu hình các thông số cơ bản như:
    - ParseMode – Markdown hoặc HTML
    - Token – Bot access token (nhận được ở bước tạo Bot)
  - Nhấn `Update` để lưu lại cấu hình.
  - Để có thể nhận được cảnh báo, ta cần gán `Media` cho tài khoản nhận cảnh báo. Ở đây sử dụng luôn tài khoản `Admin`
  - Truy cập `Administration >> Users >> nhấn chọn user cần cấu hình`, ta sẽ được chuyển sang cấu hình cho user tương tự như sau:
  - <img src="Images\add_to_user.png" width="">
  - Chuyển sang tab Media và nhấn Add để thêm mới
  - <img src="Images\add_media_for_user.jpg" width="">
  - Tại pop-up Media, bạn lần lượt chọn và tùy biến những thành phần sau:
    - Type: Telegram
    - Send to: thay thế bằng ID channel của bạn. Đã thu được ở trên.
    - When active: khoảng thời gian gửi cảnh báo trong ngày
    - Use if severity: chọn các mức sự cố gửi cảnh báo
  - <img src="Images\media_config.jpg" width="">
  - Sau khi nhấn `Add` cấu hình sẽ được lưu lại
  - <img src="Images\user_media_list.jpg" width="">
  - Để kiểm thử việc hoạt động. Truy cập `Administration >> Media types >> Test`, trên Telegram media type và lần lượt điền những trường thông tin sau:
    - Mesage: Nội dung tin nhắn test
    - Subject: tiêu đề tin nhắn test
    - To: Telegram group id
    - Token: Bot access token (nhận được ở bước tạo Bot)
    - <img src="Images\telegram_media_test.jpg" width="">
    - Cấu hình thành công ta sẽ nhận được các thông báo với nội dung tin nhắn đã nhập ở trên trong box chat với bot.

- B3: có các cấu hình cơ bản, ta cần tạo hành động gửi cảnh báo cho Zabbix server.
  - Truy cập vào `Configuration >> Actions`. khi tạo thành công việc tạo các bước trên, ta sẽ thu được `Actions` mặc định như sau:
  - <img src="Images\create_actions_tele.png" width="800">
  - CHọn `Action` cần cấu hình, ở đây là `Report problems to Zabbix administrators` thu được trang cấu hình tương tự bên dưới. Trong tab `Action` hãy tích chọn vào `Enable`, rồi chuyển sang tab `Operation` để cấu hình
  - <img src="Images\config_actions_tele.png" width="800">
  - Click vào `Add` sẽ thu được popup như sau:
  - <img src="Images\popup_tele.png" width="">

    - Cấu hình cơ bản như sau:
    - `Send to user groups >> Add` : chọn user group theo nhu cầu.
    - `Send to users >> Add`: chọn user được nhận thông báo.
    - `Send only to`: có thể để `All` hoặc click chọn vào menu đổ xuống, chọn con đường mà ta sử dụng. Ở đây sử dụng `Telegram`.
    - Nhấn `Add` để lưu lại cấu hình.
  - Hoàn tất cấu hình nhấn `Update` để cập nhật cấu hình mới.

- B4: tiến hành kiểm thử bằng cách:
  - tắt Zabbix agent bất kỳ nào đó trong hệ thống. Thường là trong 3p hệ thống Zabbix sẽ tự quét và nhận ra các agent down. Sau đó, gần như ngay lập ta sẽ nhận được cảnh báo trên bot tele ta đã thiết lập.
  - Hoặc có thể kiểm thử bằng cách đẩy hiệu năng với `Stress test`.
  - Bất kỳ thay đổi, hay ảnh hưởng xấu nào xuất hiện trên hệ thống cũng gần như đưuọc cảnh báo ngay lập tức qua bot tele đã thiết lập.

🎆 Trong trường hợp không nhận được cảnh báo thì hãy thử khởi động lại Zabbix server, Kiểm tra xem các cấu hình, các Actions đã được `Enable` hay chưa.

### <a name="01" >Tài liệu tham khảo</a>

<https://www.youtube.com/watch?v=TpP6NpS9jjg>

<https://hiepsharing.com/cau-hinh-zabbix-gui-canh-bao-den-telegram/>

<https://dotrungquan.info/huong-dan-thiet-lap-zabbix-canh-bao-qua-telegram/>

<https://www.networkworld.com/article/3563334/how-to-stress-test-your-linux-system.html#:~:text=1%20How%20to%20stress%20test%20your%20Linux%20system,system%20will%20help%20you%20anticipate%20how%20systems%20will>

Date accessed: 30/11/2020

## <a name="2" >2. Cảnh báo qua email</a>

- Mô hình triển khai, gần đúng với hầu hết các trường hợp muốn cài đặt thông báo thông qua các nguồn bên ngoài. Chỉ cần thay đối tượng nguồn bên ngoài trong sơ đồ.
- <img src="Images\how_email_notifications_work_on_zabbix.png" width="">







### <a name="02" >Tài liệu tham khảo</a>

<https://www.zabbix.com/documentation/current/en/manual/config/notifications/action/operation>

<https://bestmonitoringtools.com/zabbix-alerts-setup-zabbix-email-notifications-escalations/>

[Bật SMTP trên account google](https://huongdan.azdigi.com/huong-dan-cau-hinh-smtp-gmail-gsuite-cho-website-wordpress/)

[Hỗ trợ của google về Tạo và sử dụng Mật khẩu ứng dụng](https://support.google.com/accounts/answer/185833)

