git clone https://github.com/Nuand/bladeRF.git

cd bladeRF

wget https://www.nuand.com/fpga/hostedxA4-latest.rbf
wget https://www.nuand.com/fpga/hostedxA5-latest.rbf
wget https://www.nuand.com/fpga/hostedxA9-latest.rbf
wget https://www.nuand.com/fpga/hostedx40-latest.rbf
wget https://www.nuand.com/fpga/hostedx115-latest.rbf
wget https://www.nuand.com/fpga/wlanxA9-latest.rbf
wget https://www.nuand.com/fpga/adsbxA4.rbf
wget https://www.nuand.com/fpga/adsbxA5.rbf
wget https://www.nuand.com/fpga/adsbxA9.rbf
wget https://www.nuand.com/fpga/adsbx40.rbf
wget https://www.nuand.com/fpga/adsbx115.rbf
wget https://www.nuand.com/fx3/bladeRF_fw_latest.img

sudo apt-get libgusb-dev libgusb2 libusn-0.1-4 libusb-1.0-0 lubusb-1.0-0-dev libusb-dev libusb3380-0 libusb3380-dev

mkdir -p build
cd build
cmake [options] ../
make -j`nproc`
sudo make install -j`nproc`
sudo ldconfig



#### WTF
libad936x
