function [] = plot_LMs(axes, LM_history)
%% a plot of the values of all lagrange multipliers over the iterations of
%% this optimization

title(axes, "Lagrange Multiplier History",'FontSize',17);

n_iters=size(LM_history,2);
xlim(axes, [0 max(5,n_iters-1)])
max_y=max(LM_history,[],'all')*1.3;
if max_y~=0
    ylim(axes, [0 max_y])
end

for i=1:size(LM_history,1)
    % plot for a particular LM
    plot(axes, 0:n_iters-1,LM_history(i,:),'Color',palette(i),LineWidth=1.1, ...
        Marker='.',MarkerSize=16);
end
axes.XTick=unique(round(axes.XTick));
xlabel(axes, 'Step Number','FontSize',15)
ylabel(axes, 'LM Values','FontSize',15)
axes.XAxis.FontSize = 11;
axes.YAxis.FontSize = 11;

end