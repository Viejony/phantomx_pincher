#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
import math
from std_msgs.msg import String
from sensor_msgs.msg import Joy

key_mapping = { 'q': [-1,  0,  0,  0,  0],  # -axis1: -x
                'w': [ 1,  0,  0,  0,  0],  # +axis1: +x
                'a': [ 0, -1,  0,  0,  0],  # -axis2: -y
                's': [ 0,  1,  0,  0,  0],  # +axis2: +y
                'z': [ 0,  0, -1,  0,  0],  # -axis3: -z
                'x': [ 0,  0,  1,  0,  0],  # +axis3: +z
                'e': [ 0,  0,  0,  1,  0],  # button1: -delta
                'r': [ 0,  0,  0,  0,  1],  # button2: +delta
                }
n_rate = 10
axis_scale = None
zero_axes_values = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
zero_buttons_values = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
key_time = None
joy_msg = None


def keys_cb(msg):
	global key_time, joy_msg
	if len(msg.data) == 0 or not key_mapping.has_key(msg.data[0]):
		return # unknown key
	values = key_mapping[msg.data[0]]
	axes_values = zero_axes_values[:]
	buttons_values = zero_buttons_values[:]
	for i in range(0,3):
		axes_values[i] = values[i] * axis_scale
	for j in range(0,2):
		buttons_values[j] = values[j+3]
	joy_msg.axes = axes_values[:]
	joy_msg.buttons = buttons_values[:]
	key_time = rospy.Time.now()


def fetch_param(name, default):
	if rospy.has_param(name):
		return rospy.get_param(name)
	else:
		print("parameter {} not defined. Defaulting to {}".format(name, default))
		return default


def send_joy():
	now = rospy.Time.now()
	diff = (now - key_time).to_sec()
	if diff > 0.2:
		joy_msg.axes = zero_axes_values[:]
		joy_msg.buttons = zero_buttons_values[:]
	joy_pub.publish(joy_msg)


if __name__ == '__main__':

	# Configuring node
	rospy.init_node('keys2joy')
	rate = rospy.Rate(n_rate)
	key_time = rospy.Time.now()

	# Publisher: Joy topic
	joy_pub = rospy.Publisher('/joy', Joy, queue_size=1)
	joy_msg = Joy()

	# Subscriber: keys topic
	rospy.Subscriber('keys', String, keys_cb)

	# Fetching parameters
	axis_scale = fetch_param('~axis_scale', 1.0)

	# Loop	
	while not rospy.is_shutdown():
		
		# Sending Twist message and sleeping
		send_joy()
		rate.sleep()
