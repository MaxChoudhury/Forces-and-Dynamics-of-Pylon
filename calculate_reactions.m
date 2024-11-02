function [H_a, V_a, M_a] = calculate_reactions(Ft, H, h)
    % Total Length of the Tower
    L = H + h; % Total length of the tower

    % Calculate reactions based on static equilibrium conditions
    H_a = Ft;  % Horizontal reaction at A (H_a = Ft)
    V_a = 0;   % Vertical reaction at A (V_a = 0)
    M_a = Ft * L; % Moment reaction at A (M_a = Ft * L)
end
