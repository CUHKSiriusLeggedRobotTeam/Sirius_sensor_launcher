# Installation & Usage Guide 
[中文版](./README-CN.md) | [English](./README.md)

## Prerequisite
> [!Note]
> The following dependencies have been locally deployed.

This configuration is tested on Ubuntu 22.04 with ROS2 Humble. Before using, please make sure that the following environments are prepared:
1. Ubuntu 22.04
2. ROS2 Humble (Desktop-Full installation is recommended)
3. Build from source for the Livox SDK2 as [guided](https://github.com/Livox-SDK/Livox-SDK2/blob/master/README.md)
4. Build from source for the Realsense SDK2 as [guided](https://dev.intelrealsense.com/docs/compiling-librealsense-for-linux-ubuntu-guide)

## Download & Install
**1. Download this repo by**
``` shell
git https://github.com/CUHKSiriusLeggedRobotTeam/sensor-launcher-beta.git
```

**2. Build ROS2 project**
```
source /opt/ros/humble/setup.bash
cd sensor_launcher
colcon build
source ./install/setup.bash
```

**3. Try launching sensors separately by**
``` shell
ros2 launch usb_cam multi_camera_launch.py #
ros2 launch livox_ros_driver2 vanilla_MID360_launch.py #
ros2 launch realsense2_camera rs_multi_camera_launch.py serial_no1:=<rs_cam1_serial-num> serial_no2:=<rs_cam2_serial-num>
```
where the serial number of realsense D435 can be queried by `rs-enumerate-devices -s`

**4. Launch all sensors manually from terminal by**
``` shell
cd script
sudo chmod a+x launch-all-in-one.sh
source launch-all-in-one.sh
```
or
``` shell
ros2 launch usb_cam launch_all_launch.xml
```

**5. Launch all sensors automatically after powered-up from daemon by**
``` shell
sudo systemctl enable quadruped-sensor-launcher.service # enable auto-launch from daemon-service
sudo systemctl disable quadruped-sensor-launcher.service # disable auto-launch from daemon-service
sudo systemctl start quadruped-sensor-launcher.service # launch all sensors manually from daemon-service
sudo systemctl stop quadruped-sensor-launcher.service # stop all sensors manually from daemon-service
```

**6. Camera Configuration**
- To change the signal format and resolution of cameras, please modify the file located at `<sensor-launcher-dir>/src/usb_cam/config/param_<?>.yaml`

**7. Lidar IP Configuration**
- To accommodate new IP of lidar (the IP of lidar should be changed beforehead), please modify the file located at `<sensor-launcher-dir>/src/livox_ros_driver2/config/MID360_config.json`
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
