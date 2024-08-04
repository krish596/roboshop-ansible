- name:  MongoDB Service
  hosts: all
  become: true
  tasks:


    - name: Install MongoDB
      ansible.builtin.dnf:
        name: mongodb-org
        state: latest

    - name: Replace New Content
      ansible.builtin.replace:
        path: /etc/mongod.conf
        regexp: '127.0.0.1'
        replace: '0.0.0.0'

    - name: Start MongoDB Service
      ansible.builtin.systemd:
        name: mongod
        state: restarted
        enabled: yes


cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y
#Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
systemctl enable mongod
systemctl restart mongod