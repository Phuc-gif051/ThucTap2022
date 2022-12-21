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
+ Dùng phím “ESC” Insert mode —> Command mode
+ Để hiện thị vị trí nhập lệnh sử dụng phím “Shift cộng dấu :”


– Một số câu lệnh thường được sử dụng Command mode

  - save file and quit: `wq` hoac `x!`
-Thoát ra và không lưu lại: `q!`
- Xóa một hàng : `dd`
- Muốn copy một hàng : `YY`
- Dán : `P`
- Tìm một chữ nào đó: `?User` hoac `/User`
- `n`( không viết hoa) —> lùi lại
- `N` ( Viết hoa) —> tiếp theo
- Hiển thị số dòng : `set number`
- Muốn chuyển đến dòng thứ 100: sau khi gõ lệnh `set number`, gõ số 100
- Bấm phim `u` ==> undo
- Xóa đi dòng thứ 50, vào command mode, nhập vào `50d`
- Xóa từ dòng thứ 1 —> dòng thứ 10, vào command mode, nhập vào
`1,10d`
- Chuyen 1 loat dong thanh comment: [dong_bat_dau],[dong_ket_thuc]s/^/#
- Bỏ chú thích hàng loạt khi chú thích ở đầu dòng: 
  - Đặt con trỏ của bạn vào #ký tự đầu tiên , nhấn Ctrl+V (hoặc Ctrl+Q cho gVim) và đi xuống cho đến dòng nhận xét cuối cùng và nhấn x, sẽ xóa tất cả các ký tự # theo chiều dọc.

- Để bình luận một khối văn bản gần như giống nhau:

  - Đầu tiên, đi đến dòng đầu tiên bạn muốn bình luận, nhấn CtrlV. Điều này sẽ đặt trình soạn thảo trong VISUAL BLOCKchế độ.
  - Sau đó, sử dụng phím mũi tên và chọn cho đến dòng cuối cùng
  - Bây giờ nhấn ShiftI, sẽ đưa trình chỉnh sửa vào INSERTchế độ và sau đó nhấn #. Điều này sẽ thêm một hàm băm vào dòng đầu tiên.
  - Sau đó nhấn Esc(cho nó một giây) và nó sẽ chèn một #ký tự trên tất cả các dòng được chọn khác.
  - Đối với phiên bản rút gọn của vim được vận chuyển với debian / ubfox theo mặc định, hãy nhập : s/^/# bước thứ ba để thay thế.  

[xoa-het-noi-dung-file-text-bang-vi-vim.html](https://cuongquach.com/xoa-het-noi-dung-file-text-bang-vi-vim.html)
