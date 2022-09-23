clear all
close all

tic
addpath("Data/")
load('Q_data_apr8.mat');


data = Q;

size = length(data);
ff=1.40120:0.0004:1.72;

Vel = cell(1,length(ff));
Ydata = cell(1,length(ff));


for bb=1:length(ff)
   Qc{bb} =  data{bb}(:,1);
end

Xdata = data{1}(:,2);
%Xdata = Xdata;
Ydata = data{1}(:,3);
Zdata =  data{1}(:,4);
%Vel =  Vel';
Zdata = Zdata';
Zdata2 = Zdata;
%Ydata = Ydata';
zsize = length(Zdata(1,:));
z_data_10= Zdata - 10;
delta = zeros(1,length(z_data_10));

for n = 1:zsize
        delta(n) = z_data_10(1,n) + 10;
        Zdata2(1,n) = z_data_10(1,n) - 2*delta(n);
end

Z_NEW = zeros(zsize*2,1);

for j = 1:zsize
    Z_NEW(j) = z_data_10(j);
    Z_NEW(zsize + j) = Zdata2(j);
end
%% Must mirror again to get a 40mm data set

Z_NEW_20 = Z_NEW - 20;
Zdata20 = zeros(zsize*2,1);

clear delta
delta = zeros(length(Z_NEW_20),1);
  for n = 1:zsize*2
    delta(n) = Z_NEW_20(n) + 20;  
    Zdata20(n) = Z_NEW_20(n) - 2*delta(n);
  end
  
  
Z_NEW2 = zeros(zsize*4,1);
for j = 1:zsize*2
    
    Z_NEW2(j) = Z_NEW_20(j);
    Z_NEW2(zsize*2 + j) = Zdata20(j);
       
end
clear Z_NEW Z_NEW_20 Zdata Zdata2 Zdata20

%% placing the data in a new array


Qc_2 = cell(1,size);


for i = 1:size
    Qc_2{1,i} = [Qc{1,i}(:,1);Qc{1,i}(:,1);Qc{1,i}(:,1);Qc{1,i}(:,1)];
end


clear vort_i vort_k

 Xdata2 = zeros(length(Xdata(:,1))*4,1);

for i = 1:size
Xdata2(:,1) = [Xdata(:,1);Xdata(:,1);Xdata(:,1);Xdata(:,1)];
end



Ydata2 = zeros(length(Xdata(:,1))*4,1);

for i = 1:size
Ydata2(:,1) = [Ydata(:,1);Ydata(:,1);Ydata(:,1);Ydata(:,1)];
end

clear Xdata Ydata

Data_new =  cell(1,size);

for i = 1:size
    Data_new{1,i}(:,1) = Qc_2{1,i}(:,1);
    
end

Data_new{1,i}(:,2) = Ydata2{1,i}(:,1);
    Data_new{1,i}(:,3) = Xdata2(:,1);
    Data_new{1,i}(:,4) = Z_NEW2(:,1);   

Size = length(Data_new{1,1}(:,1));
Zdata_Positive = cell(1,size);

  
%% Mirror data onto the positive Z axis

for m = 1:size
   Zdata_Positive{1,m}(:,1) = Z_NEW2(:,1) - 2*Z_NEW2(:,1);
end



%% Appending the data onto new data
Z_NEW3 = cell(1,size);
clear m
for m = 1:size
    Z_NEW3{1,m}(:,1) = Z_NEW2(:,1);
    Z_NEW3{1,m}(Size + (1:Size),1) = Zdata_Positive{1,m}(:,1);
end

clear Z_NEW2 Zdata_Positive 
%% placing the data in a new array

clear i


Qc_new =  cell(1,size);

for i = 1:size
    Qc_New{1,i}(: ,1) = [Qc_2{1,i}(: ,1);Qc_2{1,i}(: ,1)];
end


clear Qc
XdataNew = zeros(Size*2,1);

XdataNew(:,1) = [Xdata2(:,1);Xdata2(:,1)];

clear Xdata2

YdataNew = zeros(Size*2,1);

YdataNew(:,1) = [Ydata2(:,1);Ydata2(:,1)];

clear Ydata2
Data_new =  cell(1,size);

for i = 1:size
     Data_new{1,i}(:,1) = Qc_New{1,i}(:,1);
     Data_new{1,i}(:,2) = XdataNew{1,i}(:,1);
     Data_new{1,i}(:,3) = YdataNew(:,1);
     Data_new{1,i}(:,4) = Z_NEW3{1,i}(:,1) +10;   
end

clear Qc_new XdataNew Z_NEW3

save("Data_Qc.mat", "Data_new",'-v7.3');
toc    
   
      

