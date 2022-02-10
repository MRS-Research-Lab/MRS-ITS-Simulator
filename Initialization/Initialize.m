%The main initialization function of the simulator:
function Initialize()

evalin('base','global Vehicles Parameters Time');  %Initialize the global variables required

%Call the different initialization functions:
Initialize_Time () %Initialize the time variable to be used throughout the simulation.

%we need to declare function to initialize map, vehicles, pedistrians:
Veh_params();
Initialize_Map();
Initialize_Veh();

end