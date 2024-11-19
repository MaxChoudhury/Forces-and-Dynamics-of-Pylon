%% offshore_tower_model.m
% Main script for defining parameters and calling the calculation functions

% Clear workspace and command window
clear; clc;

%% Input Parameters
F_thrust = 1640e3;   % Applied force thrust at to the turbine (kN to N by e3)

g = 9.81; %Acceleration due to gravity (m/s^2)

% Beam properties
H = 119;       % Height above sea level (in meters)
h = 60;       % Height below sea level (in meters)
L = H + h;    % Total Length of tower

[EI, tower_mass] = calculate_tower_properties(L);  % Flexural rigidity EI from calculate_tower_properties

k = 1e10;      % Rotational spring stiffness (N·m/radian)

% Call function to calculate reactions and displacements
[H_a, V_a, M_a, initial_displacement, deflection_y, M_y] = ...
    calculate_reactions_and_displacements(F_thrust, tower_mass, EI, k, H, h, L, g);

%% Display Results in the Command Window
fprintf('\n--- Tower Reaction and Displacement Results ---\n');
fprintf('Horizontal reaction at base (H_a): %.2f kN\n', H_a / 1000);  % Convert N to kN
fprintf('Vertical reaction at base (V_a): %.2f kN\n', V_a / 1000);  % Convert N to kN
fprintf('Moment reaction (M_a): %.2f kNm\n', M_a / 1000);  % Convert Nm to kNm
fprintf('Initial Displacement at Tip (without mass): %.4f m\n', initial_displacement);

fprintf('\n');  % Blank line for readability

%% Plotting Deflection (Height vs Displacement) and Bending Moment Diagram
% Define y positions along the tower from seabed to tip
y = linspace(0, L, 100);  % From seabed to tip (total height)

% Create a figure with two subplots
figure;
close all;

% Plot the deflection with height on Y-axis and deflection on X-axis
subplot(1, 2, 2);
plot(deflection_y, y, 'b-', 'LineWidth', 2);  % Deflection on X-axis, height on Y-axis
xlabel('Deflection (m)');
ylabel('Height along the tower (m)');
axis equal
title('Deflection along the Tower Height');
grid on;

% Plot the bending moment diagram with height on Y-axis and moment on X-axis
subplot(1, 2, 1);
plot(M_y, y, 'r-', 'LineWidth', 2);  % Moment on X-axis, height on Y-axis
xlabel('Bending Moment (Nm)');
ylabel('Height along the tower (m)');
title('Bending Moment Diagram');
grid on;