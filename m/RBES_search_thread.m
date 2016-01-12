%% RBES_search_thread.m
clear java
% global db_pack_EOS

%% RBES Init
RBES_Init_Params_EOS;% create params structure
[r,params] = RBES_Init_WithRules(params);% Init RBES with params
% save rbes_eos.mat;
% load rbes_eos.mat;
% 
%% Init database and plot
db_pack = get_db_pack('db_pack_EOS.mat');
% db_pack_EOS = java.util.HashMap;

%% Create search thread
ctrl = 'go';% when this variable is set to stop, the thread stops
runnable = ContEval;
t = java.lang.Thread(runnable);
clc;
t.start;

%% to stop the thread, type
% stopthread