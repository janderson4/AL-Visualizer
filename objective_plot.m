function [] = objective_plot(axes, iter,limits,constraint_vals,progress,x,x0)

%% original objective
title(axes, "Contour of f(x,y) With Constraints",'FontSize',17);

ne=100;
nc=size(constraint_vals,1);

x_ls=linspace(limits(1),limits(2),ne);
y_ls=linspace(limits(3),limits(4),ne);

[x_mesh,y_mesh]=meshgrid(x_ls,y_ls);

z_mesh=zeros(ne,ne);
for i=1:ne
    for j=1:ne
        z_mesh(i,j)=obj_wrapper([x_mesh(i,j);y_mesh(i,j)]);
    end
end

%figure, hold on, set(gca,'CLim',[0 12])
[~,h]=contour(axes, x_mesh,y_mesh,z_mesh);

old_levels=get(h,'LevelList');
diff=old_levels(2)-old_levels(1);
new_levels=zeros(1,size(old_levels,2)*2-1);
new_levels(1:2:end)=old_levels;
new_levels(2:2:end)=new_levels(1:2:end-1)+diff/2;
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2,'LevelList',new_levels)

line_width=2.1;
for i=1:nc
    a0=constraint_vals(i,1);
    b0=constraint_vals(i,2);
    c0=constraint_vals(i,3);
    col=palette(i);
    if b0==0 % this is a vertical line
        plot(axes, -c0/a0*ones(1,ne),y_ls,'Color',col,'LineWidth',line_width);
        xs=[-c0/a0 -c0/a0];
        if a0>0
            xs=[xs limits(2) limits(2)];
        else
            xs=[xs limits(1) limits(1)];
        end
        fill(axes, xs,[limits(3) limits(4) limits(4) limits(3)],'k','FaceAlpha',0.2,'EdgeColor','none')
    else
        plot(axes, x_ls,(-c0-a0*x_ls)/b0,'Color',col,'LineWidth',line_width);
        ys=[(-a0*limits(1)-c0)/b0 (-a0*limits(2)-c0)/b0];
        if b0>0
            ys=[ys limits(4) limits(4)];
        else
            ys=[ys limits(3) limits(3)];
        end
        fill(axes, [limits(1) limits(2) limits(2) limits(1)],ys,'k','FaceAlpha',0.2,'EdgeColor','none')
    end
end

xlabel(axes, 'x'), ylabel(axes, 'y')

xlim(axes, [limits(1) limits(2)]);
ylim(axes, [limits(3) limits(4)]);
axes.XAxis.FontSize = 10;
axes.YAxis.FontSize = 10;

if progress
    width=limits(2)-limits(1);
    change=norm(x-x0);
    gray=0.2*ones(1,3);
    if (change>0.08*width)
        factor=0.05;
        diff=x-x0;
        
        start=x0;
        if norm(diff)>0.2*width
            start=start+factor*(x-x0);
        else
            diff=diff*0.95;
        end
        quiver(axes, start(1),start(2),diff(1),diff(2),'LineWidth',0.9,'Color',...
            gray,'MaxHeadSize',0.4);
    end
    
    x0_mark=scatter(axes, x0(1),x0(2),42,'r', 'filled');
    x_mark=scatter(axes, x(1),x(2),42,'k', 'filled');
    subsets=[x0_mark,x_mark];
    labels=["Point at step "+num2str(iter-1),"Point at step "+num2str(iter)];
    legend(axes, subsets,labels, 'FontSize',11);
end

end