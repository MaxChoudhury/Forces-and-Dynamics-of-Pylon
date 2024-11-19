function [EI, tower_mass] = calculate_tower_properties(L)
    %% Material and geometric properties for the wind turbine tower
    E = 2.1e11; % Young's modulus for steel in Pascals (N/m^2)
    rho = 7750; % Density of steel used (kg/m^3)
    tower_thickness = 80e-3; %rough thickness of offshore tower modelled as being uniform (m)
    
    %% Tower geometry (assumed values for a medium-sized wind turbine)
    outer_diameter = 8;  % Outer diameter in meters
    inner_diameter = outer_diameter - (tower_thickness*2);  % Inner diameter in meters
    
    %% Calculate the moment of inertia (I) for a hollow circular cross-section
    I = (pi / 64) * (outer_diameter^4 - inner_diameter^4);  % Moment of inertia in m^4
    
    %% Flexural rigidity (EI)
    EI = E * I;  % Combine E and I to get EI in Nm^2

    %% Calculate Mass of Tower
    tower_area = pi * outer_diameter * tower_thickness; % Using thin walled theory
    tower_volume = L * tower_area; % Modelling tower as uniform cylinder 
    tower_mass = tower_volume * rho; % mass (kg) = volume (m^3) x density (kg/m^3)

end
