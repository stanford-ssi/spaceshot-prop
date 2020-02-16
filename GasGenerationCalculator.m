clc, clear, close all

% This function intakes various performance characteristics and finds the
% pressure change created by a pyrotecnic gas generation device. 
% Thomas White 2/16/2020

% Assumptions: assumes a static pressure vessel (e.g. for a rocket, assumes
% no gas exits the nozzle. 

%% Starting Settings 

% Pyrogen Details
lambda = 298968; % Nm/kg (Specific force constant)
m = 0.0013; % kg (initial charge mass)
V = 0.0000; % m^3 (charge volume at time T)
V_0 = 0.000000125; % m^3 (chage volume at start)
Z =  1 - V/V_0; % (burned mass fraction)
roh = 12524; %kg/m^3 (density of charge)
eta = 0.00108; % (propellant co-volume)

% Chamber Details
gamma = 1.4; % Specific heat ratio of combusted gasses)
V_c = 0.0098; % m^3 (chamber volume at t=0) 

%% The equation

Pc = (lambda*m*Z)/(V_c - m*((1/roh) - Z*(eta - (1/roh))))

Pc_psi = Pc/6894.75729