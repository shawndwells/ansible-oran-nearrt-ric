#!/bin/sh

sudo apt update


# curl -fsSL https://pgp.mongodb.com/server-6.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor

- name: Add MongoDB GPG Key
  ansible.builtin.get_url:
    url: https://pgp.mongodb.com/server-6.0.asc
    dest: /etc/apt/keyrings/mongodb-server-6.0.asc
    mode: '0644'
    force: true

# echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
- name: Add MongoDB APT Repository
  ansible.builtin.apt_repository:
    filename: mongodb-org-6.0
    repo: 'deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse'
    update_cache: yes

#sudo apt update

#sudo apt install -y mongodb-org
- name: Install MongoDB
  package:
    name: mongodb-org
    state: present

#systemctl start mongod
- name: Start MongoDB service
  ansible.builtin.systemd:
    state: started
    name: mongod

#systemctl enable mongod
- name: Enable MongoDB service
  ansible.builtin.systemd:
    name: mongod
    enabled: true
    masked: no

# sudo add-apt-repository ppa:open5gs/latest
# sudo apt update
- name: Add Open5GS PPA Repository
  ansible.builtin.apt_repository:
    repo: 'ppa:open5gs/latest'
    update_cache: true

# sudo apt install open5gs
- name: Install Open5GS
  package:
    name: open5gs
    state: present


