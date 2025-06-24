#!/usr/bin/bash

pushd `pwd` > /dev/null
cd `dirname $0`/..
echo "Working Path: "`pwd`

source /opt/ros/humble/setup.bash
source ./install/setup.bash

ros2 launch usb_cam launch_all_launch.xml

# for nuc
# if [ `nproc` -eq 8 ]
# then
#	echo "Script runs on NUC."
#	ros2 launch realsense2_camera rs_multi_camera_launch.py camera_namespace1:=front serial_no1:=_213622070849 enable_color1:=false camera_namespace2:=rear serial_no2:=_151222073901 enable_color2:=false &
#	ros2 launch livox_ros_driver2 vanilla_MID360_launch.py &
#	ros2 launch usb_cam multi_camera_launch.py &
# for h100
# elif [ `nproc` -eq 4 ]
# then
# 	echo "Script runs on H100."
#	ros2 launch realsense2_camera rs_launch.py camera_namespace:=h100 enable_color:=false &
# fi

popd > /dev/null
