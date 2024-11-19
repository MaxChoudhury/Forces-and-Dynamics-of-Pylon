function [H_a, V_a, M_a, max_deflection_b, max_deflection_c, max_moment] = calculate_reactions_and_displacements(F_thrust, F_mass, EI, k, H, h, L, tower_mass, g)
    % Calculates reaction forces, deflections, and maximum bending moment for the tower
    % with a pin joint and spring at the base

    %% Reaction Forces at the Base (Pin Joint with Rotational Spring)
    H_a = -F_thrust;  % Horizontal reaction force at the base (equal to applied force at tip)
    V_a = F_mass + (tower_mass * g);  % Vertical reaction force (Equal to weight of point mass plus weight of tower)

    %% Initial Moment at the base (resisted entirely by the spring)
    M_a = F_thrust * L;  % Initial moment due to thrust force
    M_spring = M_a;  % Moment resisted by the spring

    %% Iteratively solve for the new moment and displacement
    tolerance = 1e-6;  % Convergence tolerance
    max_iterations = 100;  % Maximum number of iterations
    displacement_tip = 0;  % Initial displacement at the tip
    for iter = 1:max_iterations
        % Calculate the moment due to the point mass acting at the displaced position
        moment_due_to_mass = F_mass * displacement_tip;

        % Total moment at the base
        M_a_new = F_thrust * L + moment_due_to_mass;

        % Calculate the new displacement at the tip
        displacement_tip_new = (M_a_new * L) / (3 * EI) + (M_a_new) / k;

        % Check for convergence
        if abs(displacement_tip_new - displacement_tip) < tolerance
            displacement_tip = displacement_tip_new;
            M_a = M_a_new;
            break;
        end

        % Update displacement for the next iteration
        displacement_tip = displacement_tip_new;
    end

    %% Calculate the maximum bending moment along the beam
    y = linspace(0, L, 100);  % Positions along the beam from base (A) to tip (C)
    M_y = F_thrust * (L - y) + F_mass * displacement_tip;  % Moment at each point along the beam
    max_moment = max(abs(M_y));  % Maximum bending moment along the beam

    %% Calculate deflection at sea level (Point B) and at the tip (Point C)
    max_deflection_b = (F_thrust * h^2) / (2 * EI) + (F_thrust * h) / k;  % Deflection at sea level (B)
    max_deflection_c = displacement_tip;  % Deflection at the tip (C)
end