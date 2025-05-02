%% 
clc
%%Master_Script
%%NOTE: ENSURE modified file HAS BEEN DELETED FROM directory BEFORE RUNNING
Inputfilename = 'ncforc';
KFileName = 'Model_2.k';

%For use to create force plot for particular node
PlotFlag = 0; %1 to turn on node plot, 0 to turn off node plot
PlotNode = 2360; % Node to Plot

%Inputs for force generation script
InputPasses = 1; %Number of simulation passes in input kfile
DesiredPasses = 10; %Number of desired simulation passes

tic
%%Run force generation script
[Forces, NumNodes, TimeSteps, NumTimeSteps] = Force_Generation(Inputfilename, PlotFlag, PlotNode);
ForceGenerationTime = toc


%% 
tic
%%Run Force generation modification script
if InputPasses ~= DesiredPasses
    [Forces_Modified, TimeSteps_Modified, NumTimeSteps_Modified] = Force_Modification(Forces, InputPasses, DesiredPasses, TimeSteps, NumTimeSteps, NumNodes);
else
    Forces_Modified = Forces;
    TimeSteps_Modified = Timesteps;
    NumTimeSteps_Modified = NumTimeSteps;
end
ForceModificationTime = toc


%% 

%%Run kfile generator
output = Keyword_Writing(Forces_Modified, TimeSteps_Modified, NumTimeSteps_Modified, NumNodes, KFileName);
