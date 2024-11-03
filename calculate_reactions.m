function [H_a, V_a, M_a] = calculate_reactions(Fthrust, Fwave, Fwind, weight_C, H, h)
    % Total Length of the Tower
    L = H + h; % Total length of the tower

    % Heights at which forces are applied
    height_fwave = h;                  % Fwave acts at height h (below sea level)
    height_fwind = (H / 2) + h;        % Fwind acts halfway between the top of the pylon and sea level
    height_C = L;                       % Weight of the mass acts at height L (top of the tower)

    % Calculate moment about point A due to applied forces
    M_fwave = Fwave * height_fwave;   % Moment from wave loading
    M_fwind = Fwind * height_fwind;    % Moment from wind loading
    M_weight_C = weight_C * height_C;  % Moment from the weight at point C

    % Total Moment at point A
    M_a = Fthrust * L + M_fwave + M_fwind + M_weight_C; % Total moment at A

    % Horizontal reaction at A
    H_a = Fthrust + Fwave + Fwind;  % Sum of thrust, wave, and wind forces in the x direction

    % Vertical reaction at A (considering weight of mass C)
    V_a = weight_C;   % Vertical reaction is equal to the weight at point C
end
