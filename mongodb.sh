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

