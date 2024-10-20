function [value]=distance(node1_x,node1_y,node2_x,node2_y)
dist_x=node1_x-node2_x;
dist_y=node1_y-node2_y;
value=sqrt(power(dist_x,2)+power(dist_y,2));