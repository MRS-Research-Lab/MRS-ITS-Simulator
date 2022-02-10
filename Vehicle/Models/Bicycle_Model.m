%function to calculate the updated states based on the type of the model
%used and the inputs to the model.
function States_Updated = Bicycle_Model(States, input)
%The basic model of the kinematic bicycle model,
%states: position X, position Y, Theta and Steering Angle
%inputs: -velocity and steering angle rate

%accessing the global variables:
global Time

%aceessing the states:
X = States(1);  %position in X direction
Y = States(2);    %position in Y direction
theta = States(3);  %the current heading of the vehicle
Steer_Angle = States(4);  %the current value of steered wheel angle

%accessing the inputs:
vel = input(1);  %the linear velocity of the vehicle.
steer_ang_rate = input(2);   %the rate of change of the steering angle

%calculating the updated states:
X = X + vel*cosd(theta)*Time.Ts;
Y = Y + vel*sind(theta)*Time.Ts;
theta = theta + ang_vel*Time.Ts;

%saving the updated states based on the inputs:
States_Updated = [X, Y, theta];
end