%function to move the vehicle
function Veh_Rotate(Veh_num, theta)

%accessing the global variables:
global Vehicles

%Accessing the current vehicle's position:
X = Vehicles{4,Veh_num}.X;
Y = Vehicles{4,Veh_num}.Y;
Z = Vehicles{4,Veh_num}.Z;
Vehicle = Vehicles{3,Veh_num}; 

%Calculating the Rotation Matrix in the new angle:
T_G_v = [cosd(theta) -sind(theta) 0 X;...
         sind(theta)  cosd(theta) 0 Y;...
              0          0        1 Z;...
              0          0        0 1];
          
%Aceessing all the Vehicle properties:
Vert = Vehicle.Vertices.All;
Vertw = Vehicle.Vertices.Wheels;

%conduct the rotation of each vertix according to the rotation matrix:
Vert_r = T_G_v * [Vert'; ones(1,size(Vert,1))];
Vertw_r = T_G_v * [Vertw'; ones(1,size(Vertw,1))];

%Move the patches of the vehicle to the new location:
set(Vehicle.Patches.All,'Vertices',Vert_r(1:3,:)');
set(Vehicle.Patches.Wheels,'Vertices',Vertw_r(1:3,:)');

%updating the vehicle's angle of orientation:
Vehicles{4,Veh_num}.head = theta;

end