%%Master_Script
%%NOTE: ENSURE modified file HAS BEEN DELETED FROM directory BEFORE RUNNING
Inputfilename = 'Contact_Force';
KFileName = 'Model_2_Short.k';


%Run force generation script
[Forces, NumNodes, TimeSteps, NumTimeSteps] = Force_Generation(Inputfilename);

%Run kfile generator
output = Keyword_Writing(Forces, NumNodes,TimeSteps, NumTimeSteps, KFileName);
