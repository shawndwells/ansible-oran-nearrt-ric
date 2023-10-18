#!/bin/bash

- name: Check if FlexRIC GitHub was previously cloned
  stat: path={{ ansible_env.HOME}/src/flexric
  register: flexric_git_dir

# git clone https://gitlab.eurecom.fr/mosaic5g/flexric.git
- name: Clone FlexRIC repository
  git:
    repo: https://gitlab.eurecom.fr/mosaic5g/flexric.git
    dest: "{{ ansible_env.HOME }}/src/flexric" accept_hostkey=yes force=yes
    clone: true
    single_branch: yes
    version: e2ap-v2
    when: flexric_git_dir.stat is defined and flexric_git_dir.stat.isdir

# cd flexric
# git checkout 0eac86b9
- name: Checkout known FlexRIC commit hash (0eac86b9)
  ansible.builtin.shell:
    cmd: git checkout 0eac86b9
    chdir: "{{ ansible_env.HOME }}/src/flexric"

# git apply -v ../files/flexric.patch
- name: Copy flexric.patch to FlexRIC source directory
  copy:
    src: flexric.patch
    dest: "{{ ansible_env.HOME }}/src/flexric"

- name: Apply flexric.patch to FlexRIC source
  shell: git apply -v flexric.patch
  args:
    chdir: {{ ansible_env.HOME }}/src/flexric

# mkdir build
- name: Create the FlexRIC build directory
  file:
    path: "{{ ansible_env.HOME }}/src/flexric/build
    state: directory

# cmake ../
- name: Running cmake on FlexRIC
  shell: cmake ../
  args:
    chdir: {{ ansible_env.HOME }}/src/flexric/build

## make -j`nproc`
## NOTE: must use gcc-10 else fails
## 	 sudo update-alternatives --config gcc
- name: Build the default FlexRIC target
  make:
    chdir: "{{ ansible_env.HOME }}/src/flexric/build"
  params:
    NUM_THREADS: {{ num_threads }}
    CC: gcc-10

## make install -j`nproc`
- name: Run 'make install' target as root
  make:
    chdir: "{{ ansible_env.HOME }}/src/flexric/build
    target: install
  become: yes
  params:
    NUM_THREADS: {{ num_threads }}
    CC: gcc-10
