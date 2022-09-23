% This script takes raw q data and grids it
% so it is ready to make an isosurface


clear all
close all
clc

tic
%% Loading Data

ff = 1.4012:0.0004:1.72;

addpath("Data")

load("Q_Ramp_Compressed.mat")



%% Meshgrid


x = real(400:1:700)';
y = real(0:0.05:15)';
z = real(-10:0.25:0)';
[X,Y,Z] = meshgrid(x,y,z);

[X2,Y2] = meshgrid(x,y);


%% Assign Data to variables

sim = ["R05","R1","R2","R4"];
Sim_Length = length(sim);

time = 25:25:800;
time = time - 2;

Time_Length = length(time);

TIMES = ff(time);

%
% QC = cell(Sim_Length,Time_Length);

QC = Q_Ramp;

clear Q_Ramp

vq = cell(Sim_Length,Time_Length);

Xmm = cell(Sim_Length,Time_Length);
Ymm = cell(Sim_Length,Time_Length);
Zmm = cell(Sim_Length,Time_Length);




for i = 1:Time_Length
    for j = 1:Sim_Length
    Xmm{j,i} = XYZ_Ramp{j,i}(:,1);
    Ymm{j,i} = XYZ_Ramp{j,i}(:,2);
    Zmm{j,i} = XYZ_Ramp{j,i}(:,3);
    %QC{j,i} = real(eval(sprintf('Q_%s{1,time(i)}(:,1)',sim(j))));         
    vq{j,i} = griddata(Xmm{j,i}(:,1),Zmm{j,i}(:,1),Ymm{j,i}(:,1),QC{j,i}(:,1),X,Z,Y);

    end
end


save("GriddedQ_sept22_Ychange","vq","-v7.3")


