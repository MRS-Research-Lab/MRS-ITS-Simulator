%This is the main function of the Simulator, responsible for the full
%control, animation of the vehicles.
%By: Omar M. Shehata, PhD

%Cleaning up the environment before working.
clc; clear global; clear; close all;
%Data_Run_Me;
global Time Vehicles Data Figures %Accessing the required global variables
addpath(genpath(pwd)); %Add the curretnworking directory to the path of the matlab to be used:

%Load the data produced from the simulations earlier and save it to global variable:
%The workspace provided is for the integrated architecture test to
%visualize the motion of the vehicles
Data.X = load('Xdata.mat');
Data.Y = load('Ydata.mat');
Data.Psi = load('Psidata.mat');


%Run some initialization functions:
%Data_Run_Me;
Initialize();  %Initialization Function (Initialize time and Veh params)


%The main loop:
%=================
stepsize = 10;
clc;
title('Integrated Scenario for Platoon Long/Lat Control');
input('Press Enter to Start Simulation...');
f1 = figure(Figures.Main_Fig.handle);
%sp(1) = subplot(2,2,1); 
for i = 1:stepsize:size(Data.X.Xdata,1)  %for all available points.
    %check the view to be displayed:
    xmax = max(Data.X.Xdata(i,:));   %the most front vehicle
    xmin = min(Data.X.Xdata(i,:));   %the most back vehicle
    xlim([xmin+Data.Xoffset-3,(xmax+Data.Xoffset)+30]);
    for j = 1:size(Data.X.Xdata,2)  %for all the available vehicles
        x = Data.X.Xdata(i,j) + Data.Xoffset;
        y = Data.Y.Ydata(i,j) + Data.Yoffset;
        psi = Data.Psi.Psidata(i,j);
        Veh_Transform(j, x, y, psi)
    end
    pause(0.01);  %delay for animation purposes
end


