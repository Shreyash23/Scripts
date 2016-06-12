#This is for Python version 3.5 and OpenCV version 3.1.0
# See installation reference at -> http://www.pyimagesearch.com/2015/07/20/install-opencv-3-0-and-python-3-4-on-ubuntu/
#Tested on Ubuntu 16.04

# Install required packages

sudo apt-get install build-essential cmake git pkg-config -y
sudo apt-get install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev -y
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev -y
sudo apt-get install libgtk2.0-dev -y
sudo apt-get install libatlas-base-dev gfortran -y


# Set up pip (Python package manager) for Python3

wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py

# Install virtual Environment Manager for python and set it up for commandline

sudo pip3 install virtualenv virtualenvwrapper

echo export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3 >> ~/.bashrc
echo export WORKON_HOME=$HOME/.virtualenvs >> ~/.bashrc
echo source /usr/local/bin/virtualenvwrapper.sh >> ~/.bashrc

source ~/.bashrc


# Setting up the VirtualEnvironment

mkvirtualenv opencv
sudo apt-get install python3.5-dev -y
pip install numpy
deactivate

# Download Open CV and set it up
cd
git clone https://github.com/Itseez/opencv.git
cd opencv
git checkout 3.1.0


cd
git clone https://github.com/Itseez/opencv_contrib.git
cd opencv_contrib
git checkout 3.1.0

cd ~/opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=OFF \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
	-D BUILD_EXAMPLES=ON ..

# Make process will take a while
processors=`nproc`
make -j$processors

# Install OpenCV now
sudo make install

sudo ldconfig

# Setup Completed for OpenCV, verify & link the library to our Virtual Environment (opencv)

cd ~
ls /usr/local/lib/python3.5/site-packages/cv2.cpython*
pythonlib=`ls /usr/local/lib/python3.5/site-packages/cv2.cpython*`

ln -s $pythonlib ~/.virtualenvs/opencv/lib/python3.5/site-packages/cv2.so


#Clean up build files
cd ~/opencv/build
make clean

echo "Install completed successfully, use virtual environment opencv and"



