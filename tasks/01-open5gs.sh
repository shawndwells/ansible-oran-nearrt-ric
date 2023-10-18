---
- hosts: localhost
  tasks:

    # curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
    # sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor
    - name: Download and Install MongoDB Repo GPG Signature
      become: true
      shell: curl -fsSL https://pgp.mongodb.com/server-6.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor

    # echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
    #sudo apt update
    - name: Add MongoDB APT Repository
      become: true
      ansible.builtin.apt_repository:
        filename: mongodb-org-6.0
        repo: 'deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse'
        update_cache: yes

    #sudo apt install -y mongodb-org
    - name: Install MongoDB
      become: true
      package:
        name: mongodb-org
        state: present

    #systemctl start mongod
    - name: Start MongoDB service
      become: true
      ansible.builtin.systemd:
        state: started
        name: mongod

    #systemctl enable mongod
    - name: Enable MongoDB service
      become: true
      ansible.builtin.systemd:
        name: mongod
        enabled: true
        masked: no

    # sudo add-apt-repository ppa:open5gs/latest
    # sudo apt update
    #- name: Add Open5GS PPA Repository
    #  become: true
    #  ansible.builtin.apt_repository:
    #    repo: 'ppa:open5gs/latest'
    #    #update_cache: true

    # sudo apt install open5gs
    - name: Install Open5GS
      become: true
      package:
        name: open5gs
        state: present

    # sudo mkdir -p /etc/apt/keyrings
    - name: Create /etc/apt/keyrings
      file:
        path: /etc/apt/keyrings
        state: directory

    # curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    - name: Download and Install Open5GS WebUI Repo GPG
      become: true
      shell: curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

    # NODE_MAJOR=20
    # echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    - name: Add Open5GS WebUI APT Repository
      become: true
      ansible.builtin.apt_repository:
        filename: /etc/apt/sources.list.d/nodesource.list
        repo: 'deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main'

    # sudo apt install nodejs -y
    - name: Install NodeJS
      become: true
      package:
        name: nodejs
        state: present

    # curl -fsSL https://open5gs.org/open5gs/assets/webui/install | sudo -E bash -
    - name: Install Opn5GS WebUI
      become: true
      shell: curl -fsSL https://open5gs.org/open5gs/assets/webui/install | sudo -E bash -

    # cp /etc/open5gs/mme.yaml
    # sudo systemctl restart open5gs-mmed
    # cp /etc/open5gs/amf.yaml
    # sudo systemctl restart open5gs-amfd
    # sysctl -w net.ipv4.ip_forward=1
    # sysctl -w net.ipv6.conf.all.forwarding=1
    # sudo iptables -t nat -A POSTROUTING -s 10.45.0.0/16 ! -o ogstun -j MASQUERADE
    # sudo ip6tables -t nat -A POSTROUTING -s 2001:db8:cafe::/48 ! -o ogstun -j MASQUERADE
    # sudo ufw status
    # sudo ufw disable
    # sudo ufw status
    ### Ensure that the packets in the `INPUT` chain to the `ogstun` interface are accepted
    # sudo iptables -I INPUT -i ogstun -j ACCEPT
    # ### Prevent UE's from connecting to the host on which UPF is running
    #$ sudo iptables -I INPUT -s 10.45.0.0/16 -j DROP
    # $ sudo ip6tables -I INPUT -s 2001:db8:cafe::/48 -j DROP

    ### If your core network runs over multiple hosts, you probably want to block
    ### UE originating traffic from accessing other network functions.
    ### Replace x.x.x.x/y with the VNFs IP/subnet
    # $ sudo iptables -I FORWARD -s 10.45.0.0/16 -d x.x.x.x/y -j DROP
