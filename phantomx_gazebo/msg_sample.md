# MSG Samples
This file contain some samples of "trajectory_msgs/JointTrajectory" message of "/arm_controller/command" topic, used in Gazebo.

## Home
rostopic pub /arm_controller/command trajectory_msgs/JointTrajectory '{joint_names: ["shoulder_joint","lower_arm_joint","upper_arm_joint","wrist_joint","finger_1_joint","finger_2_joint"], points: [{positions:[0.0, 0.0, 0.0, 0.0, 0.015, 0.015], velocities:[0, 0, 0, 0, 0, 0],time_from_start: [3.0,0]}]}' -1

## Other
rostopic pub /arm_controller/command trajectory_msgs/JointTrajectory '{joint_names: ["shoulder_joint","lower_arm_joint","upper_arm_joint","wrist_joint","finger_1_joint","finger_2_joint"], points: [{positions:[0.75, -0.75, -0.75, 0.75, 0.015, 0.015], velocities:[0, 0, 0, 0, 0, 0],time_from_start: [3.0,0]}]}' -1

## L
rostopic pub /arm_controller/command trajectory_msgs/JointTrajectory '{joint_names: ["shoulder_joint","lower_arm_joint","upper_arm_joint","wrist_joint","finger_1_joint","finger_2_joint"], points: [{positions:[0.0, -1.57, 0.0, 0.0, 0.015, 0.015], velocities:[0, 0, 0, 0, 0.01, 0.01],time_from_start: [3.0,0]}]}' -1