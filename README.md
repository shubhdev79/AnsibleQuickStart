# AnsibleQuickStart
Creation of **3-AWS** EC2 Servers on Terraform(.tf).

Installation, Creation of Users on Servers, Commands etc.

# INSTALLING ANSIBLE (MASTER):

1) Choose Linux AMI - 3 Instances
2) Enable ICMP All Traffic and SSH in Security Group - 1 Security Group
3) Install Ansible on AWSLinux

# Installation Commands:

--- sudo yum update -y
1) sudo yum-config-manager --enable epel
2) sudo yum repolist (you should see epel)
3) **sudo yum install ansible**
4) ansible --version (To Verify)
5) ansible localhost -m ping (To test Ansible and see if it’s working on our Ansible Control server run)

----------------------------------------------------------------------------------------

# Creation of Users on Servers:[Must be Same Username for all the servers, for better SSH Connection]

1) useradd -d /home/ansadm -m ansadm ***********
2) passwd ansadm **************  [Not Mandatory]

CONTROLLER: 172.31.XX.XX
Username : ec2-user
Pwd : Ansible@79

HOSTS: 172.31.XX.XXX  [WebServer]
Username : ec2-user
Pwd : Ansible@79

172.31.XX.XX [AppServer]
Pwd : Ansible@79

3) Public Key Authentication: sudo vi /etc/ssh/sshd_config
4) Find the Line containing “PasswordAuthentication” parameter and change its value from “no” to “yes“.
5) sudo service sshd restart

----------------------------------------------------------------------------------------

# SSH Connection :

**On Controller --

1) **ssh-keygen**
2) ssh-copy-id -i ec2-user@172.31.XX.XXX
3) .ssh will be created in Computer-2
4) .ssh -> authorised_keys (Entry will be there for COMPUTER-1 in auth_keys
5) ssh ansadm@172.31.XX.XXX

**On Slave --

1) Repeat the same on Slave Servers. 
----------------------------------------------------------------------------------------

# ANSIBLE COMMANDS:

1) ansible localhost -m ping
2) ansible WebServer -m ping
3) ansible all -m ping
** ansible all -m ping -k (With Prompting Password)

4) ansible WebServer -m shell -a "uname -a;df -h" (Disk Space & OS Details)
5) ansible WebServer -m yum -a "name=httpd state=present" (Apache Installation)
6) ansible WebServer -m yum -a "name=httpd state=present" -s (After Setting Root Permissions in /etc/sudoers)
7) ansible WebServer -m service -a "name=httpd state=started" -s (Checking the Status)

----------------------------------------------------------------------------------------

# ANSIBLE PLAYBOOKS & ROLES:
Roles - are the next level of abstraction of ansible playbook. Roles are the list of commands that ansible will execute on target machines in given order
Playbook — decides which role is for which target machine

1) Create main.yml
2) Create playbook.yml
3) ansible-playbook -K playbook.yml
4) ansible-playbook playbook.yml — list-hosts
----------------------------------------------------------------------------------------
