function EI = calculate_tower_properties()
    % Material and geometric properties for the wind turbine tower
    E = 2.1e11; % Young's modulus for steel in Pascals (N/m^2)
    
    % Tower geometry (assumed values for a medium-sized wind turbine)
    outer_diameter = 5;  % Outer diameter in meters
    inner_diameter = 4.5;  % Inner diameter in meters
    
    % Calculate the moment of inertia (I) for a hollow circular cross-section
    I = (pi / 64) * (outer_diameter^4 - inner_diameter^4);  % Moment of inertia in m^4
    
    % Flexural rigidity (EI)
    EI = E * I;  % Combine E and I to get EI in Nm^2
end
