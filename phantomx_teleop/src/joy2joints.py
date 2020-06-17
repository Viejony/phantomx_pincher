#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
import math
from sensor_msgs.msg import Joy
from trajectory_msgs.msg import JointTrajectory
from trajectory_msgs.msg import JointTrajectoryPoint
from control_msgs.msg import JointTrajectoryControllerState

rate = 10.0
dur = 1.0/rate
joint_pub = None
joint_msg = None
deltas = [0.0, 0.0, 0.0, 0.0, 0.0]
actual_joints = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
initial_joints = 0
joint_step = [0.1, 0.1, 0.1, 0.1, 0.001]
min_joints = [-2.617993, -2.617993, -2.617993, -2.617993, 0.0]
max_joints = [2.617993, 2.617993, 2.617993, 2.617993, 0.015]

def set_delta_values(msg):
	deltas[0] = msg.axes[0]
	deltas[1] = msg.axes[1]
	deltas[2] = msg.axes[2]
	deltas[3] = msg.axes[3]
	for i in range(0, 4):
		deltas[i] = msg.axes[i]
	if msg.buttons[0] > msg.buttons[1]:
		deltas[4] = -1.0
	if msg.buttons[0] < msg.buttons[1]:
		deltas[4] = 1.0
	if msg.buttons[0] == msg.buttons[1]:
		deltas[4] = 0.0

def set_joint_values(msg):
	global initial_joints
	global actual_joints
	if initial_joints == 0:
		initial_joints = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
		for i in range(0, 5):
			initial_joints[i] = msg.actual.positions[i]
		initial_joints[4] = initial_joints[5]
		actual_joints = initial_joints
		print("Initial Joints Values")
		print(initial_joints)

def send_joint_trajectory_msg():
	global actual_joints
	if actual_joints == 0:
		return

	# Setting joint values and Checking max and min  values of every joint
	for i in range(0, 5):
		if deltas[i] != 0.0:
			x = actual_joints[i] + deltas[i]*joint_step[i]
		else:
			x = actual_joints[i]
		if x < min_joints[i]:
			x = min_joints[i]
		if x > max_joints[i]:
			x = max_joints[i]
		actual_joints[i] = x
	actual_joints[5] = actual_joints[4]

	# Setting points values in message
	jtp = JointTrajectoryPoint()
	jtp.positions = actual_joints
	jtp.velocities = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
	jtp.time_from_start = rospy.Duration(dur, 0)
	joint_msg.points = [jtp]

	# Publishing
	joint_pub.publish(joint_msg)
	#print(actual_joints)

if __name__ == '__main__':

	# Configuring node
	rospy.init_node('joy2joints')
	joint_pub = rospy.Publisher('/arm_controller/command', JointTrajectory, queue_size=1)
	rospy.Subscriber('/joy', Joy, set_delta_values)
	rospy.Subscriber('/arm_controller/state', JointTrajectoryControllerState, set_joint_values)
	rate = rospy.Rate(rate)
	key_stamp = rospy.Time.now()

	# Setting message
	joint_msg = JointTrajectory()
	joint_msg.joint_names = ["shoulder_joint","lower_arm_joint",
	"upper_arm_joint","wrist_joint","finger_1_joint","finger_2_joint"]

	# Loop	
	while not rospy.is_shutdown():
		
		# Sending Twist message and sleeping
		send_joint_trajectory_msg()
		rate.sleep()