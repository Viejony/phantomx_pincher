#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
key_publisher.py

This aplication publish keystrokes. Generates string messages in 'keys' topic.
'''
import sys, select, tty, termios
import rospy
from std_msgs.msg import String

if __name__ == '__main__':

	# Configuring node
	key_pub = rospy.Publisher('keys', String, queue_size=1)
	rospy.init_node("keyboard_driver")
	rate = rospy.Rate(100)

	# Setting I/O
	old_attr = termios.tcgetattr(sys.stdin)
	tty.setcbreak(sys.stdin.fileno())
	print("Publishing keystrokes. Press Ctrl-C to exit...")

	# Loop
	while not rospy.is_shutdown():
		if select.select([sys.stdin], [], [], 0)[0] == [sys.stdin]:
			key_pub.publish(sys.stdin.read(1))
		rate.sleep()
	termios.tcsetattr(sys.stdin, termios.TCSADRAIN, old_attr)
