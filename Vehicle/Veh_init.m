function Veh_init(X,Y,head)
%The inputs to the vehicle should be its:
%   -position (X,Y) , orientation (head)
%   -Type of the vehicle is another important input (to red from truck, car,etc).
%   To be added later: (velocity, initial steering angle)

%The Vehicle frame is in the C.G. of the vehicle. The X-axis points forward
%in the direction of the vehicle motion. The Y-axis points towards the
%left-side of the vehicle. The Z-axis points in the vertical direction upwards

%accessing the global variables:
global Vehicles Parameters Time

%check if there are other vehicles created or not:
if(isempty(Vehicles)==1)  
    Vehicles = cell(1,1); veh_num = 1;  %assign vehicle number to 1
else
    veh_num = size(Vehicles,2) + 1; %the new vehicle is added to the list
end

%Initialize the colors array:
colors = 'brymgcmw';
% ind = randi(size(colors,2));
clr = colors(1,veh_num);

Vehicles{1,veh_num} = ['Vehicle - ' num2str(veh_num)];
%Parameters of the vehicle: define all the parameters below:
%The main dimensions of the vehicle:
L = Parameters.L; %The length of the vehicle (longitudinal direction) [in meters]
W = Parameters.W; %The width of the vehicle (lateral direction) [in meters]
H = Parameters.H; %The height of the vehicle (vertical direction) [in meters]
Rw = Parameters.Rw; %The radius of the wheel of the vehicle. [in meters]
a = Parameters.a; %The height of C.G. from the ground.
b = Parameters.b; %The position of C.G. from the front of the vehicle.
c = Parameters.c; %The position of C.G. in the lateral direction from any side of the vehicle.
d1 = Parameters.d1; %The distance of the center of the front wheel from front side.
d2 = Parameters.d2; %The distance of the center of the rear wheel from front side.
l2 = Parameters.l2; %The length of the front hood
l3 = Parameters.l3; %The vertical height of the front wind shield glass
l5 =Parameters.l5; %The vertical height of the rear wind shield glass
l6 = Parameters.l6; %The length of the rear hood. 

%Conducting the required calculations to find the remaining dimensions:
l1 = H - Rw - l3; %The vertical height of the front side of the car
l4 = L - l2 - l6; %The horizontal Length of the top roof of the car.
l7 = H - Rw - l5; %The vertical height of the rear side of the car.

%Calculating the position of the verticies of the vehicle in the vehicle 
%frame, using which we can draw the surfaces:
v1L  = [b        W/2  -a+Rw];          v1R  = [b        -W/2  -a+Rw]; 
v2L  = [b        W/2  -a+Rw+l1];       v2R  = [b        -W/2  -a+Rw+l1];
v3L  = [b-l2     W/2  -a+Rw+l1];       v3R  = [b-l2     -W/2  -a+Rw+l1];
v4L  = [b-1.4*l2     W/2  -a+Rw+l1+l3];    v4R  = [b-1.4*l2     -W/2  -a+Rw+l1+l3];
v5L  = [b-l2-l4  W/2  -a+Rw+l1+l3];    v5R  = [b-l2-l4  -W/2  -a+Rw+l1+l3];
v6L  = [b-l2-l4  W/2  -a+Rw+l1+l3-l5]; v6R  = [b-l2-l4  -W/2  -a+Rw+l1+l3-l5];
v7L  = [b-L      W/2  -a+Rw+l7];       v7R  = [b-L      -W/2  -a+Rw+l7];
v8L  = [b-L      W/2  -a+Rw];          v8R  = [b-L      -W/2  -a+Rw];
v9L  = [b-d2     0.5*W  -a+Rw];          v9R  = [b-d2     -0.5*W  -a+Rw];
v10L = [b-d1     0.5*W  -a+Rw];          v10R = [b-d1     -0.5*W  -a+Rw];

%Create the wheels:
N = 8;  %The number of points to be used in the visualization.
Wheels = zeros(N,3,4);  %initialize a zero 3D matrix (N-points rows, 3 columns (x,y,z) and 4 wheels.
for i = 1:N   %for all required points in the wheel.
    ang = (i-1)*360/N;
    Wheels(i,1:3,1) = v9L + [Rw*cosd(ang) 0 Rw*sind(ang)];
    Wheels(i,1:3,2) = v9R + [Rw*cosd(ang) 0 Rw*sind(ang)];
    Wheels(i,1:3,3) = v10L + [Rw*cosd(ang) 0 Rw*sind(ang)];
    Wheels(i,1:3,4) = v10R + [Rw*cosd(ang) 0 Rw*sind(ang)];
end

%defining the different patches:
%Starting the patch of the Vehicle Body.
clear S;
S.Vertices = [v1L; v2L; v3L; v4L; v5L; v6L; v7L; v8L; v1R; v2R; v3R; v4R; v5R; v6R; v7R; v8R];
S.Faces = [1  2  3  4  5  6  7  8;...
           9 10 11 12 13 14 15 16;...
           1  2 10  9  9  9  9  9;...
           2  3 11 10 10 10 10 10;...
           3  4 12 11 11 11 11 11;...
           4  5 13 12 12 12 12 12;...
           5  6 14 13 13 13 13 13;...
           6  7 15 14 14 14 14 14;...
           7  8 16 15 15 15 15 15;...
           8  1  9 16 16 16 16 16];
S.FaceColor = clr;
S.FaceAlpha = 0.9;
Vehicle.Patches.All = patch(S);

%Creating the wheels patch:
Sw.Vertices = [Wheels(:,:,1); Wheels(:,:,2); Wheels(:,:,3); Wheels(:,:,4)];
points = linspace(1,N,N);  %The linear spacing of the required points
Sw.Faces = [points; points+N; points+2*N; points+3*N];
Sw.FaceColor = 'k';
Sw.FaceAlpha = 0.6;
Vehicle.Patches.Wheels = patch(Sw);

%Saving the vertices information for the body and for the wheels:
Vehicle.Vertices.All = S.Vertices;
Vehicle.Vertices.Wheels = Sw.Vertices;

%Move the vehicle to the desired position with the desired orientation:
Veh_Place(Vehicle, X, Y, a, head)

%Saving the attributes of this Vehicle:
Vehicles{2,veh_num}.L =  L; %The length of the vehicle (longitudinal direction) [in meters]
Vehicles{2,veh_num}.W = W; %The width of the vehicle (lateral direction) [in meters]
Vehicles{2,veh_num}.H = H; %The height of the vehicle (vertical direction) [in meters]
Vehicles{2,veh_num}.Rw = Rw; %The radius of the wheel of the vehicle. [in meters]
Vehicles{2,veh_num}.a = a; %The height of C.G. from the ground.
Vehicles{2,veh_num}.b = b; %The position of C.G. from the front of the vehicle.
Vehicles{2,veh_num}.c = c; %The position of C.G. in the lateral direction from any side of the vehicle.
Vehicles{2,veh_num}.d1 = d1; %The distance of the center of the front wheel from front side.
Vehicles{2,veh_num}.d2 = d2; %The distance of the center of the rear wheel from front side.
Vehicles{2,veh_num}.l2 = l2; %The length of the front hood
Vehicles{2,veh_num}.l3 = l3; %The vertical height of the front wind shield glass
Vehicles{2,veh_num}.l5 = l5; %The vertical height of the rear wind shield glass
Vehicles{2,veh_num}.l6 = l6; %The length of the rear hood. 

%Saving the vehicle:
Vehicles{3,veh_num} = Vehicle;

%Saving the Vehicle's position and orientation:
Vehicles{4,veh_num}.X = X;
Vehicles{4,veh_num}.Y = Y;
Vehicles{4,veh_num}.Z = a;
Vehicles{4,veh_num}.head = head;
Vehicles{4,veh_num}.vel = 0;
Vehicles{4,veh_num}.accel = 0;

%Saving the Data for this vehicle:
samples = round(Time.T/Time.Ts)+1;  %the number of samples to be calculated in the simulation
Vehicles{5,veh_num}.PosX = zeros(1,samples);
Vehicles{5,veh_num}.PosY = zeros(1,samples);
Vehicles{5,veh_num}.Heading = zeros(1,samples);
Vehicles{5,veh_num}.Vel = zeros(1,samples);
Vehicles{5,veh_num}.Ang_Vel = zeros(1,samples);

Vehicles{5,veh_num}.PosX(1,1) = X;
Vehicles{5,veh_num}.PosY(1,1) = Y;
Vehicles{5,veh_num}.Heading(1,1) = head;
Vehicles{5,veh_num}.Vel(1,1) = 0;
Vehicles{5,veh_num}.Ang_Vel(1,1) = 0;
end