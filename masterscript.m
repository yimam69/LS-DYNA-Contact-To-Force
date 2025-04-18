clc
%%Master_Script
%%NOTE: ENSURE modified file HAS BEEN DELETED FROM directory BEFORE RUNNING
Inputfilename = 'ncforc';
KFileName = 'Model_2.k';

%For use to create force plot for particular node

PlotFlag = 1; %1 to turn on node plot, 0 to turn off node plot
PlotNode = 2360; % Node to Plot

%%Run force generation script
[Forces, NumNodes, TimeSteps, NumTimeSteps] = Force_Generation(Inputfilename, PlotFlag, PlotNode);

%%Run kfile generator
output = Keyword_Writing(Forces, NumNodes,TimeSteps, NumTimeSteps, KFileName);
