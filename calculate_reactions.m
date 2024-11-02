function [H_a, V_a, M_a] = calculate_reactions(Fthrust, Fwave, Fwind, H, h)
    % Total Length of the Tower
    L = H + h; % Total length of the tower

    % Heights at which forces are applied
    height_fwave = h;                  % Fwave acts at height h (below sea level)
    height_fwind = (H / 2) + h;        % Fwind acts halfway between the top of the pylon and sea level

    % Calculate moment about point A due to applied forces
    M_fwave = Fwave * height_fwave;   % Moment from wave loading
    M_fwind = Fwind * height_fwind;    % Moment from wind loading

    % Total Moment at point A
    M_a = Fthrust * L + M_fwave + M_fwind; % Total moment at A

    % Horizontal reaction at A
    H_a = Fthrust + Fwave + Fwind;  % Sum of thrust, wave, and wind forces in the x direction

    % Vertical reaction at A (still assumed to be zero)
    V_a = 0;   
end
