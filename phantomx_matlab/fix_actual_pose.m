function fix_actual_pose()

global actual_pose;
p = get_actual_pose();
actual_pose = [p(1:3), p(7)];

end