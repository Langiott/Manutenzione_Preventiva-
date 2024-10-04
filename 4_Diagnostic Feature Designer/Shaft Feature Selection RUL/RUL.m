%% Pulizia desktop e workspace
close all;
clear all;
clc;

%% Caricamento dati
load(fullfile(matlabroot, 'toolbox', 'predmaint', 'predmaintdemos', ... 
'motorDrivetrainDiagnosis', 'machineDataRUL3'), 'motor_rul3')
diagnosticFeatureDesigner