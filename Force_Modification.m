function [Forces_Modified, TimeSteps_Modified, NumTimeSteps_Modified] = Force_Modification(Forces, InputPasses, DesiredPasses, TimeSteps, NumTimeSteps, NumNodes)

%Find new end timestep and fill timestep array
%CurrentEndTime = TimeSteps(NumTimeSteps);
%DesiredEndTime = CurrentEndTime*(InputPasses/DesiredPasses);

NumTimeStepsPass = ceil(NumTimeSteps/InputPasses);
NumTimeSteps_Modified = NumTimeSteps*DesiredPasses;
AppendArray = TimeSteps((1+NumTimeSteps-NumTimeStepsPass):NumTimeSteps);
FirstPassEnd = TimeSteps(NumTimeStepsPass);

%Preallocate extended array
TimeSteps_Modified = NaN(NumTimeSteps_Modified,1);
TimeSteps_Modified(1:NumTimeSteps) = TimeSteps;

%Fill New Timestep Array
for i = (1:DesiredPasses)
    
    %Find New Timesteps
    AppendArray = AppendArray+FirstPassEnd;
    
    %Append Timesteps To Timestep Array
    TimeSteps_Modified(NumTimeSteps*i:i*NumTimeStepsPass+NumTimeSteps-1) = AppendArray;
    
end

%Preallocate Modified Forces Array
Forces_Modified = NaN(NumNodes,4,NumTimeSteps_Modified);
%Allocate existing forces
Forces_Modified(:,:,1:NumTimeSteps) = Forces(:,:,:);

%Extract Required Forces
AppendForces = Forces(:,:,NumTimeSteps-NumTimeStepsPass+1:NumTimeSteps);

for i = (1:DesiredPasses)
  
    %Append Forces To New Array
    Forces_Modified(:,:,i*NumTimeSteps+1:i*NumTimeSteps+NumTimeStepsPass) = AppendForces;

end