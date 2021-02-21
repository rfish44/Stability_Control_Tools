%%%%%%%%% Solve for Damping Ratio and Natural Frequency %%%%%%%%%
%
%  Copyright (c) 2020 by Ryan D. Fisher.  
%  All rights reserved. 
%
clear;clc;close all;format compact;


%%%%%%%%% Phugiod /short period : Longitudinal dynamics 
% Longitudinal: 1&2shortperiod 3longperiod 4phuguide
% Lateral: 1spiral 2roll 3&4dutchroll
%%%%%%%%% Dutch roll/ spiral mode: Lateral dynamics

% Modes 1,2: Damping =  0.516, Nat. Freq = 10.067    Modes 3,4: Damping = 0.154, Nat. Freq = .041
% Lateral - Modes 2,3: Damping = 0.237, Nat. Freq = 5.604 Hz
%%%%%%%%%
m1={};m2={};m3={};

%%% AV3 M3 CG: 11.5 Static margin: 15.24% %%%
i = j; % Set imaginary
% long
eigsLong = [-1.288-0.4841*i, -1.288+0.4841*i, -0.785-2.241*i, -0.785+2.241*i]
% lat
eigsLat=[-3.824+-3.056*i, -3.824+3.056*i, -1.291+0*i, 1.673+0*i]
m1.long=eigsLong; m1.lateral =eigsLat;

%%% AV3 M2 CG: 9.4 Static margin: 21.1% %%%
% long
eigsLong = [-2.475-1.27*i, -2.475+1.27*i, -0.2995-1.288*i, -0.2995+1.288*i]
% lat
eigsLat=[-8.35+0*i, -2.226-0.5371*i, -2.226+0.5371*i, 2.094+0*i]
m2.long=eigsLong; m2.lateral=eigsLat;

%%% AV3 M1 CG: 11.5 Static margin: 15.24% %%%
% long
eigsLong = [-1.24-0.4582*i, -1.24+0.4582*i, -0.8103-2.332*i, -0.8103+2.332*i]
% lat
eigsLat=[-3.581-3.127*i, -3.581+3.127*i, -1.315+0*i, 1.607+0*i]
m3.long=eigsLong; m3.lateral=eigsLat;





%% Make Table
emode=[1 2 3 4 1 2 3 4]
% sigma +- jomega
T=table(); i=0;

mission = m3; % set mission

eigenvalues=[mission.lateral mission.long];
for lambda = eigenvalues
    i=i+1;
    sigma = real(lambda);omega=imag(lambda);
    zeta = -sigma/(sqrt(sigma^2+omega^2)); % Damping ratio
    omega_n = sigma/(-zeta); % Natural frequency
    thalf = 0.69/(abs(zeta)*omega_n); % time to half / double amplitude
    Td = 2*pi/(omega_n*sqrt(1-zeta^2)); 
    Nhalf = thalf/Td; % Number of cycles to half/double amplitude
    tau = 1/(zeta*omega_n); % Time constant
    % Store in vectors for table display
    zetavec(i)=zeta;
    omega_nvec(i)=omega_n;
    thalfvec(i)=thalf;
    Nhalfvec(i)=Nhalf;
    tauvec(i) = tau;
end
% Store vectors in tables
T=table(zetavec',omega_nvec',(zetavec.*omega_nvec)',tauvec',thalfvec',Nhalfvec',emode',eigenvalues');
T.Properties.VariableNames={'Zeta','Omega_N','zeta_x_omega','time_constant','Thalf','Nhalf','Mode','Raw_Eigs'}

%% Plot Eigen Values: Root Locus
eigenvaluesm1=[m1.lateral m1.long];
eigenvaluesm2=[m2.lateral m2.long];
eigenvaluesm3=[m3.lateral m3.long];

figure(1); hold on; grid on;
markerValue=10; % Set marker size
m1p=plot(real(eigenvaluesm1),imag(eigenvaluesm1),'ro','MarkerSize',markerValue,'DisplayName','Misson 1'); % Mission 1
m2p=plot(real(eigenvaluesm2),imag(eigenvaluesm2),'bs','MarkerSize',markerValue,'DisplayName','Mission 2'); % Mission 2
m3p=plot(real(eigenvaluesm3),imag(eigenvaluesm3),'kd','MarkerSize',markerValue,'DisplayName','Mission 3'); % Mission 3
title('Root Locus Plot');
xline(0,'LineWidth',2);yline(0,'LineWidth',1);
axis([-10 3 -4 4])
legend([m1p m2p m3p],'Location','northwest');xlabel('Real Axis');ylabel('Imaginary Axis');

%% Individual Plots
% %% M1
% figure(2); hold on; grid on;
% markerValue=10;
% m11=plot(real(m1.lateral),imag(m1.lateral),'ro','MarkerSize',markerValue,'DisplayName','M1 Lat'); % Mission 1
% m12=plot(real(m1.long),imag(m1.long),'bo','MarkerSize',markerValue,'DisplayName','M1 Long'); % Mission 1
% title('Root Locus Plot: M1');
% xline(0,'LineWidth',2);yline(0,'LineWidth',1);
% legend([m12 m12],'Location','northwest');xlabel('Real Axis');ylabel('Imaginary Axis');
% 
% %% M2
% figure(3); hold on; grid on;
% markerValue=10;
% m21=plot(real(m2.lateral),imag(m2.lateral),'rs','MarkerSize',markerValue,'DisplayName','M2 Lat'); % Mission 2
% m22=plot(real(m2.long),imag(m2.long),'bs','MarkerSize',markerValue,'DisplayName','M2 Long'); % Mission 2
% title('Root Locus Plot: M2');
% xline(0,'LineWidth',2);yline(0,'LineWidth',1);
% legend([m21 m22],'Location','northwest');xlabel('Real Axis');ylabel('Imaginary Axis');
% 
% %% M3
% figure(4); hold on; grid on;
% markerValue=10;
% m31=plot(real(m3.lateral),imag(m3.lateral),'rd','MarkerSize',markerValue,'DisplayName','M3 Lat'); % Mission 2
% m32=plot(real(m3.long),imag(m3.long),'bd','MarkerSize',markerValue,'DisplayName','M3 Long'); % Mission 2
% title('Root Locus Plot: M3');
% xline(0,'LineWidth',2);yline(0,'LineWidth',1);
% legend([m31 m32],'Location','northwest');xlabel('Real Axis');ylabel('Imaginary Axis');
