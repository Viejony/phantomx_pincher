# phantomx_pincher

This meta package contains multiple packages of the PhantomX Pincher robot arm, intended to simulate the robot. Packages contained in this project are:
- phantomx_description: Package with .xacro files and 3D files of PhantomX Pincher robot arm.
- phantomx_gazebo: Package with config files, Gazebo world files and multiple models 3D. This package allows to simulate the robot in Gazebo Simulation Platform.
- phantomx_teleop: Packege that contains some scripts that allow you to control the simulated robot in Gazebo with the keyboard, gamepads, etc.
- phantomx_matlab: Script made with MATLAB. Gives a GUI for operate the robot.

## Installation

In this example, we assume that you are using Ubuntu 18.04 with ROS-Melodic. Install these ROS packages in your ROS distro:

```
sudo apt install ros-melodic-controller-manager ros-melodic-joint-state-publisher ros-melodic-joy ros-melodic-xacro ros-melodic-effort-controller
```

The gripper of this robot needs a Gazebo plugin that makes grasp task simpler. Go to this [link](https://github.com/JenniferBuehler/gazebo-pkgs/wiki/Installation) and follow instructions to install that plugin.

Then, clone this repository:

```
cd ~/catkin_ws/src
git clone https://github.com/Viejony/phantomx_pincher.git
```

Now, do catkin_make in your workspace:

```
cd ~/catkin_ws
catkin_make
```

## How to run

To run Gazebo simulation of PhantomX Pincher in a test stage with some color blocks, run this command:

```
roslaunch phantomx_gazebo phantomx_gazebo.launch world:=stage_02.world
```

