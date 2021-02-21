%comparison_LoD
%
%  Copyright (c) 2020 by Ryan D. Fisher.  
%  All rights reserved. 
%
clear;clc;close all;format compact;
%%% Flight Conditions
% Analysis Method: VLM2
% V = 55ft/s
% CG = 10.5x 0.6y
V = 55;
W = 12;
rho = 0.0023;
qinf=0.5*rho*V^2;
%% Current: Taper Ratio = 0.5
filename = "../experimental/T1-55_0 ft_s-VLM2-12_0lb-x10_5in-z0_6inCurrentPlane.csv"
S=15.313;
tbl = readtable(filename);
tbl1 = convertTable(tbl,S,qinf);

%% Current: 15in Tip Chord, Taper Ratio = 0.357
filename = "../experimental/T1-55_0 ft_s-VLM2-12_0lb-x10_5in-z0_6in15TC.csv"
S=14.687;
tbl = readtable(filename);
tbl2 = convertTable(tbl,S,qinf);

%% Flat Back: Current Plane Taper Ratio = 0.5
filename = "../experimental/T1-55_0 ft_s-VLM2-12_0lb-x10_5in-z0_6inCurrentPlaneFlatBack.csv";
S=15.313;
tbl = readtable(filename);
tbl3 = convertTable(tbl,S,qinf);

%% Flat Back: 15in Tip Chord = 0.357
filename = "../experimental/T1-55_0 ft_s-VLM2-12_0lb-x10_5in-z0_6in15TCFlatBack.csv";
S=14.687;
tbl = readtable(filename);
tbl4 = convertTable(tbl,S,qinf);

%%
close all
figure(1);
plot(tbl1.alpha,tbl1.L,'r-','LineWidth',3,'DisplayName','Current');hold on;
plot(tbl2.alpha,tbl2.L,'b-','LineWidth',3,'DisplayName','0.357 Taper');hold on;
plot(tbl3.alpha,tbl3.L,'y-.','LineWidth',3,'DisplayName','Current, Flat Back');hold on;
plot(tbl4.alpha,tbl4.L,'k-.','LineWidth',3,'DisplayName','Flat Back, 0.357 Taper');hold on;
legend();xlabel("\alpha");;ylabel("Lift (lbs)");title('Total Lift in lbs');
%%
figure(2);
plot(tbl1.alpha,tbl1.D,'r-','LineWidth',3,'DisplayName','Current');hold on;
plot(tbl2.alpha,tbl2.D,'b-','LineWidth',3,'DisplayName','0.357 Taper');hold on;
plot(tbl3.alpha,tbl3.D,'y-.','LineWidth',3,'DisplayName','Current, Flat Back');hold on;
plot(tbl4.alpha,tbl4.D,'k-.','LineWidth',3,'DisplayName','Flat Back, 0.357 Taper');hold on;
legend();xlabel("\alpha");ylabel("Drag (lbs)");title('Total Drag in lbs');
%%
figure(3);
plot(tbl1.alpha,tbl1.LD,'r-','LineWidth',3,'DisplayName','Current');hold on;
plot(tbl2.alpha,tbl2.LD,'b-','LineWidth',3,'DisplayName','0.357 Taper');hold on;
plot(tbl3.alpha,tbl3.LD,'y-.','LineWidth',3,'DisplayName','Current, Flat Back');hold on;
plot(tbl4.alpha,tbl4.LD,'k-.','LineWidth',3,'DisplayName','Flat Back, 0.357 Taper')
legend();xlabel("\alpha");ylabel("L/D");title('Lift/Drag');

%%
function [outputTable] = convertTable(tbl,S,qinf)
    Cl=tbl.CL;Cd=tbl.CD;alpha=tbl.alpha;
    L=Cl*S*qinf;D=Cd*S*qinf;
    outputTable.L=L;outputTable.D=D;outputTable.LD=L./D;
    outputTable.alpha=alpha;
end
