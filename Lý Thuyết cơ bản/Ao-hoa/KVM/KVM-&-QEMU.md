**1. Nếu host computer chỉ được cài duy nhất QEMU và không có/không kích hoạt KVM thì có thể tạo ra guest VM chạy trên computer đó được không?**

–> Được. Bản thân QEMU đã là một type-2 hypervisor với đầy đủ khả năng tạo ra guest VM có các hardware được giả lập rồi.

**2. Nếu host computer chỉ có cài KVM và không có chạy QEMU hay bất cứ một hypervisor nào khác thì có thể tạo được guest VM trên computer đó hay không?**

–> Không. Bản thân KVM không thực sự là một hypervisor có chức năng giả lập hardware để có thể chạy guest VM. Chính xác nó chỉ là một Linux kernel module hỗ trợ cơ chế mapping các instruction giữa virtual CPU (của guest VM) và physical CPU (của host computer) với yêu cầu là physical CPU đó cần có virtualization extension, ví dụ như Intel VT-x hay AMD-V.

Có thể hình dung KVM giống như driver cho hypervisor để sử dụng được virtualization extension của physical CPU nhằm boost performance cho guest VM. KVM như định nghĩa trên official website thì là core virtualization infrastructure mà thôi, nó được các hypervisor khác lợi dụng làm back-end để tiếp cận được các công nghệ hardware acceleration.

**3. Thường thấy người ta chạy chung QEMU/KVM, điều này có tác dụng gì?**

–> Nhằm nâng cao hiệu suất của VM. Cụ thể, lúc tạo VM bằng QEMU có VirtType là KVM thì khi đó các instruction có nghĩa đối với virtual CPU sẽ được QEMU sử dụng KVM để mapping thành các instruction có nghĩa đối với physical CPU. Làm như vậy sẽ nhanh hơn là chỉ chạy độc lập QEMU, vì nếu không có KVM thì QEMU sẽ phải quay về (fall-back) sử dụng translator của riêng nó là TCG để chuyển dịch các instruction của virtual CPU rồi đem thực thi trên physical CPU.

Khi QEMU/KVM kết hợp nhau thì tạo thành type-1 hypervisor.

Do KVM kết hợp QEMU nên các máy ảo và mạng ảo có file cấu hình xml sẽ được lưu lại tại thư mục /etc/libvirt/qemu/

**4. Tóm lại là gì?**

QEMU cần KVM để boost performance và ngược lại KVM cần QEMU (modified version) để cung cấp giải pháp full virtualization hoàn chỉnh.

<https://github.com/lamth/Report-MDT/blob/master/KVM/docs/06.KVM-internals.md>

<https://github.com/qemu/qemu>

<https://www.linux-kvm.org/page/Main_Page>

<https://manthang.wordpress.com/2014/06/18/kvm-qemu-do-you-know-the-connection-between-them/>

<https://wiki.qemu.org/Documentation>

Date accessed: 28/02/2023
