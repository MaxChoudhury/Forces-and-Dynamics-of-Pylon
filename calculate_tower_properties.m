function I = calculate_tower_properties()
    % Function to calculate the moment of inertia (I) for a wind turbine tower
    % Using a hollow cylindrical cross-section
    
    % Define the dimensions of the tower (in meters)
    d_o = 5.0; % Outer diameter 
    d_i = 4.0; % Inner diameter 
    
    % Calculate the moment of inertia I for a hollow circular cross-section
    I = (pi / 64) * (d_o^4 - d_i^4);
end