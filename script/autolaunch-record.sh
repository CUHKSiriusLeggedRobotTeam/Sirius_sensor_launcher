#!/usr/bin/bash
sleep 10

pushd `pwd` > /dev/null
cd `dirname $0`/..
echo "Working Path: "`pwd`

source /opt/ros/humble/setup.bash
source ./install/setup.bash
ros2 launch usb_cam launch_all_launch.xml &

sleep 10
mkdir bag && cd bag
ros2 bag record -a

popd > /dev/null
