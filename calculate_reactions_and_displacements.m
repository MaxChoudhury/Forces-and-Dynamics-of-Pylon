function [H_a, V_a, M_a, max_deflection_b, max_deflection_c, max_moment] = calculate_reactions_and_displacements(F, EI, k, H, h)
    % Calculates reaction forces, deflections, and maximum bending moment for the tower
    % with a pin joint and spring at the base.
    
    % Define total length of the tower
    L = H + h;  % Total length of the beam (above and below sea level)

    % Reaction Forces at the Base (Pin Joint with Rotational Spring)
    H_a = -F;           % Horizontal reaction force at the base (equal to applied force at tip)
    V_a = 0;            % Vertical reaction force (assumed zero in this 2D horizontal loading model)
    
    % Moment at the base (resisted entirely by the spring)
    M_a = F * L;
    M_spring = M_a;     % Moment resisted by the spring

    % Calculate the maximum bending moment along the beam
    y = linspace(0, L, 100);  % Positions along the beam from base (A) to tip (C)
    M_y = F * (L - y);        % Moment at each point along the beam
    max_moment = max(abs(M_y)); % Maximum bending moment along the beam

    % Calculate deflection at sea level (Point B) and at the tip (Point C)
    deflection_b_cantilever = (F * h^3) / (3 * EI);  % Cantilever deflection at Point B
    deflection_b_spring = (F * h) / k;               % Spring deflection at Point B
    max_deflection_b = deflection_b_cantilever + deflection_b_spring;  % Total deflection at Point B

    deflection_c_cantilever = (F * L^3) / (3 * EI);  % Cantilever deflection at Point C
    deflection_c_spring = (F * L) / k;               % Spring deflection at Point C
    max_deflection_c = deflection_c_cantilever + deflection_c_spring;  % Total deflection at Point C
end


