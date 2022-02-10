%function to initialize the map for simulation:
function Initialize_Map()

%initialize the global variables to be used:
global Figures Data

%initialize the main figure:
Figures.Main_Fig.handle = figure();title('Simulation Environment');

%Adjusting the view:
view(2); axis equal; %zlim([-1 3]); 
grid on;
xlabel('X-direction (m)'); ylabel('Y-direction (m)');


%initializing the main ground for the simulation:
Xdata = Data.X.Xdata;
Ydata = Data.Y.Ydata;
xmin = min(min(Xdata)); %the least value in X-direction
xmax = max(max(Xdata)); %the highest value in X-direction
ymin = min(min(Ydata)); %the least value in Y-direction
ymax = max(max(Ydata)); %the highest value in Y-direction
SizX = xmax - xmin;   %length of the X-direction

%LANE properties:
lane_width = 3;
lane_num = 4; n = lane_num/2;
offset = (lane_width * lane_num) / 2;  %half the road
SizY = max(ymax-ymin,lane_num*lane_num)* 4;  %width of view to be seen

%declare the patches to be used:
% patch('Faces', [1 2 3 4], 'Vertices',[0 0 -0.1;SizX 0 -0.1; ...
%     SizX SizY -0.1; 0 SizY -0.1; 0 0 -0.1], ...
%     'FaceColor','g');
% patch('Faces', [1 2 3 4], 'Vertices',[0 SizY/2 - 1*offset;...
%     SizX SizY/2 - 1*offset;...    
%     SizX SizY/2 + 1*offset; ...
%     0 SizY/2 + 1*offset], 'FaceColor',[0.5 0.5 0.5]);

%create random dark patches on the field:
N_dark = 1000;   %the number of dark patches created:
patch_siz = 2;
SizXi = int16(SizX);
yvals = [SizY/2 - (3)*offset, SizY/2 - (2)*offset, SizY/2 + (2)*offset,SizY/2 + (3)*offset];
for i = 1:N_dark
    xrand = randi(SizXi);
    yind = randi(size(yvals,2));yrand = yvals(1,yind);
    patch('Faces', [1 2 3 4], 'Vertices',[xrand yrand -0.05;...
    xrand+patch_siz yrand  -0.05;...    
    xrand+patch_siz yrand+patch_siz  -0.05; ...
    xrand yrand+patch_siz  -0.05], 'FaceColor',[0 0.9 0.5]);
end
%Draw the lines of the lanes:
for i = -lane_num/2:1:lane_num/2  %for every step between the lanes
    if i == -lane_num/2 || i == lane_num/2
        line([0 SizX],[SizY/2 + i*lane_width, SizY/2 + i*lane_width],'LineWidth',2,'Color','k');
    else
        line([0 SizX],[SizY/2 + i*lane_width, SizY/2 + i*lane_width],'LineWidth',2,'Color','w');
    end
end

%saving the view parameters of the vehicles;
Figures.Main_Fig.SizX = SizX;
Figures.Main_Fig.SizY = SizY;
Figures.Main_Fig.LaneWid = lane_width;
Figures.Main_Fig.LaneNum = lane_num;
% Figures.Main_Fig.Xmin = xmin; 
% Figures.Main_Fig.Xmax = SizX; 
% Figures.Main_Fig.Ymin = ymin; 
% Figures.Main_Fig.Ymin = SizY;
% 
% %initalize data figure:
% Figures.Data_Fig.handle = figure(); title('System Response');
% %Adjusting the view:
% axis equal; grid on;
% xlabel('Time (s)'); ylabel('Y-direction (m)');


end