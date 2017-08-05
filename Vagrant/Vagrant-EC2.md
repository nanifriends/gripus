# Setup Vagrant for AWS EC2

#### I have created a Linux Machine in Google Cloud of Centos7 OS. I installed vagrant and created VM  in AWS EC2. Following process will explain you how to do that.

## 1) Login to AWS Web Console, GO to IAM Service -> Create a User with Programatic access and download / copy the credentials for that user. Policy Attached to this user is `EC2 Full access`
## 2) Download and Install vagrant in centos 7 machine.
```
# yum install https://releases.hashicorp.com/vagrant/1.9.7/vagrant_1.9.7_x86_64.rpm
```
## 3) Setup EC2 related plugins for Vagrant
### Note: Refer the following link for complete documentation.  `https://github.com/mitchellh/vagrant-aws`
```
# vagrant plugin install vagrant-aws
# vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
```
## 4) Create / Copy admin.pem file in linux server
```
# vim /root/admin.pem
<Copy the content of oprivate key>
:wq
# chmod 400 /root/admin.pem
```
## 5) Create Vagrant Configuration 
```
# vim Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "dummy"

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = "YOURID"
    aws.secret_access_key = "YOURKEY"
    #aws.session_token = "SESSION TOKEN"
    aws.keypair_name = "vagrant"
    aws.region = "ap-south-1"
    aws.instance_type = "t2.micro"
    aws.associate_public_ip = "true"
    aws.subnet_id = 'subnet-212e0b48'
    aws.elastic_ip = 'true'

    aws.ami = "ami-3c0e7353"

    override.ssh.username = "centos"
    override.ssh.private_key_path = "/root/admin.pem"
  end
end
```


