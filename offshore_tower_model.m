%% Main Script - offshore_tower_model.m
% Model which calculates and displays the bending of the tower, as well as
% returning key outputs such as reaction forces and displacements

% Clear workspace and command window
%clear; clc;

%% Input Parameters
F_thrust =1640e3;   % Applied force thrust at to the turbine (Kn to N by e3)

m = 2e4;    % Point mass (kg) of the Generator and Blades at the top of the tower
g = 9.81;   % Gravitational Acceleration (m/s^2)
F_mass = m*g;   % Weight of Point Mass 


% Beam properties
H = 119;       % Height above sea level (in meters)
h = 60;       % Height below sea level (in meters)
L = H + h;    % Total Length of tower

[EI, tower_mass] = calculate_tower_properties(L);  % Flexural rigidity EI from calculate_tower_properties

k = 1e8;      % Rotational spring stiffness (N·m/radian)

% Call function to calculate reactions and displacements
[H_a, V_a, M_a, max_deflection_b, max_deflection_c, max_moment] = ...
    calculate_reactions_and_displacements(F_thrust, F_mass, EI, k, H, h, L, tower_mass, g);

%% Display Results in the Command Window
fprintf('\n--- Tower Reaction and Displacement Results ---\n');
fprintf('Horizontal reaction at base (H_a): %.2f kN\n', H_a / 1000);  % Convert N to kN
fprintf('Vertical reaction at base (V_a): %.2f kN\n', V_a / 1000);    % Convert N to kN
fprintf('Moment reaction (M_a): %.2f kNm\n', M_a / 1000);  % Convert Nm to kNm
fprintf('Maximum Moment at Base (Moment in Spring): %.2f kNm\n', max_moment / 1000);  % Convert Nm to kNm
fprintf('Maximum Deflection at Sea Level (Point B): %.4f m\n', max_deflection_b);
fprintf('Maximum Deflection at Tip (Point C): %.4f m\n', max_deflection_c);

fprintf('\n');  % Blank line for readability

%% Plotting Deflection (Height vs Displacement)
% Define y positions along the tower from seabed to tip
y = linspace(0, L, 100);  % From seabed to tip (total height)

% Calculate deflection along the beam (deflection equation)
deflection_y = (F_thrust * y.^3) / (3 * EI) + (F_mass * y.^2) / (2 * EI) + (F_thrust * y) / k;  % Deflection along the beam (in meters)

% Plot the deflection with height on Y-axis and deflection on X-axis
figure;
plot(deflection_y, y, 'b-', 'LineWidth', 2);  % Deflection on X-axis, height on Y-axis
xlabel('Deflection (m)');
ylabel('Height along the tower (m)');
axis equal
title('Deflection along the Tower Height');
grid on;

