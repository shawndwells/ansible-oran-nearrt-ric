#!/bin/bash

git clone https://github.com/srsRAN/srsRAN_4G.git
cd srsRAN_4G
mkdir build
cd build
cmake ../
make -j`nproc`
make test -j`nproc`
sudo make install -j`nproc`
srsran_install_configs.sh service

