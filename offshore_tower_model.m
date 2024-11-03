%% offshore_tower_model.m
% Main script for defining parameters and calling the calculation functions

% Clear workspace and command window
clear; clc;

%% Define Parameters
% Thrust force (set to numeric value)
Fthrust = 1000;  % Thrust force in kN (numeric value)
% Wave loading (input as needed)
Fwave = 100;     % Wave force in kN (numeric value)
% Wind loading (input as needed)
Fwind = 80;     % Wind force in kN (numeric value; can be modified)

% Height above sea level
H = 80;          % Height above sea level in meters (numeric value)
% Depth below sea level
h = 20;          % Depth below sea level in meters (numeric value)

% Define mass at point C
mass_C = 10;  % Mass in tonnes
g = 9.81;     % Acceleration due to gravity in m/s^2
weight_C = mass_C * 1000 * g;  % Convert to Newtons (N)

% Material properties (define as needed)
E = 2.1e11;     % Young's modulus in Pascals (for steel, for example)
I = calculate_tower_properties();       % Moment of inertia in m^4 for the tower cross-section

%% Call the calculation function for reactions
[H_a, V_a, M_a] = calculate_reactions(Fthrust * 1000, Fwave * 1000, Fwind * 1000, weight_C, H, h);  % Convert kN to N

%% Call the displacement calculation function
[x_b, x_c] = calculate_displacements(H, h, Fthrust * 1000, Fwave * 1000, Fwind * 1000, weight_C, E, I);  % Convert kN to N

%% Display Results
fprintf('Reaction forces and moments at the seabed (Point A):\n');
fprintf('Horizontal reaction force (H_a): %g kN\n', H_a / 1000);  % Convert N to kN for display
fprintf('Vertical reaction force (V_a): %g kN\n', V_a / 1000);  % Convert N to kN for display
fprintf('Moment reaction (M_a): %g kNm\n', M_a / 1000);  % Convert Nm to kNm for display

fprintf('Displacement at sea level (Point B): %g m\n', x_b);
fprintf('Displacement at the top of the pylon (Point C): %g m\n', x_c);

