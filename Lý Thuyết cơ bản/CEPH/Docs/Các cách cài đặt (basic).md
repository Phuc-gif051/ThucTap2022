# Các công cụ được khuyến nghị 
_Phù hợp với các phiên bản mới của Ceph (bắt đầu từ phiên bản Octopus)_

[Cephadm](https://docs.ceph.com/en/quincy/cephadm/#cephadm) cài đặt và quản lý cụm Ceph bằng cách sử dụng containers và systemd, sử dụng đồng thời cả CLI và GUI.
   - Chỉ hỗ trợ từ phiên bản Octopus trở lên
   - Tích hợp đầy đủ các API mới nhất. Hỗ trợ tốt, đầy đủ với các tính năng mới cho CLI và dashboard (bảng điều khiển) để thiết lập và quản lý cụm Ceph
   - Yêu cầu phải có hỗ trợ về containers (docker hoặc podman) và Python 3 trở lên.

[Rook](https://rook.io/) triển khai và quản lý cụm Ceph bằng cách chạy trong [Kubernetes](https://kubernetes.io/vi/), với sự hỗ trợ của các Kubernetes APIs ta có thể quản lý và cung cấp các tài nguyên lưu trữ của cụm Ceph. Rook được đề xuất như 1 cách để vận hành Ceph khi đã có sẵn Kubernetes hoặc kết nối 1 cụm Ceph có sẫn vào Kubernetes.
  - Rook hỗ trợ từ phiên bản Nautilus trở lên
  - Đây là cách thường sử dụng để chạy Ceph trên Kubernetes, hoặc kết nối 1 cụm Kubernetes với 1 cụm Ceph có sẵn ở bên ngoài.
  - Rook cũng hỗ trợ các API mới nhất, các tính năng quản lý mới trong CLI và dashboard cũng được hỗ trợ đầy đủ.

# 1 số công cụ khác

_Phù hợp với các phiên bản cũ (từ Octopus trở xuống)_

[ceph-ansible](https://docs.ceph.com/ceph-ansible/) triển khai và quản lý cụm Ceph sử dụng [Ansible](https://viblo.asia/p/phan-1-tim-hieu-ve-ansible-4dbZNxv85YM).
  - Được sử dụng rộng rãi
  - Không được tích hợp sẵn các API mới nhất
  - Phù hợp nhất từ phiên bản Nautlius trở xuống nên các tính năng quản lý mới và dashboard (bảng điều khiển) không có sẵn

[ceph-deploy](https://docs.ceph.com/projects/ceph-deploy/en/latest/) công cụ để nhanh chóng triển khai 1 cụm Ceph
  - Đã cũ và không còn được hỗ trợ quá nhiều. Chưa được kiểm thử tính tương thích cho các phiên bản Ceph mới hơn Nautilus
  - Không còn hỗ trợ cho các OS RHEL 8 hay CentOS 8 và các OS khác mới hơn.
  - Tuy nhiên với việc CentOS 8 đã dừng hỗ trợ thì Ceph-deploy vẫn được tin tưởng sử dụng.

[ceph-salt](https://github.com/ceph/ceph-salt) cài đặt Ceph sử dụng công cụ Salt và cephadm

[jaas.ai/ceph-mon](https://jaas.ai/ceph-mon) cài đặt Ceph sử dụng Juju.

Cài đặt Ceph thông qua [Puppet](github.com/openstack/puppet-ceph) 

**Hoặc có thể cài đặt thủ công theo hướng dẫn từ nhà phát triển [tại đây](https://docs.ceph.com/en/quincy/install/index_manual/#install-manual)**

# Tài liệu tham khảo

[Docs Ceph](https://docs.ceph.com/en/quincy/install/)

