%% offshore_tower_model.m
% Main script for defining parameters and calling the calculation functions

% Clear workspace and command window
clear; clc;

%% Define Parameters
% Thrust force (set to numeric value)
Fthrust = 1000;  % Thrust force in Newtons (numeric value)
% Wave loading (input as needed)
Fwave = 500;     % Wave force in Newtons (numeric value)
% Wind loading (input as needed)
Fwind = 600;     % Wind force in Newtons (numeric value; can be modified)

% Height above sea level
H = 80;          % Height above sea level in meters (numeric value)
% Depth below sea level
h = 20;          % Depth below sea level in meters (numeric value)

% Define symbolic variables for other parameters
syms E I m % E: Young's modulus, I: Moment of inertia, m: mass

%% Call the calculation function
[H_a, V_a, M_a] = calculate_reactions(Fthrust, Fwave, Fwind, H, h);

%% Display Results
fprintf('Reaction forces and moments at the seabed (Point A):\n');
fprintf('Horizontal reaction force (H_a): %g N\n', double(H_a));
fprintf('Vertical reaction force (V_a): %g N\n', double(V_a)); 
fprintf('Moment reaction (M_a): %g Nm\n', double(M_a));
