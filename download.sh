#!/bin/bash

STORAGE=$1

# 下载 JSON 文件
curl -s https://raw.githubusercontent.com/XiYan233/pve_kvm_images/main/images.json -o images.json

# 读取 JSON 文件并循环处理每个模板
jq -c '.[] | .templates[]' images.json | while read template; do
  # 解析 JSON 中的 vmid, name 和 link
  vmid=$(echo "$template" | jq -r '.vmid')
  name=$(echo "$template" | jq -r '.name')
  link=$(echo "$template" | jq -r '.link')

  # 下载 qcow2 镜像
  echo "Downloading $name ($vmid)..."
  curl -L -o "${name}.qcow2" "$link"

  # 创建空虚拟机
  echo "Creating VM $name ($vmid)..."
  qm create "$vmid" --memory 512 --net0 virtio,bridge=vmbr0

  # 导入磁盘到虚拟机
  echo "Importing disk..."
  qm importdisk "$vmid" "${name}.qcow2" "$STORAGE"

  # 配置虚拟机
  echo "Configuring VM..."
  qm set "$vmid" --scsihw virtio-scsi-pci --scsi0 "$STORAGE":vm-$vmid-disk-0
  qm set "$vmid" --boot c --bootdisk scsi0
  qm set "$vmid" --ide2 "$STORAGE":cloudinit
  qm set "$vmid" --serial0 socket --vga serial0

  # 将虚拟机转换为模板
  echo "Converting VM $name ($vmid) to template..."
  qm template "$vmid"

  # 删除 qcow2 文件
  echo "Cleaning up..."
  rm -f "${name}.qcow2"
done

echo "All templates have been created!"
