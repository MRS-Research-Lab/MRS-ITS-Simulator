%The initialization function of the time dimension, responsible for
%defining the time of the simulation, sampling time and so on...
function Initialize_Time ()

%Accessing the global variables:
global Time

Time.T = 400;  %The required full simulation time
Time.Ts = 0.01;  %The required sampling time to be used in the computations.
Time.N = 1;  %the number of iterations conducted (1 is initial condition)

Time.Stop_Flag = 0;  %The stop the simulation flag (initialized to zero)
end