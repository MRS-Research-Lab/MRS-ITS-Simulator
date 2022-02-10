%function to transform the vehicle:
function Veh_Transform(Veh_num, posx, posy, psi)

%accessing the global variables:
global Vehicles Time

%Accessing the current vehicle's position:
X = posx;
Y = posy;
Z = Vehicles{4,Veh_num}.Z;
theta = psi;
Vehicle = Vehicles{3,Veh_num}; 

%Calculating the Rotation Matrix in the new angle:
T_G_v = [cos(theta) -sin(theta)   0 X;...
         sin(theta)  cos(theta)   0 Y;...
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

%Updating the Vehicle's position information:
Vehicles{4,Veh_num}.X = X;
Vehicles{4,Veh_num}.Y = Y;
Vehicles{4,Veh_num}.Z = Z;
Vehicles{4,Veh_num}.head = theta;

%updating the data logger states:
Vehicles{5,Veh_num}.PosX(1,Time.N) = X;
Vehicles{5,Veh_num}.PosY(1,Time.N) = Y;
Vehicles{5,Veh_num}.Heading(1,Time.N) = theta;

end