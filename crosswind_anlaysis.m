%%%%%%%% Rudder Sizing %%%%%%%%
% crosswind_analysis
%
%  Copyright (c) 2020 by Ryan D. Fisher.  
%  All rights reserved. 
%

clear;clc;close all;format compact;

%% Constants
crossWindVelmph = [0:0.1:20]; %ft/s 14.67% 
crossWindVel = crossWindVelmph*1.4665;
V = 55; %ft/s
rhoSeaLevel=0.0023; % slugs/ft^3
bw=60; % inches
cw=38; %inches
S = bw*cw/(144); %ft^2
W = 14.6; %lbs

beta = asin(crossWindVel/V); 



%% Large Rudder (20 x 15)
Yv=     -1.4307;         CYb=     -0.2199;
Yp=      1.0068;         CYp=     0.20314;
Yr=      3.8155;         CYr=     0.76987;
Lv=      2.6672;         Clb=     0.26908;
Lp=     -5.1247;         Clp=    -0.67871;
Lr=     -1.0215;         Clr=    -0.13529;
Nv=       2.372;         Cnb=      0.2393;
Np=     -5.8811;         Cnp=    -0.77888;
Nr=     -3.6165;         Cnr=    -0.47896;

CYdeltaa = 0.97331;%
CYdeltar = 0.080032;%

Cldeltaa = 0.0084859;%
Cldeltar = -0.11127;%

Cndeltaa = 0.0012304;%
Cndeltar = -0.10577;%

CW = W/(.5*rhoSeaLevel*V^2*S)

A = [CYdeltaa CYdeltar CW;
    Cldeltaa Cldeltar 0;
    Cndeltaa Cndeltar 0;]
B = [CYb;
    Clb;
    Cnb;];
x = A\(-B*beta)
xdeg=rad2deg(x)


fprintf('Aileron deflection (deg): %0.2f\n',xdeg(1))
fprintf('Rudder deflection (deg): %0.2f\n',xdeg(2))
fprintf('Roll Angle (deg): %0.2f\n',xdeg(3))

figure(1);hold on;
title('Large Rudder Size for Crosswind (20in x 15in)');
plotList(1)=plot(crossWindVelmph, xdeg(1,:), 'r-','LineWidth',3, 'DisplayName','Aileron')
plotList(2)=plot(crossWindVelmph, xdeg(2,:), 'b-','LineWidth',3,'DisplayName','Rudder')
plotList(3)=plot(crossWindVelmph, xdeg(3,:), 'k-','LineWidth',3, 'DisplayName','\phi')
yline(30,'LineWidth',2);
yline(-30,'LineWidth',2);
xline(15,'LineWidth',2);
xlabel('Crosswind (mph)');ylabel('Degrees (°)');legend(plotList);
axis([0 20 -90 90])
grid on

%% Small Rudder (12.5 x 9.5)
Yv=    -0.66628;         CYb=    -0.10241;
Yp=    -0.38772;         CYp=   -0.078232;
Yr=      2.5561;         CYr=     0.51576;
Lv=      1.1523;         Clb=     0.11625;
Lp=     -2.3373;         Clp=    -0.30954;
Lr=      1.4768;         Clr=     0.19558;
Nv=      0.8723;         Cnb=    0.088003;
Np=     -3.1375;         Cnp=    -0.41552;
Nr=     -1.1394;         Cnr=     -0.1509;

CYdeltaa = 0.97414;%
CYdeltar = 0.029175;%

Cldeltaa = 0.0074119;%
Cldeltar = -0.043167;%

Cndeltaa = -0.00047648;%
Cndeltar = -0.037085;%

CW = W/(.5*rhoSeaLevel*V^2*S)

A = [CYdeltaa CYdeltar CW;
    Cldeltaa Cldeltar 0;
    Cndeltaa Cndeltar 0;]
B = [CYb;
    Clb;
    Cnb;];
x = A\(-B*beta)
xdeg=rad2deg(x)


fprintf('Aileron deflection (deg): %0.2f\n',xdeg(1))
fprintf('Rudder deflection (deg): %0.2f\n',xdeg(2))
fprintf('Roll Angle (deg): %0.2f\n',xdeg(3))

figure(2);hold on;
title('Optimized Rudder Size for Weight');%(12.5in x 9.5in)
plotList(1)=plot(crossWindVelmph, xdeg(1,:), 'r-','LineWidth',3, 'DisplayName','Aileron')
plotList(2)=plot(crossWindVelmph, xdeg(2,:), 'b-','LineWidth',3,'DisplayName','Rudder')
plotList(3)=plot(crossWindVelmph, xdeg(3,:), 'k-','LineWidth',3, 'DisplayName','\phi')
yline(30,'LineWidth',2);
yline(-30,'LineWidth',2);
xline(15,'LineWidth',2);
xlabel('Crosswind (mph)');ylabel('Degrees (°)');legend(plotList);
axis([0 20 -90 90])
grid on

%% Larger rudder 45% (12.5 x 9.5)
Yv=    -0.67818;         CYb=    -0.10254;
Yp=    -0.30721;         CYp=   -0.060979;
Yr=      2.6556;         CYr=     0.52712;
Lv=      1.2089;         Clb=     0.11998;
Lp=     -2.4811;         Clp=    -0.32324;
Lr=       1.572;         Clr=      0.2048;
Nv=      0.8745;         Cnb=     0.08679;
Np=     -3.2193;         Cnp=    -0.41942;
Nr=     -1.0558;         Cnr=    -0.13755;

CYdeltaa = 1.0061;%
CYdeltar = 0.031553;%

Cldeltaa = 0.0058257;%
Cldeltar = -0.04881;%

Cndeltaa = -0.00013652;%
Cndeltar = -0.038318;%

CW = W/(.5*rhoSeaLevel*V^2*S)

A = [CYdeltaa CYdeltar CW;
    Cldeltaa Cldeltar 0;
    Cndeltaa Cndeltar 0;]
B = [CYb;
    Clb;
    Cnb;];
x = A\(-B*beta)
xdeg=rad2deg(x)


fprintf('Aileron deflection (deg): %0.2f\n',xdeg(1))
fprintf('Rudder deflection (deg): %0.2f\n',xdeg(2))
fprintf('Roll Angle (deg): %0.2f\n',xdeg(3))

figure(3);hold on;
title('Optimized Rudder (45%) Size for Weight (12.5in x 9.5in)');
plotList(1)=plot(crossWindVelmph, xdeg(1,:), 'r-','LineWidth',3, 'DisplayName','Aileron')
plotList(2)=plot(crossWindVelmph, xdeg(2,:), 'b-','LineWidth',3,'DisplayName','Rudder')
plotList(3)=plot(crossWindVelmph, xdeg(3,:), 'k-','LineWidth',3, 'DisplayName','\phi')
yline(30,'LineWidth',2);
yline(-30,'LineWidth',2);
xline(15,'LineWidth',2);
xlabel('Crosswind (mph)');ylabel('Degrees (°)');legend(plotList);
axis([0 20 -90 90])
grid on


