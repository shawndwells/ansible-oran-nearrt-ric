#!/bin/bash

# git clone https://github.com/srsran/srsRAN_Project.git
- name: Clone srsRAN Project from GitHub
  git:
    repo: https://github.com/srsran/srsRAN_Project.git
    dest: "{{ ansible_env.HOME }}/src/srsRAN_Project"
    clone: true

# cd srsRAN_Project

# mkdir build

# cd build

# cmake ../ -DENABLE_EXPORT=ON -DENABLE_ZEROMQ=ON

# make -j`nproc`
- name: Run 'make' target on srsRAN Project as root
  make:
    chdir: "{{ ansible_env.HOME }}/src/srsRAN_Project"
  params:
    NUM_THREADS: {{ num_threads }}
    CC: gcc-10
