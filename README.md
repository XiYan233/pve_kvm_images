# pve_kvm_images

Fork from https://github.com/oneclickvirt/pve_kvm_images

## 用法
```shell
wget -O 'download.sh' https://raw.githubusercontent.com/XiYan233/pve_kvm_images/main/download.sh && chmod 777 download.sh
# ./download.sh ${STORAGE}
./download.sh local-lvm
```

## 说明

Releases中的镜像(每日拉取镜像进行自动修补和更新)：

已预安装：wget curl openssh-server sshpass sudo cron(cronie) qemu-guest-agent

已预开启安装cloudinit，开启SSH登陆，预设SSH监听IPV4和IPV6的22端口，开启允许密码验证登陆

所有镜像均开启允许root用户进行SSH登录

默认用户名：```root```

默认密码：```XiYanCloudDefaultPass```

如果使用务必自行修改密码，否则会有被骇入的风险

## 感谢

https://down.idc.wiki/Image/realServer-Template/current/qcow2/

提供的原始系统镜像，原始镜像仅开启了cloudinit，其他一切未开启，且不支持root进行SSH登录


## 不要使用--Do-Not-USE

Source code (zip)

Source code (tar.gz)
