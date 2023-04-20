– Các Editor ở giao diện dòng lệnh thông dụng sử dụng trong môi trường linux: VI,
VIM, NANO, Emacs.

– GEDIT chương trình hiểu chỉnh văn bảng ở giao diện đồ họa

– Chương trình VI chỉ có 2 màu trắng và đen. Chương trình VIM thì hỗ trợ nhiều
màu sắc hơn. 

– VI có 2 mode hoạt động cơ bản: là “Command”, “Insert” mode

– Thao tác cơ bản trên chương trình VI
+ Mặc định khi mới mở file thì sẽ ở command mode.
+ Dùng phím “I” hoặc “A” hoặc “O” để chuyển từ Command mode —> Insert
mode
+ Dùng phím “ESC” để thoát Insert mode —> Command mode
+ Để hiện thị vị trí nhập lệnh sử dụng phím “Shift cộng dấu :”


– Một số câu lệnh thường được sử dụng Command mode
- save file and quit: `wq` hoac `x!`
- Thoát ra và không lưu lại: `q!`
- Xóa một hàng : `dd`
- Xóa một từ : `dw`
- Muốn copy một hàng : `yy`
- Dán : `p`
- Thay thế 1 loạt các từ hoặc ký tự: %s/<ký tự/từ cần thay thế>/<ký tự/từ sẽ được thay thế vào>. Ví dụ cần thay thế từ no thành yes: %s/no/yes
- Tìm một chữ nào đó: `?User` hoac `/User`
- `n`( không viết hoa) —> lùi lại
- `N` ( Viết hoa) —> tiếp theo
- Hiển thị số dòng : `set number` hoặc `set nu!`
- Muốn chuyển đến dòng thứ 100: sau khi gõ lệnh `set number`, gõ số 100
- Bấm phim `u` ==> undo
- Xóa đi dòng thứ 50, vào command mode, nhập vào `50d`
- Xóa từ dòng thứ 1 —> dòng thứ 10, vào command mode, nhập vào
`1,10d`
- Chuyen 1 loat dong thanh comment: [dong_bat_dau],[dong_ket_thuc]s/^/#
- Bỏ chú thích hàng loạt khi chú thích ở đầu dòng: 
  - Đặt con trỏ của bạn vào ký tự `#` đầu tiên , nhấn `Ctrl+V` (hoặc Ctrl+Q cho gVim) và đi xuống cho đến ký tự `#` cuối cùng và nhấn `x`, sẽ xóa tất cả các ký tự # theo chiều dọc.

[xoa-het-noi-dung-file-text-bang-vi-vim: %d](https://cuongquach.com/xoa-het-noi-dung-file-text-bang-vi-vim.html)


