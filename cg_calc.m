function [totalMass, xcg] = cg_calc(weight,pos)
%
%  Copyright (c) 2020 by Ryan D. Fisher.  
%  All rights reserved. 
%
%cg_calc Finds the CG for a given weight vector with a corresponding
%position vector. 
%   Finds the CG postion for a given weight vector of length i, with a
%   corresponding position vector (relating each mass to its position) of
%   length i. 
% 
%   Output: totalMass, xcg (location of CG)
    armTotal=0;
    for i = 1:length(weight);
        arm = weight(i)*pos(i);
        armTotal = arm+armTotal;
    end
    totalMass = sum(weight);
    xcg = armTotal/totalMass;
end

