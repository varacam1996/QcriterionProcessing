clear all
close all
clc

load("PreGraph.mat")
simindex = [1,4];

%% Graphing

counter = 0;
iterations = length_time*3;
m = 1;

for i = 1:length_time
fig = figure('Name','Qcriterion' ,'InvertHardcopy','off','Visible','off');
set(fig,'Units', 'inches','Position',[2 3 15 12])


for j = 1:2
    
    counter = counter +1;
    perc = counter/(length_time*2)*100

k = simindex(j);

subplot(2,1,j)



%p = patch(s);
s = isosurface(X,Y,Z,vq{k,i},5);

p = patch(s);
isonormals(X,Y,Z,vq{k,i},p)

fs1 = 14;
ax(j) = gca;

set(p,'FaceColor',[0.5 1 0.5]);  
set(p,'EdgeColor','none');
camlight;
lighting gouraud;


set(ax(j),'XLim', [400 700])
set(ax(j),'YLim', [0 10])
set(ax(j),'ZLim', [-10 0])
set(ax(j),'XTick',xt,'Fontsize',fs1)
set(ax(j),'YTick',yt,'Fontsize',fs1)
set(ax(j),'ZTick',zt,'Fontsize',fs1)


% set(gca , is used to set the lim
% of the axis and to change any
% property of the axiz in general


xlabel('$x$ (mm)', 'Interpreter', 'latex', 'FontSize',fs1)
ylabel('$y$ (mm)', 'Interpreter', 'latex', 'FontSize',fs1)
zlabel('$z$ (mm)', 'Interpreter', 'latex', 'FontSize',fs1)
title('Qcriterion Isosurface Isovalue = 5','Interpreter', 'latex', 'FontSize',fs1 + 2,'FontWeight','bold')

%view([0,90])
%view([45 45])
view([0 0])

%eval(sprintf('savefig("Figures/Ramp_%s")',time1(i)))

end

% figure properties

FrameVector(i) = getframe(gcf);

end


v = VideoWriter('Ramp_VIDEO_sept22_XZ','MPEG-4');
v.FrameRate = 1;
v.Quality = 100;


open(v)
writeVideo(v,FrameVector)
close(v)





