function [x_b, x_c] = calculate_displacements(H, h, Fthrust, Fwave, Fwind, weight_C, E, I)
    % Calculate the horizontal displacements at sea level (Point B) and at the top of the tower (Point C)
    
    % Total force acting on the beam in the positive y direction
    F_total = Fthrust + Fwave + Fwind + weight_C;  % Include weight_C in total force
    
    % Length of the tower
    L = H + h;  % Total height of the tower
    
    % Calculate displacement at Point B (x_b) using the bending beam equation
    % Displacement at Point B is at height y_b = h
    x_b = (F_total * h^2) / (2 * E * I);  % Horizontal displacement at sea level (B)

    % Calculate displacement at Point C (x_c) using the bending beam equation
    % Displacement at Point C is at height y_c = L
    x_c = (F_total * L^2) / (2 * E * I);  % Horizontal displacement at the top of the tower (C)
    
end
