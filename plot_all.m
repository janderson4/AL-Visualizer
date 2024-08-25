function [limits] = plot_all(orig_axes, iter_axes, lm_axes, limits0,x,x0,step, ...
    constraint_vals,lambda,mu, LM_history)
%% returns axis limits for plotting for a particular iteration
limits=zeros(1,4);
limits(1)=min([limits0(1) x0(1)-limits0(5) x(1)-limits0(5)]);
limits(2)=max([limits0(2) x0(1)+limits0(5) x(1)+limits0(5)]);
limits(3)=min([limits0(3) x0(2)-limits0(6) x(2)-limits0(6)]);
limits(4)=max([limits0(4) x0(2)+limits0(6) x(2)+limits0(6)]);

cla(orig_axes,'reset');
hold(orig_axes, 'on');
objective_plot(orig_axes,step,limits,constraint_vals,1,x,x0);
hold(orig_axes, 'off');

cla(iter_axes,'reset');
hold(iter_axes, 'on');
plot_AL(iter_axes, step,limits,@AL,x,x0)
hold(iter_axes, 'off');

cla(lm_axes,'reset');
hold(lm_axes, 'on');
plot_LMs(lm_axes, LM_history)
hold(lm_axes, 'off');

function [g] = constraints(x)
    g=constraint_vals*[x;1];
end
function [tot] = AL(x)
    g2=max(constraints(x),-lambda/mu);
    tot=obj_wrapper(x)+lambda'*g2+mu/2*sum(g2.^2);
end
end