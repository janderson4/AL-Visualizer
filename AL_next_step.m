function [x, new_lambda, obj] = AL_next_step(x0, constraint_vals, lambda, mu)
%% given a point in the optimization, calculates the next point and returns
%% it along with the new lagrange multipliers and handles to plots of the 
%% points with the constrained and unconstrained problem

x= fminunc(@AL,x0);

new_lambda=max(0,lambda+mu*constraints(x));

obj=obj_wrapper(x);

function [g] = constraints(x)
    g=constraint_vals*[x;1];
end
function [tot] = AL(x)
    g2=max(constraints(x),-lambda/mu);
    tot=obj_wrapper(x)+lambda'*g2+mu/2*sum(g2.^2);
end
end