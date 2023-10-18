#!/bin/bash
git clone https://github.com/srsLTE/srsGUI.git
cd srsGUI
mkdir build
cd build
cmake ../
make -j`nproc`
sudo make install -j`nproc`
