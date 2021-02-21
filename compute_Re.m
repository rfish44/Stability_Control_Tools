function [Re] = compute_Re(V,c)
%
%  Copyright (c) 2020 by Ryan D. Fisher.  
%  All rights reserved. 
%
%[Re] = compute_Re(V,c) This function computes Re at standard atmosphere.
%   Inputs:
%   V = velocity in ft/s
%   c = characteristic chord in ft
%
%   Outputs:
%   Reynolds number

mu = 3.737*10^(-7);  % lbs-s/(ft^2)
rho =  0.00237; % slug/ft^3

Re = rho*V*c/mu; % Reynolds number
end

