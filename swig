https://gitlab.eurecom.fr/mosaic5g/flexric
https://docs.srsran.com/projects/project/en/latest/tutorials/source/flexric/source/index.html

git clone ..
...
sudo make install
  


shawn@open5gs:~/flexric/build$ sudo update-alternatives --remove-all gcc
update-alternatives: error: no alternatives for gcc
shawn@open5gs:~/flexric/build$ sudo apt-get install gcc-10 gcc-11 gcc-4.3
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Package gcc-4.3 is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source

E: Package 'gcc-4.3' has no installation candidate
shawn@open5gs:~/flexric/build$ sudo apt-get install gcc-10 gcc-11 
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
gcc-11 is already the newest version (11.4.0-1ubuntu1~22.04).
gcc-11 set to manually installed.
gcc-10 is already the newest version (10.5.0-1ubuntu1~22.04).
The following packages were automatically installed and are no longer required:
  gnome-session-bin gnome-session-common gnome-startup-applications xwayland
Use 'sudo apt autoremove' to remove them.
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
shawn@open5gs:~/flexric/build$ sudo update-alternatives --config gcc
update-alternatives: error: no alternatives for gcc
shawn@open5gs:~/flexric/build$ sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 10
update-alternatives: using /usr/bin/gcc-10 to provide /usr/bin/gcc (gcc) in auto mode
shawn@open5gs:~/flexric/build$ sudi update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 11
-bash: sudi: command not found
shawn@open5gs:~/flexric/build$ sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 11
update-alternatives: using /usr/bin/gcc-11 to provide /usr/bin/gcc (gcc) in auto mode
shawn@open5gs:~/flexric/build$ sudo update-alternatives --config gcc
There are 2 choices for the alternative gcc (providing /usr/bin/gcc).

  Selection    Path             Priority   Status
------------------------------------------------------------
* 0            /usr/bin/gcc-11   11        auto mode
  1            /usr/bin/gcc-10   10        manual mode
  2            /usr/bin/gcc-11   11        manual mode

Press <enter> to keep the current choice[*], or type selection number: 1
update-alternatives: using /usr/bin/gcc-10 to provide /usr/bin/gcc (gcc) in manual mode
  


SWIG ZMQ
-- Checking for module 'ZeroMQ'
--   No package 'ZeroMQ' found
-- Found libZEROMQ: /usr/include, /usr/lib/x86_64-linux-gnu/libzmq.so
