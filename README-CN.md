# 安装与使用教程
[中文版](./README-CN.md) | [English](./README.md)

## 您需要准备
> [!Note]
> 以下依赖均已在本地部署并测试，如无特别需求不必重复操作

本套配置基于 Ubuntu 22.04 搭配 ROS2 Humble 进行测试。在您使用前，请先确认以下依赖已被恰当配置在本地环境中：
1. Ubuntu 22.04
2. ROS2 Humble (推荐使用 Desktop-Full installation)
3. 依照官方文档编译 [Livox SDK2](https://github.com/Livox-SDK/Livox-SDK2/blob/master/README.md) 
4. 依照官方文档编译 [Realsense SDK2](https://dev.intelrealsense.com/docs/compiling-librealsense-for-linux-ubuntu-guide)

## 下载与安装
**1. 下载本仓库**
``` shell
git https://github.com/CUHKSiriusLeggedRobotTeam/sensor-launcher-beta.git 
```

**2. 在ROS2环境下编译项目文件**
```
source /opt/ros/humble/setup.bash
cd sensor_launcher
colcon build
source ./install/setup.bash
```

**3. 您可以单独启动不同的传感器（3颗鱼眼相机，2颗双目深度相机，1颗激光雷达），参考如下指令**
``` shell
ros2 launch usb_cam multi_camera_launch.py # launch 3 fish-eye cameras
ros2 launch livox_ros_driver2 vanilla_MID360_launch.py # launch MID360 lidar
ros2 launch realsense2_camera rs_multi_camera_launch.py serial_no1:=<rs_cam1_serial-num> serial_no2:=<rs_cam2_serial-num> # launch 2 realsense D435
```
其中，Realsense 设备的序列号可以经由该命令查询 `rs-enumerate-devices -s` 以替换命令中的 `rs_cam_serial-num`

**4. 您可以一次性启动全部传感器，参考如下指令**
``` shell
cd script
sudo chmod a+x launch-all-in-one.sh
source launch-all-in-one.sh
```
或使用
``` shell
ros2 launch usb_cam launch_all_launch.xml
```

**5. 若需要设置开机自启动，您可以开启守护进程中对应的 service**
``` shell
sudo systemctl enable quadruped-sensor-launcher.service # enable auto-launch from daemon-service
sudo systemctl disable quadruped-sensor-launcher.service # disable auto-launch from daemon-service
sudo systemctl start quadruped-sensor-launcher.service # launch all sensors manually from daemon-service
sudo systemctl stop quadruped-sensor-launcher.service # stop all sensors manually from daemon-service
```

**6. 配置鱼眼相机**
- 若需要修改鱼眼相机的参数，例如信号格式/分辨率，您可以修改如下文件中对应关键字的值 `<sensor-launcher-dir>/src/usb_cam/config/param_<?>.yaml`

**7. 配置雷达 IP**
- 为了使得软件适应新的雷达IP (在此之前，需要先修改雷达的IP)，您可以修改如下文件中对应关键字的值 `<sensor-launcher-dir>/src/livox_ros_driver2/config/MID360_config.json`
```
  "MID360": {
    "host_net_info" : {
      "cmd_data_ip" : "192.168.123.$(HOST_IP)",
      "push_msg_ip": "192.168.123.$(HOST_IP)",
      "point_data_ip": "192.168.123.$(HOST_IP)",
      "imu_data_ip" : "192.168.123.$(HOST_IP)",
      "log_data_ip" : "192.168.123.$(HOST_IP)"
    }
  },
  "lidar_configs" : [
    {
      "ip" : "192.168.123.$(LIDAR_IP)"
      }
  ]
```
