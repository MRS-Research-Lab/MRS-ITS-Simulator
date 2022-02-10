%The declaring function for the parameters of the 
function Veh_params()

%accessing the global variables required in the simulation:
global Parameters

%Parameters of the vehicle: define all the parameters below:
%The main dimensions of the vehicle:
Parameters.L = 2.8; %The length of the vehicle (longitudinal direction) [in meters]
Parameters.W = 1.4; %The width of the vehicle (lateral direction) [in meters]
Parameters.H = 1.2; %The height of the vehicle (vertical direction) [in meters]
Parameters.Rw = 0.2; %The radius of the wheel of the vehicle. [in meters]
Parameters.a = 0.6; %The height of C.G. from the ground.
Parameters.b = 1.8; %The position of C.G. from the front of the vehicle.
Parameters.c = Parameters.W/2; %The position of C.G. in the lateral direction from any side of the vehicle.
Parameters.d1 = 0.7; %The distance of the center of the front wheel from front side.
Parameters.d2 = 2.4; %The distance of the center of the rear wheel from front side.
Parameters.l2 = 0.8; %The length of the front hood
Parameters.l3 = 0.6; %The vertical height of the front wind shield glass
Parameters.l5 = 0.5; %The vertical height of the rear wind shield glass
Parameters.l6 = 0.6; %The length of the rear hood.

end