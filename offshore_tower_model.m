%% Main Script - offshore_tower_model.m
% Model which calculates and displays the bending of the tower, as well as
% returning key outputs such as reaction forces and displacements.

% Clear workspace and command window
clear; clc;

%% Input Parameters
F = 2000e3;   % Applied force at the top of the tower (Kn to N by e3)

% Beam properties
EI = calculate_tower_properties();  % Flexural rigidity EI from calculate_tower_properties

k = 1e8;      % Rotational spring stiffness (N·m/radian)
H = 80;       % Height above sea level (in meters)
h = 60;       % Height below sea level (in meters)

% Call function to calculate reactions and displacements
[H_a, V_a, M_a, max_deflection_b, max_deflection_c, max_moment] = ...
    calculate_reactions_and_displacements(F, EI, k, H, h);

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
y = linspace(0, H + h, 100);  % From seabed to tip (total height)

% Calculate deflection along the beam (deflection equation)
deflection_y = (F * y.^3) / (3 * EI) + (F * y) / k;  % Deflection along the beam (in meters)

% Plot the deflection with height on Y-axis and deflection on X-axis
figure;
plot(deflection_y, y, 'b-', 'LineWidth', 2);  % Deflection on X-axis, height on Y-axis
xlabel('Deflection (m)');
ylabel('Height along the tower (m)');
title('Deflection along the Tower Height');
grid on;

