1. 退出 conda 环境！！！ ROS/ROS2 最好借助 Ubuntu 原生环境下的 python 来使用
```
conda deactivate
```

2. 解决 `colcon build cmd not found`
- 参考 https://colcon.readthedocs.io/en/released/user/installation.html
```
sudo sh -c 'echo "deb [arch=amd64,arm64] http://repo.ros2.org/ubuntu/main `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
sudo apt install python3-colcon-common-extensions
```

3. 配置 usb 相机需要环境
```
sudo apt install ros-humble-camera-info-manager
sudo apt install ros-humble-diagnostic-updater
sudo apt install v4l-utils
sudo apt install python3-pip
pip install pydantic==1.10.9
```

4. 配置雷达需要环境
- 参考 https://github.com/Livox-SDK/Livox-SDK2/blob/master/README.md
```
git clone https://github.com/Livox-SDK/Livox-SDK2.git
cd ./Livox-SDK2/
mkdir build && cd build
cmake .. && make -j$(nproc)
sudo make install
cd ../..
rm -rf ./Livox-SDK2
```

5. 配置 realsense 环境
- 参考 https://dev.intelrealsense.com/docs/compiling-librealsense-for-linux-ubuntu-guide
- 安装依赖环境
```
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev
sudo apt-get install git wget cmake build-essential
sudo apt-get install libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev at
```
- 安装 sdk
```
sudo apt install ros-humble-librealsense2*
```

6. 接线之后，刷新 video 串口的读写权限
```
sudo usermod -aG video $USER
```

7. 添加开机自启动的守护进程
```
sudo cp quadruped-sensor-launcher.service /etc/systemd/system/
sudo systemctl daemon-reload
```

8. 添加 ros2 默认环境变量 ~/.bashrc
```
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
```
