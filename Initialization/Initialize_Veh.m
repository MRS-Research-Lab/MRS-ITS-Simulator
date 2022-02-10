%function to initialize the Vehicles in the simulation:
function Initialize_Veh()

%initialize the global variables to be used:
global Figures Data

%initialize the main figure:
figure(Figures.Main_Fig.handle);


%Extract the information of the vehicles from the simulation:
Xdata = Data.X.Xdata;
Ydata = Data.Y.Ydata;
Psidata = Data.Psi.Psidata;
N_veh = size(Xdata,2);

%check the initial position in X for all vehicles:
xmin = min(Xdata(1,:)); %the least value in the first iteration (initialization).
ymin = min(Ydata(1,:)); %the least value in the first iteration (initialization).
Xoffset = 0 - xmin;  %the shift between the least value and the zero initial condition
SizY = Figures.Main_Fig.SizY;  %The width of the figure
lane_width = Figures.Main_Fig.LaneWid;
lane_num = Figures.Main_Fig.LaneNum;
Yoffset = SizY/2 - lane_width/2 - ymin;

%record the offsets calculated:
Data.Xoffset = Xoffset;
Data.Yoffset = Yoffset;

%Intialize the vehicle's in the way with spacing between them:
for i = 1:N_veh   %until all the required vehicle's are placed
    x = Xdata(1,i) + Xoffset;
    y = Ydata(1,i) + Yoffset;
    Psi = Psidata(1,i);
    Veh_init(x,y,Psi);
end

%check the view to be displayed:
xmax = max(Xdata(1,:));   %the most front vehicle
xlim([xmin+Xoffset-3,(xmax+Data.Xoffset)+30]);
ylim([SizY/2-(lane_width*lane_num*2),SizY/2+(lane_width*lane_num*2)]);

end