%% Result File Reader
function [Forces, NumNodes,TimeSteps, NumTimeSteps] = Force_Generation(Inputfilename, PlotFlag, PlotNode)

%Read data into matrix
text = readlines(Inputfilename);
%Read data into cell array
%RawDataCell = fileread(Inputfilename):

%Find locations of NaN values
LocationIndex = ismissing(text,'');
IndexLength = length(LocationIndex);
LocationIndex1 = find(LocationIndex);

%Read timesteps
NumTimeSteps = (length(LocationIndex1)-3)/4;

%Preallocate timestep array
TimeSteps = NaN(NumTimeSteps,1);

i2 = 1;
%Fill in timesteps vector
for (i = 1:NumTimeSteps);
    
    i2 = i2 + 4;

    j = LocationIndex1(i2)+1;

    Textfiltered = text(j);
    TextFilterNum = regexprep(Textfiltered,'forces (t=','');
    TextFilterNum = regexprep(TextFilterNum,') for interface         2 surfa  side','');
    TimeSteps(i) = str2num(TextFilterNum);

end

%Determine number of nodes
NumNodes = length(text);
NumNodes = ceil((NumNodes-15-(7*NumTimeSteps))/(2*NumTimeSteps));

%Preallocate forces array
Forces = NaN(NumNodes,4,NumTimeSteps);

%Stateent to preallocate plot array
if PlotFlag == 1
             
            plotx = NaN(NumTimeSteps);

            
            ploty = NaN(NumTimeSteps);

            
            plotz = NaN(NumTimeSteps);
            i3 = 0;
end

%%Loop to fill in new array

for(i = 1:NumTimeSteps);
    for(i2 = 1:NumNodes);
        if i == 1 & i2 == 1
            
        j2 = 16;

        elseif i2 == 1
            j2 = j2+9;
        else
            j2 = j2+2;
        end

        
        %Fill in node number
        splitStr = regexp(text(j2),'        ','split');
        Forces(i2,1,i) = splitStr(1);

        %Extract values from String array
        newStr = regexprep(text(j2),'      ....        ','');
        splitStr = regexp(newStr,'  ','split');
        xforce = str2num(splitStr(1));
        Forces(i2,2,i) = xforce;

        yforce = str2num(splitStr(2));
        Forces(i2,3,i) = yforce;

        zforce = str2num(splitStr(3));
        Forces(i2,4,i) = zforce;
        
        %Statement used to plot individual nodes
        if  Forces(i2,1,i) == PlotNode && PlotFlag == 1
            i3 = i3+1;
             %Fill in x force
            plotx(i3) = xforce;

            %Fill in y force
            ploty(i3) = yforce;

            %Fill in z force
            plotz(i3) = zforce;
        end

    end
end
%Save forces to output
save('forces.mat',"Forces");