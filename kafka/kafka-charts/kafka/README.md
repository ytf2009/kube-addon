关键配置
persistence:
  #是否已经存在pvc，存在则不创建
  existingClaim: false
  #是否使用持久卷，false为不使用
  enabled: true
  annotations:
    volume.beta.kubernetes.io/storage-class: ssd
    volume.beta.kubernetes.io/storage-provisioner: flexvolume-huawei.com/fuxivol
  labels:
    failure-domain.beta.kubernetes.io/region: cn-north-1
    failure-domain.beta.kubernetes.io/zone: cn-north-1a

如果切换到华软k8s上，去掉
  annotations:
    volume.beta.kubernetes.io/storage-provisioner: flexvolume-huawei.com/fuxivol
  labels:
    failure-domain.beta.kubernetes.io/region: cn-north-1
    failure-domain.beta.kubernetes.io/zone: cn-north-1a
只保留
  annotations:
    volume.beta.kubernetes.io/storage-class: gluster