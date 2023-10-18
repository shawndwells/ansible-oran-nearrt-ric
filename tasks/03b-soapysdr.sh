sudo apt-get install cmake g++ libpython3-dev python3-numpy swig

git clone https://github.com/pothosware/SoapySDR.git

cd SoapySDR

mkdir build
cd build
cmake ..
make -j`nproc`
sudo make install -j`nproc`
sudo ldconfig #needed on debian systems
SoapySDRUtil --info
