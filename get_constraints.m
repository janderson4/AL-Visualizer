function [constraint_vals] = get_constraints(points)
%% calculates parameters for the constraints of the optimization problem
%% given the points making up the boundary of the design domain

nc=size(points,1);
area=0;
for i=1:nc
    f=mod(i-1,nc)+1; s=mod(i,nc)+1;
    area=area+0.5*(points(f,1)*points(s,2)-points(f,2)*points(s,1));
end
left_infeasible=(area<0);

constraint_vals=zeros(nc,3);

for i=1:nc
    f=mod(i-1,nc)+1; s=mod(i,nc)+1;
    disp([f s]);
    y_diff=points(s,2)-points(f,2);
    x_diff=points(s,1)-points(f,1);
    disp(["diffs" x_diff y_diff]);
    if (x_diff==0)
        b0=0;
        a0=1;
        c0=-points(s,1);
        if xor(y_diff<0, left_infeasible)
            a0=-a0;
            c0=-c0;
        end
    elseif (y_diff==0)
        b0=1;
        a0=0;
        c0=-points(s,2);
        if xor(x_diff>0, left_infeasible)
            b0=-b0;
            c0=-c0;
        end
    else
        disp("neither");
        slope=y_diff/x_diff;
        y_int=points(s,2)-slope*points(s,1);
        x_int=points(s,1)-points(s,2)/slope;
        disp([slope x_int y_int]);
        if x_int==0
            c0=0;
            b0=1;
            a0=-slope;
            if xor(left_infeasible,x_diff>0)
                b0=-b0;
                a0=-a0;
            end
        else
            c0=1;
            a0=-1/x_int;
            b0=-1/y_int;
            disp([a0 b0 c0]);
            disp([x_int>0,~left_infeasible,y_diff>0]);
            disp(xor(x_int>0,xor(~left_infeasible,y_diff>0)));
            % the second statement tells you whether the infeasible section is
            % actually desired to be on the left
            if xor(x_int>0,xor(~left_infeasible,y_diff>0))
                a0=-a0;
                b0=-b0;
                c0=-c0;
            end
        end
    end
    constraint_vals(i,:)=[a0 b0 c0];
end
end