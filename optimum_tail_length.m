%%%%%%%% Optimal Tail Length %%%%%%%%
%optimum_tail_length
%  Copyright (c) 2020 by Ryan D. Fisher.  
%  All rights reserved. 
%
% This code computes the optimal tail length based on minimized mass. Takes
% into account landing gear weight, tailboom length, and size of horizontal
% and vertical stabilizers.
%
% Please edit the "General" section and alter "lt_array" to change the
% range of lengths considered.
% 
% !!! UNITS !!!
% Units are in lbs, inches, and slugs.

clear;clc;close all;format compact;

%% -------------------------
%%%%%%%%%% General %%%%%%%%%%
% %AV1
% bbar=60;
% cbar=41.62; % inches
% Sw=2415; % inches^2
% xcg = 0.3*cbar;

%AV2
bbar=60; % inches
cbar=38; % inches
cmid=42; % inches
Sw=2203.2; % inches^2
xcg = 0.3*cbar;

% Foam tail


Vh=0.5;
Vv=0.08; %0.05
tailGearHeight=3; %in
ARt=3;
servoWireExtension = 0.0112/16; %lb/in
rhoboom = 0.0103+servoWireExtension; %lb/in % 0.7inch diameter boom
rhotail = 0.002431; %lb/in^2
rhoCarbonFiber=0.5; %lbs/in^3
weightOfGearinBay=1.73/12; %lbs
heightOfGearinBay=8; %inches
lbsPerInchFrontGear=weightOfGearinBay/heightOfGearinBay%0.72; % lbs/in
weightRearGear=3/16; % lbs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute Weights
lt_array=35:5:200;
i=0
for lt=lt_array
    i=i+1;
    Sv(i) = Vv*Sw*bbar/lt;
    Sh(i) = Vh*cbar*Sw/lt;
    bh=sqrt(3*Sh(i));
    ch=bh/ARt;
    langingGearHeight=(lt*tand(4)-2);
    lg(i)=(lt+cbar/4)*sind(4)+3; % length front landing gear
    weightFrontGear(i)=(lg(i))*lbsPerInchFrontGear; 
    totalGearWeight(i)=weightRearGear+weightFrontGear(i); % Assume lt is same distance between gear
    boomWeight=rhoboom*(lt-(2*11.5)); % -11.5 to assume we are attaching at 50% chord
    tailWeight = (Sh(i)+Sv(i))*rhotail; 
    totalWeight(i)=boomWeight + tailWeight + totalGearWeight(i);
    cglocation(i)=boomWeight*(lt)/2 + (Sh(i)+Sv(i))*rhotail*(lt+ch/2);
end

%% Find Minimum Weights (Prints specs. at given tail lengths)
[minWeight,I] = min(totalWeight);
bh=sqrt(ARt*Sh(I));
ch=bh/ARt;
cv=(2/3)*ch;
bv=Sv(I)/cv;
le2le=.25*cbar+lt_array(I)-0.25*ch;

fprintf('---------- Optimized Weight ----------\n')
fprintf('Minimum weight: %0.2f\n',minWeight)
fprintf('Tail Length: %0.2f\n',lt_array(I))
fprintf('Front Landing Gear Height: %0.2f\n',lg(I))
fprintf('Front Landing Gear Weight: %0.2f\n',totalGearWeight(I))
fprintf('--- Horizontal ---\n')
fprintf('Tail Area: %0.2f\n',Sh(I))
fprintf('AR=%0.1f b is: %0.2f\n',ARt,bh)
fprintf('AR=%0.1f c is: %0.2f\n',ARt,ch)
fprintf('--- Vertical ---\n')
fprintf('Tail Area: %0.2f\n',Sv(I))
fprintf('b is: %0.2f\n',bv)
fprintf('c is: %0.2f\n',cv)
fprintf('LE to LE is: %0.2f\n',le2le)
fprintf('TE to LE is: %0.2f\n',le2le-cbar)
fprintf('------------------------------\n\n')

for tailLength = [65 70 90 100 105 110 115]
    ARv=1.3;
    I = find(lt_array==tailLength);
    bh=sqrt(ARt*Sh(I));
    ch=bh/ARt;
%     cv=(2/3)*ch;
%     bv=Sv(I)/cv;
    bv = sqrt(ARv*Sv(I));
    cv = Sv(I)/bv;
    le2le=.25*cmid+lt_array(I)-0.25*ch;

    fprintf('---------- Weight @ %0.0fin ----------\n',lt_array(I))
    fprintf('Weight: %0.2f\n',totalWeight(I))
    fprintf('Tail Length: %0.2f\n',lt_array(I))
    fprintf('Horizontal Weight: %0.2f\n',Sh(I)*rhotail)
    fprintf('Vertical Weight: %0.2f\n',Sv(I)*rhotail)
    fprintf('Front Landing Gear Height: %0.2f\n',lg(I))
    fprintf('Front Landing Gear Weight: %0.2f\n',totalGearWeight(I))
    fprintf('--- Horizontal ---\n')
    fprintf('Tail Area: %0.2f\n',Sh(I))
    fprintf('AR=%0.1f b is: %0.2f\n',ARt,bh)
    fprintf('AR=%0.1f c is: %0.2f\n',ARt,ch)
    fprintf('--- Vertical ---\n')
    fprintf('Tail Area: %0.2f\n',Sv(I))
    fprintf('b is: %0.2f\n',bv)
    fprintf('c is: %0.2f\n',cv)
    fprintf('LE to LE is: %0.2f\n',le2le)
    fprintf('TE to LE is: %0.2f\n',le2le-cmid)
    fprintf('------------------------------\n\n')
end

%% Plots
figure(1)
plot(lt_array,totalWeight,'LineWidth',3,'DisplayName','l_t')
xlabel('Tail Length (in.)');ylabel('Weight (lbs)');
legend()

figure(2)
plot(Sh,totalWeight,'r-','LineWidth',3,'DisplayName','S_H')
xlabel('Tail Area (in.^2)');ylabel('Weight (lbs)');
legend()


% lopt = 1.1*sqrt(4*cbar*Sw*Vh/(pi*.7))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute with Drag
% diameter_gear=2*1; %in
% lt_array=35:5:2000;
% i=0;
% for lt=lt_array
%     i=i+1;
%     SwetBoom=.5*pi*0.7*lt;
% %     SwetGear=.5*pi*diameter_gear*(lt*tand(4)); %
%     SwetGear=2;
%     Sweth=2*cbar*Sw*Vh/lt;
%     Swetv= 2*Vv*Sw*bbar/lt;
%     SwetTotal(i) = SwetGear+Sweth+Swetv+SwetBoom;
%     Sh(i) = Vh*cbar*Sw/lt;
%     %totalGearWeight(i)=weightRearGear+(lt*tand(4))*lbsPerInchFrontGear % Assume lt is same distance between gear
% %     totalWeight(i)=rhoboom*lt + Sh(i)*rhotail %+ totalGearWeight(i)
% end
% 
% [minSwet,I] = min(SwetTotal);
% fprintf('---------- Wetted Area ----------\n')
% fprintf('Minimum Swet: %0.2f\n',minSwet)
% fprintf('Tail Length: %0.2f\n',lt_array(I))
% fprintf('Tail Area: %0.2f\n',Sh(I))
% fprintf('AR=3 b is: %0.2f\n',sqrt(3*Sh(I)))
%%
% figure(3)
% plot(lt_array,SwetTotal,'LineWidth',3,'DisplayName','Swet')
% xlabel('Tail Length (in.)');ylabel('S_{wet} (in^2)');
% legend()
%%
figure(4)
yyaxis left
plot(lt_array,cglocation,'b-','LineWidth',4,'DisplayName','Moment')
xlabel('Tail Length (in)');ylabel('Moment (lbs-in)');
legend()

yyaxis right
plot(lt_array,totalWeight,'r-','LineWidth',4,'DisplayName','Weight')
xlabel('Tail Length (in)');ylabel('Weight (lbs)');
legend()

