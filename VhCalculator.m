function [Vh] = VhCalculator(Sw,cw,Sh,lt)
%
%  Copyright (c) 2020 by Ryan D. Fisher.  
%  All rights reserved. 
%
%VhCalulator Calculates the horizontal tail volume ratio.
%   Inputs: Wing area (Sw), wing chord (cw), horizontal area (Sh), length
%   to tail measured c_w/4 to c_h/4 (lt).
Vh = Sh*lt/(Sw*cw)
end

