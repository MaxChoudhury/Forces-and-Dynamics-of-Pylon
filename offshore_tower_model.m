%% Cantilever Model with Rotational Spring Support and Variable Force
% Clear workspace and command window
clear; clc;

%% Define Parameters
% Applied lateral force at the tip as an array
F_array = linspace(0, 200e3, 100);  % Force values from 0 to 200 kN (in Newtons)

% Beam properties
EI = 4e10;  % Flexural rigidity in Nm^2
L = 100;    % Length of the cantilever in meters

% Rotational spring stiffness at the base
k = 1e8;    % Rotational spring stiffness in Nm/radian

% Positioning along the beam for bending moment calculation
y = linspace(0, L, 100); % Discretize the beam along its length

% Initialize arrays to store results
delta_tip_array = zeros(size(F_array));  % Array for storing tip deflections
M_y_matrix = zeros(length(F_array), length(y));  % Matrix for storing bending moments at each y for each F

%% Loop over Force Array to Calculate Deflection and Moments
for i = 1:length(F_array)
    F = F_array(i);  % Current force value
    
    % Tip Deflection Calculation
    delta_tip_cantilever = (F * L^3) / (3 * EI);  % Deflection due to bending
    delta_tip_spring = (F * L) / k;               % Deflection due to spring
    delta_tip_array(i) = delta_tip_cantilever + delta_tip_spring;  % Total tip deflection
    
    % Bending Moment along the Beam for the current F
    M_y_matrix(i, :) = F * (L - y);  % Bending moment at distance y from the base for current F
end

%% Reaction Forces and Moment at the Base (for the last value of F in F_array)
% Horizontal reaction at the pin support (equal to last applied force in F_array)
H_a = F_array(end);  % Horizontal reaction force at base (N)
% Moment reaction due to rotational spring for the last force value
M_a = F_array(end) * L;  % Moment reaction at base (Nm)

%% Display Results for the Last Force Value
fprintf('For the last force value in F_array:\n');
fprintf('Horizontal reaction force (H_a): %g N\n', H_a);
fprintf('Moment reaction (M_a): %g Nm\n\n', M_a);

%% Plotting Results in a Tiled Layout
figure;
tiledlayout(2, 1);  % Two rows, one column

% Plot 1: Tip Deflection vs Force
nexttile;
plot(F_array / 1000, delta_tip_array, 'b-', 'LineWidth', 2);  % Convert F to kN for plot
xlabel('Applied Force F (kN)');
ylabel('Tip Deflection (m)');
title('Tip Deflection vs. Applied Force');
grid on;

% Plot 2: Bending Moment Distribution for Selected Force Values
nexttile;
plot(y, M_y_matrix(round(linspace(1, length(F_array), 5)), :));  % Plot moments for 5 sample forces
xlabel('Distance from Base (m)');
ylabel('Bending Moment (Nm)');
title('Bending Moment Distribution along the Beam for Varying Forces');
legend(arrayfun(@(F) sprintf('F = %g kN', F/1000), F_array(round(linspace(1, length(F_array), 5))), 'UniformOutput', false));
grid on;

