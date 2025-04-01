%%Master_Script
%%NOTE: ENSURE modified file HAS BEEN DELETED FROM directory BEFORE RUNNING
Inputfilename = 'ncforc';
KFileName = 'Model_2.k';


%Run force generation script
[Forces, NumNodes, TimeSteps, NumTimeSteps] = Force_Generation(Inputfilename);

%Run kfile generator
output = Keyword_Writing(Forces, NumNodes,TimeSteps, NumTimeSteps, KFileName);
