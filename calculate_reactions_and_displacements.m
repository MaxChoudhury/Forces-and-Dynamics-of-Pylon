function [H_a, V_a, M_a, deflection_c, deflection_b, deflection_y, M_y] = calculate_reactions_and_displacements(F_thrust, tower_mass, EI, k, H, h, L, g)
    % Calculates reaction forces, initial displacement, and bending moment for the tower
    % with a pin joint and spring at the base

    %% Reaction Forces at the Base (Pin Joint with Rotational Spring)
    H_a = -F_thrust;  % Horizontal reaction force at the base (equal to applied force at tip)
    V_a = tower_mass * g;  % Vertical reaction force (no vertical load considered for initial state)

    %% Initial Moment at the base (resisted entirely by the spring)
    M_a = F_thrust * L;  % Initial moment due to thrust force

    %% Calculate initial displacement without considering the mass
    %initial_displacement = ((F_thrust * (L^3)) / (3 * EI)) + ((F_thrust * L^2) / k);

    %% Calculate the bending moment along the beam for the initial state
    y = linspace(0, L, L+1);  % Positions along the beam from base (A) to tip (C)
    M_y = F_thrust * (L-y);  % Moment at each point along the beam

    %% Calculate deflection in segments along the beam to plot deflection profile
    Deflection_by_thrust = ((F_thrust * (y.^3)) / (3 * EI)); % Deflection due to thrust force (in meters)
    Deflection_by_spring = ((F_thrust * y.^2) / k);  % Deflection due to spring (in meters)

    deflection_y = Deflection_by_thrust + Deflection_by_spring;  % Deflection along the beam (in meters)

    %% Calculate key displacments to return in the output
    deflection_c = deflection_y(end);  % Displacement at the tip (end of the beam point C)
    deflection_b = deflection_y(h+1);    % Displacement at sea level (point B)


end