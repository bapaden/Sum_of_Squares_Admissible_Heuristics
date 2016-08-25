%This is the startup script to run the SOS heuristic synthesis demos

yalmipath = [pwd '/external/yalmip' ];

% Shared utils
addpath([pwd '/utils'])

% Yalmip
addpath(genpath(yalmipath));

% SDPT3
run('external/SDPT3-4.0/startup.m')
