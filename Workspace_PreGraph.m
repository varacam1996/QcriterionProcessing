clear all
close all
clc

addpath("Data/")
load("QSimData.mat")
load("GriddedQ_sept21.mat")
rmpath("Data/")

time = 25:25:750;
time = time - 2;

time1 = string(time);

length_time = length(time);
length_sim = length(sim);


xt = 400:50:700; 
yt = 0:5:15;
zt = -10:2:0;

simindex = [1 3 4];
