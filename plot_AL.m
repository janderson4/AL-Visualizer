function [] = plot_AL(axes, iter,limits,AL,x,x0)

title(axes, "Contour of AL Function for Subproblem "...
    +iter,'FontSize',17);

ne=100;

x_ls=linspace(limits(1),limits(2),ne);
y_ls=linspace(limits(3),limits(4),ne);

[x_mesh,y_mesh]=meshgrid(x_ls,y_ls);

z_mesh=zeros(ne,ne);
for i=1:ne
    for j=1:ne
        z_mesh(i,j)=AL([x_mesh(i,j);y_mesh(i,j)]);
    end
end

[~,h]=contour(axes, x_mesh,y_mesh,z_mesh);

old_levels=get(h,'LevelList');
diff=old_levels(2)-old_levels(1);
new_levels=zeros(1,size(old_levels,2)*2-1);
new_levels(1:2:end)=old_levels;
new_levels(2:2:end)=new_levels(1:2:end-1)+diff/2;
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2,'LevelList',new_levels)

xlabel(axes, 'x'), ylabel(axes, 'y')
xlim(axes, [limits(1) limits(2)]);
ylim(axes, [limits(3) limits(4)]);
axes.XAxis.FontSize = 10;
axes.YAxis.FontSize = 10;

width=limits(2)-limits(1);
change=norm(x-x0);
gray=0.2*ones(1,3);
if (change>0.08*width)
    factor=0.05;
    start=x0+factor*(x-x0);
    quiver(axes, start(1),start(2),x(1)-x0(1),x(2)-x0(2),'LineWidth',0.9,'Color',...
        gray,'MaxHeadSize',0.3);
end

x0_mark=scatter(axes, x0(1),x0(2),42,'r', 'filled');
x_mark=scatter(axes, x(1),x(2),42,'k', 'filled');
subsets=[x0_mark,x_mark];
labels=["Point at step "+num2str(iter-1),"Point at step "+num2str(iter)];
legend(axes, subsets,labels, 'FontSize',11);

end