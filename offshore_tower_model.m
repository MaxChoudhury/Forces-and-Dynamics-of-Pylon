%% offshore_tower_model.m
% Main script for defining parameters and calling the calculation functions

% Clear workspace and command window
clear; clc;

%% Define Parameters
% Range of Thrust forces (in kN)
Fthrust_range = 1000:500:3000;  % Thrust force in kN
% Constant Wave force (in kN)
Fwave = 100;        % Wave force in kN
% Constant Wind force (in kN)
Fwind = 80;        % Wind force in kN

% Height above sea level
H = 100;          % Height above sea level in meters
% Depth below sea level
h = 60;          % Depth below sea level in meters

% Define mass at point C
mass_C = 10;  % Mass in tonnes
g = 9.81;     % Acceleration due to gravity in m/s^2
weight_C = mass_C * 1000 * g;  % Convert to Newtons (N)

% Material properties (define as needed)
E = 2.1e11;     % Young's modulus in Pascals (for steel, for example)
I = calculate_tower_properties();       % Moment of inertia in m^4 for the tower cross-section

% Initialize arrays to store results
num_cases = length(Fthrust_range);
H_a_results = zeros(num_cases, 1);
V_a_results = zeros(num_cases, 1);
M_a_results = zeros(num_cases, 1);

%% Loop over the range of thrust forces
for i = 1:num_cases
    Fthrust = Fthrust_range(i);
    
    % Call the calculation function for reactions
    [H_a, V_a, M_a] = calculate_reactions(Fthrust * 1000, Fwave * 1000, Fwind * 1000, weight_C, H, h);  % Convert kN to N
    
    % Store the results
    H_a_results(i) = H_a / 1000;  % Convert to kN
    V_a_results(i) = V_a / 1000;  % Convert to kN
    M_a_results(i) = M_a / 1000;  % Convert to kNm
end

%% Plot the results
figure;
subplot(3, 1, 1);
plot(Fthrust_range, H_a_results, 'r');
title('Horizontal Reaction Force H_a vs Thrust Force');
xlabel('Thrust Force (kN)');
ylabel('H_a (kN)');

subplot(3, 1, 2);
plot(Fthrust_range, V_a_results, 'g');
title('Vertical Reaction Force V_a vs Thrust Force');
xlabel('Thrust Force (kN)');
ylabel('V_a (kN)');

subplot(3, 1, 3);
plot(Fthrust_range, M_a_results, 'b');
title('Moment M_a vs Thrust Force');
xlabel('Thrust Force (kN)');
ylabel('M_a (kNm)');

%% Calculate reactions and displacements for a specific thrust force
specific_Fthrust = 2000;  % Specific thrust force in kN
[H_a_specific, V_a_specific, M_a_specific] = calculate_reactions(specific_Fthrust * 1000, Fwave * 1000, Fwind * 1000, weight_C, H, h);  % Convert kN to N
[x_b, x_c] = calculate_displacements(H, h, specific_Fthrust * 1000, Fwave * 1000, Fwind * 1000, weight_C, E, I);  % Convert kN to N

% Convert results to kN and kNm
H_a_specific = H_a_specific / 1000;  % Convert to kN
V_a_specific = V_a_specific / 1000;  % Convert to kN
M_a_specific = M_a_specific / 1000;  % Convert to kNm

% Display the results
fprintf('For a thrust force of %d kN:\n', specific_Fthrust);
fprintf('Horizontal Reaction Force H_a: %.2f kN\n', H_a_specific);
fprintf('Vertical Reaction Force V_a: %.2f kN\n', V_a_specific);
fprintf('Moment M_a: %.2f kNm\n', M_a_specific);
fprintf('Displacement at sea level (x_b): %.3f m\n', x_b);
fprintf('Displacement at top of the tower (x_c): %.3f m\n', x_c);