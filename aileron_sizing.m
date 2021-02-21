%Aileron Sizing
%  Copyright (c) 2020 by Ryan D. Fisher.  
%  All rights reserved. 
%
%  Equations and code developed from Woolsey.
clear;clc;close all;format compact;

V = 45; % cruise velocity ft/s
b=5; % span in ft
S = 15.31; % Wing area ft^2
Clp = 0.15; % from pg.593 Nicolai
delta_a = -20; %deflection in degrees 
Cl_alpha_w= (0.964856-0.745922)/5 * (180/pi);;
tau=0.4; %pg.7 Aileron Design Chapter 12: Design of Control Surfaces - Mohammad Sadraey

%%
% equation of for chord at later section
% : c = (-23/15)*y + 69
% y1 = 25/12;
y2 = 15/12; %start of outer wing
y3 = 30/12; %tip of wing
%%
syms y
c1 = 42/12;
c2 = ((-21/15)*y + 63/12)
sectionAileron= int(c2*y,y2,y3) % + int(c1*y,y1,y2)
Cl_delta_a = (2*Cl_alpha_w*tau/(S*b))*double(sectionAileron)
% integral(c(y)ydy, y1,y2)

%%
P = -2*(V/b)*(Cl_delta_a/Clp)*deg2rad(delta_a)
Pdeg = -2*(V/b)*(Cl_delta_a/Clp)*delta_a

%% --------- print ---------
display(' ')
display('--------- Results ---------')
display('Using half span notation:') 
fprintf('Start aileron at: %0.1f feet\n',y2)
fprintf('End aileron at: %0.1f feet\n',y3)
fprintf('Cl_alpha_w (1/deg): %0.4f \n',Cl_alpha_w*pi/180)
fprintf('Cl_alpha_w (1/rad): %0.4f \n',Cl_alpha_w)
fprintf('tau: %0.1f feet\n',0.4)
fprintf('tau    |   chord %%\n')
fprintf('0.25   |   10\n')
fprintf('0.4    |   20\n')
fprintf('0.52   |   30\n')
fprintf('0.62   |   40\n')
fprintf('Max aileron deflection in degrees: %0.1f\n',delta_a)
fprintf('Roll Rate in radians/second: %0.1f\n',P)
fprintf('Roll Rate in degrees/second: %0.1f',Pdeg)

