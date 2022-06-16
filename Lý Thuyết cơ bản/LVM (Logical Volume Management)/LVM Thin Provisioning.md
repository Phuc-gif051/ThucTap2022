# Mục lục
# <a name="I">I. LVM Thin Provisioning</a>

 - Về cơ bản thì Thin Provisioning là một tính năng của LVM sử dụng công nghệ storage pool.
 - Storage pool về cơ bản thì cũng là gom nhóm ổ đĩa và quản lý chúng, khá giống với Volume group của LVM. Tuy nhiên, với volume group thì ta chủ yếu là gom nhóm các physical volume, rồi thêm bớt chúng để tăng giảm dung lượng, còn với storage pool ta có thể là thêm 1 phần khá thú vị nữa đó là quản lý cả phần lưu trữ mà còn trống (hay chưa dùng đến)
 - Trong LVM thì nó được gọi là Thin Provisioning hay lvm thin-pool. 
 - Cấu trúc của lvm thin-pool, về cơ bản thì là như thế này:
      - Ta đã có Volume group từ trước, từ Volume group ta tạo ra storage pool (vị trí của nó trong cây LVM tương tự với Logical volume nên sẽ được tính năng `lv` quản lý).
      - Sau đó từ storage pool đó ta tạo ra các thin volume (tương tự như các phân vùng logical volume để nhắm đến dành cho người dùng sử dụng, nhưng nó vẫn chịu sự quản lý của tính năng `lv`).

Và LVM Thin Provisioning chủ yếu để giải quyết bài toán thiếu hụt dung lượng trong thời gian ngắn. Ví dụ như sau:
 - Ta cung cấp dịch vụ lưu trữ, với 3 khách hàng, ta hợp đồngg với mỗi khách là sẽ có 1 TiB lưu trữ. Lúc này hệ thống của ta cũng vừa hết dung lượng để có thể bán thêm, và ta cũng cần thời gian để có chi phí nâng cấp hệ thống.
 - Nhưng lúc này ta lại có thêm 1 khách hàng nữa muốn làm hợp đồng với ta để sử dụng dịch vụ lưu trữ với dung lượng 1 TiB. Ơ nhưng mà ta bán vừa hết dung lượng rồi? Lúc này thì LVM Thin Provisioning sẽ phát huy tác dụng.
 - dụng LVM Thin Provisioning giải quyết bài toán như sau: 
    + Với 3 khách ở trên, mỗi người 1 TiB => tổng dung lượng của ta là 3 TiB. Và tất nhiên, với 1 TiB như thế, không chỉ 1-2 tuần mà cả 3 khách đều lưu trữ hết được.
    + Lúc này ta thấy dung lượng vẫn còn dư khá nhiều (thậm chí lớn hơn 1 TiB trong tổng 3 TiB), ta áp dụng LVM Thin Provisioning lấy phần dư đó, gom lại thành 1 vùng dung lượng với 1 TiB lưu trữ.
 Như vậy với LVM Thin Provisioning ta đã có thể cam kết với 4 khách mỗi người 1 TiB lưu trữ trong khi ta chỉ có 3 TiB :D. Và trong thời gian chờ ngần đó dung lượng được sử dụng hết, ta sẽ tìm cách để mỗi khách thật sự có 1 TiB lưu trữ 🥰
 
 # <a name= "II">II. Thực hành sử dụng LVM Thin Provisioning</a>
 _Thực hành trên hệ thống chạy CentOS 7, chỉ với 4GiB dung lượng 😄 đã được gom nhóm trong Volume group_
 
 
 ## <a name="II1">1. Khởi tạo</a>
 
 -  kiểm tra xem hệ thống ta đang như nào. Ở đây ta đã biết hệ thống được cấu hình sẵn lvm với Volume group có dung lượng là 3 GiB. Dùng câu lệnh `vgs` để xem thôn tin chi tiết.
 Nếu kiểm tra hệ thống chưa được cấu hình lvm thì ta cần phải cấu hình như [bài trước].
 
 Bao gồm 4 Physical Volume:
            - /dev/sdb: 1Gb
            - /dev/sdc: 1Gb
            - /dev/sdd: 1Gb
            - /dev/sde: 1Gb
        - Một VolumeGroup tên là LVMVolGroup hình thành từ 4 Physical Volume trên.
 
 `Thin Provisioning` ta có dữ liệu như sau:

            # vgs
              VG           #PV #LV #SN Attr   VSize  VFree
              LVMThinGroup   4   0   0 wz--n-  3.98g 3.98g

   - Để thực hiện sử dụng tính năng `Thin Provisioning` ta làm như sau:

        + Bước 1: Tạo ra một thin pool với câu lệnh như sau:

                # lvcreate -l 1018 --thinpool tp_volume_pool LVMThinGroup

            trong đó:

                - `-l 1018G`: dùng để khai báo kích thước của thin pool sẽ tạo ra là 3.98Gb tính theo giá trị PE.
                - `--thinpool`: khai báo logical volume tạo ra thuộc kiểu `thin pool`
                - `tp_volume_pool`: tên của thin pool sẽ tạo ra.
                - `LVMThinGroup`: tên của Volume Group sẽ được sử dụng để tạo ra thin pool

            kết quả sẽ hiển thị tương tự như sau:

                # lvcreate -l 1018 --thinpool tp_volume_pool LVMThinGroup

                  Using default stripesize 64.00 KiB.
                  Logical volume "tp_volume_pool" created.
                
                # lvs

                  LV             VG           Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
                  tp_volume_pool LVMThinGroup twi-a-tz--  3.98g             0.00   1.17
                  root           cl           -wi-ao---- 17.00g
                  swap           cl           -wi-ao----  2.00g


        + Bước 2: Ta sẽ tạo ra một thin volume. Cách làm như sau:

                # lvcreate -V 1024 --thin -n tv_client01 LVMThinGroup/tp_volume_pool

            trong đó:

                - `-V 1024`: khai báo kích thước của thin volume là 1024Mb
                - `--thin`: Khai báo kiểu tạo ra volume là thin volume
                - `-n tv_client01`: khai báo tên của thin volume tạo ra là tv_client01
                - `LVMThinGroup/tp_volume_pool`: khai báo thin pool được sử dụng để tạo ra thin volume.

            kết quả sẽ hiển thị tương tự như sau:

                  Using default stripesize 64.00 KiB.
                  Logical volume "tv_client01" created.

                # lvs
                  LV             VG           Attr       LSize  Pool           Origin Data%  Meta%  Move Log Cpy%Sync Convert
                  tp_volume_pool LVMThinGroup twi-aotz--  3.98g                       0.00   1.27
                  tv_client01    LVMThinGroup Vwi-a-tz--  1.00g tp_volume_pool        0.00
                  root           cl           -wi-ao---- 17.00g
                  swap           cl           -wi-ao----  2.00g

            tương tự như trên, ta hãy tạo ra thêm 2 thin pool lần lượt có tên là tv_client02 và tv_client03. Cuối cùng, ta có được thông tin như sau:

                # lvs

                  LV             VG           Attr       LSize  Pool           Origin Data%  Meta%  Move Log Cpy%Sync Convert
                  tp_volume_pool LVMThinGroup twi-aotz--  3.98g                       0.00   1.46
                  tv_client01    LVMThinGroup Vwi-a-tz--  1.00g tp_volume_pool        0.00
                  tv_client02    LVMThinGroup Vwi-a-tz--  1.00g tp_volume_pool        0.00
                  tv_client03    LVMThinGroup Vwi-a-tz--  1.00g tp_volume_pool        0.00
                  root           cl           -wi-ao---- 17.00g
                  swap           cl           -wi-ao----  2.00g

        + Bước 3: Thực hiện mount các thin pool đã tạo ra vào hệ thống. Ta làm tương tự như khi mount một Logical Volume.

            - Tạo ra các thư mục có chức năng `gắn kết` tương ứng cho các thin pool:

                    # mkdir -p /mnt/{client01,client02,client03}

            - Format định dạng cho các thin pool:

                    # mkfs.ext4 /dev/LVMThinGroup/tv_client01
                    # mkfs.ext4 /dev/LVMThinGroup/tv_client02
                    # mkfs.ext4 /dev/LVMThinGroup/tv_client03

            - Mount các thin pool đã tạo ra vào hệ thống ứng với các thư mục đã tạo ở phần đầu của bước này:

                    # mount /dev/LVMThinGroup/tv_client01 /mnt/client01/
                    # mount /dev/LVMThinGroup/tv_client02 /mnt/client02/
                    # mount /dev/LVMThinGroup/tv_client03 /mnt/client03/

        + Bước 4: Thực hiện kiểm tra dung lượng thực sự đã sử dụng của thin pool:

                # lvs

            kết quả hiện thị tương tự như sau:


                  LV             VG           Attr       LSize  Pool           Origin Data%  Meta%  Move Log Cpy%Sync Convert
                  tp_volume_pool LVMThinGroup twi-aotz--  3.98g                       3.61   3.22
                  tv_client01    LVMThinGroup Vwi-aotz--  1.00g tp_volume_pool        4.79
                  tv_client02    LVMThinGroup Vwi-aotz--  1.00g tp_volume_pool        4.79
                  tv_client03    LVMThinGroup Vwi-aotz--  1.00g tp_volume_pool        4.79
                  root           cl           -wi-ao---- 17.00g
                  swap           cl           -wi-ao----  2.00g

            theo kết quả trên, ta thấy, các thin volume hiện đan sử dụng 4.79% dung lượng và thin pool chỉ sử dụng 3.61%.
            
            
     ## <a name="II.2">2. Tính năng Over Provisioning</a>
     
      - Như ở phần đầu của bài viết đã đề cập. Khi sử dụng tính năng `Thin Provisioning` ta có thể cung cấp dung lượng cho nhiều hơn những gì thực tế ta có khi storage pool hiện đang còn có dung lượng trống. Việc cung cấp như này được gọi là `Over Provisioning`.

   - Ngay bây giờ, ta sẽ thự hiện quá trình `Over Provisioning` bằng việc tạo thêm một thin volume 2Gb nữa. Vì ta đang có 3 thin volume sử dụng hết 3.16% trong tổng dung lượng của thin pool đã tạo ra.

            # lvcreate -V 2048 --thin -n tv_client04 LVMThinGroup/tp_volume_pool

        kết quả sẽ hiển thị tương tự như sau:

              Using default stripesize 64.00 KiB.
              WARNING: Sum of all thin volume sizes (5.00 GiB) exceeds the size of thin pool LVMThinGroup/tp_volume_pool and the size of whole volume group (3.98 GiB)!
              For thin pool auto extension activation/thin_pool_autoextend_threshold should be below 100.
              Logical volume "tv_client04" created.

    - Khi ta kiểm tra với câu lệnh `lvs` sẽ nhận được kết quả tương tự như sau:

              LV             VG           Attr       LSize  Pool           Origin Data%  Meta%  Move Log Cpy%Sync Convert
              tp_volume_pool LVMThinGroup twi-aotz--  3.98g                       3.61   3.32
              tv_client01    LVMThinGroup Vwi-aotz--  1.00g tp_volume_pool        4.79
              tv_client02    LVMThinGroup Vwi-aotz--  1.00g tp_volume_pool        4.79
              tv_client03    LVMThinGroup Vwi-aotz--  1.00g tp_volume_pool        4.79
              tv_client04    LVMThinGroup Vwi-a-tz--  2.00g tp_volume_pool        0.00
              root           cl           -wi-ao---- 17.00g
              swap           cl           -wi-ao----  2.00g


    - Tiếp tục thực hiện các bước để có thể sử dụng thin volume vừa tạo ra tương tự như ở trên:

            # mkdir /mnt/client04
            # mkfs.ext4 /dev/LVMThinGroup/tv_client04
            # mount /dev/LVMThinGroup/tv_client04 /mnt/client04


        khi kiểm tra câu lệnh `df -H` ta được:


            /dev/mapper/cl-root                    19G  1.3G   17G   8% /
            devtmpfs                              945M     0  945M   0% /dev
            tmpfs                                 957M     0  957M   0% /dev/shm
            tmpfs                                 957M  9.1M  947M   1% /run
            tmpfs                                 957M     0  957M   0% /sys/fs/cgroup
            /dev/sda1                             1.1G  145M  919M  14% /boot
            tmpfs                                 192M     0  192M   0% /run/user/1000
            /dev/mapper/LVMThinGroup-tv_client01  1.1G  2.7M  951M   1% /mnt/client01
            /dev/mapper/LVMThinGroup-tv_client02  1.1G  2.7M  951M   1% /mnt/client02
            /dev/mapper/LVMThinGroup-tv_client03  1.1G  2.7M  951M   1% /mnt/client03
            /dev/mapper/LVMThinGroup-tv_client04  2.1G  6.3M  2.0G   1% /mnt/client04

    - Có một điều cần lưu ý khi ta bắt đầu sử dụng đến `Over Provisioning` đó là khi dữ liệu người dùng tăng đột xuất và sẽ sử dụng đầy đủ hết 5Gb. Thì sẽ xảy ra xung đột trong hệ thống, ta cần phải bổ sung dung lượng bộ nhớ cho thin pool kịp thời để tránh xảy ra xung đột. Hãy thực hiện, thêm dung lượng cho thin pool bằng việc sử dụng câu lệnh `lvextend` và coi thin pool của chúng ra đã tạo như một Logical Volume thông thường. Ví dụ:

            # lvextend -L +15G /dev/LVMThinGroup/tp_volume_pool
            
