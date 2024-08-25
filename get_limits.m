function [limits] = get_limits(points)
xmin=min(points(:,1)); xmax=max(points(:,1));
ymin=min(points(:,2)); ymax=max(points(:,2));
x_diff1=xmax-xmin;
y_diff1=ymax-ymin;
extend=0.1;

% limits for plotting: x, y, low then high
limits=[xmin-x_diff1*extend,xmax+x_diff1*extend,ymin-y_diff1*extend,...
    ymax+y_diff1*extend,x_diff1*extend,y_diff1*extend];
end