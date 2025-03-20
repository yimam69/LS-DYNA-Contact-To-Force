%% Result File Reader
function [Forces, NumNodes,TimeSteps, NumTimeSteps] = Force_Generation(Inputfilename)

%Read data into matrix
RawData = readmatrix(Inputfilename);
%Read data into cell array
%RawDataCell = fileread(Inputfilename):

%Find locations of NaN values
LocationIndex = isnan(RawData);
LocationIndex = LocationIndex(:,1);
IndexLength = length(LocationIndex);

%Create index with locations of each timestep
j = 1;

for (i=1:IndexLength)
    if(LocationIndex(i) == 1 & LocationIndex(i+1) == 1 & LocationIndex(i+2) == 1)
        j = j+1;
        LocationIndex1(j) = i+2;
    end
end

%Read timesteps
NumTimeSteps = length(LocationIndex1);

%Preallocate timestep array
TimeSteps = NaN(NumTimeSteps,1);

text = readlines(Inputfilename);

for (i = 1:NumTimeSteps);

    j = LocationIndex1(i);

    if(i == 1)
        j = 12;
    else
      
        j = j + 12 + 4*(i-1);
    end

    Textfiltered = text(j);
    TextFilterNum = regexprep(Textfiltered,'forces (t=','');
    TextFilterNum = regexprep(TextFilterNum,') for interface         1 surfa  side','');
    TimeSteps(i) = str2num(TextFilterNum);


end

%Determine number of nodes
NumNodes = length(RawData);
NumNodes = ceil(NumNodes/(2*NumTimeSteps))-2;

%Preallocate forces array
Forces = NaN(NumNodes,4,NumTimeSteps);

%%Loop to fill in new array
for(i = 1:NumTimeSteps);
    for(i2 = 1:NumNodes);
    
        j2 = i2*2+(i-1)*3+(i-1)*NumNodes*2;
        
        k2 = j2-1;
        
        %Fill in node number
        Forces(i2,1,i) = RawData(k2,1);

        %Fill in x force
        Forces(i2,2,i) = RawData(j2,1);

        %Fill in y force
        Forces(i2,3,i) = RawData(j2,2);

        %Fill in z force
        Forces(i2,4,i) = RawData(j2,3);
    end
end
%Save forces to output
save('forces.mat',"Forces");