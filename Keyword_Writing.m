%%Keyword writing
function output = Keyword_Writing(Forces_Modified, TimeSteps_Modified, NumTimeSteps_Modified, NumNodes, KFileName);

%Create name for new file
OutputFileName = insertBefore(KFileName,'.k','Modified');

%Create new kfile
fileid = fopen(OutputFileName,'a+');


%Read existing kfile into string vector
Text = readlines(KFileName);
TextLength = length(Text);
Text = [Text; strings(3*NumTimeSteps_Modified*NumNodes+3*8*NumNodes-1,1)];
OutputTextLength = length(Text);

%%Modify string matrix with x forces

%Overall counter and load curve ID
lcid = 10;
IndexLoc = TextLength-1;
ZeroTrigger = 0;
SkipCount = 0;
tic
for (i = 1:NumNodes)
        
        lcid = lcid + 1;
    
        Name = append('X Force ',num2str(lcid));

        nid = Forces_Modified(i,1,1);
        
        Text(IndexLoc) = '*DEFINE_CURVE_TITLE';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = Name;
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = '$#    lcid      sidr       sfa       sfo      offa      offo    dattyp     lcint';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = sprintf('%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f',lcid,0,1,1,0,0,0,0);
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = '$#                a1                  o1';
        IndexLoc = IndexLoc + 1;

                for k = 1:NumTimeSteps_Modified;
                    if k~= 1
                        PreviousForce = Forces_Modified(i,2,k-1);
                    else 
                        PreviousForce = Forces_Modified(i,2,k);
                    end
                    NextForce = Forces_Modified(i,2,k+1);
                    CurrentForce = Forces_Modified(i,2,k);
                    
                        if k == NumTimeSteps_Modified

                            Text(IndexLoc) = sprintf('%20.8e%20.4f',TimeSteps_Modified(k),Forces_Modified(i,2,k));
                            IndexLoc = IndexLoc + 1;

                        elseif NextForce == 0 && CurrentForce == 0 && ZeroTrigger == 0 && PreviousForce == 0
                            Text(IndexLoc) = sprintf('%20.8e%20.4f',TimeSteps_Modified(k),Forces_Modified(i,2,k));
            
                            IndexLoc = IndexLoc + 1;
                            
                            ZeroTrigger = 1;

                        elseif NextForce == 0 && CurrentForce == 0 && ZeroTrigger == 1  && PreviousForce == 0

                            SkipCount = SkipCount + 1;

                        else 
                            Text(IndexLoc) = sprintf('%20.8e%20.4f',TimeSteps_Modified(k),Forces_Modified(i,2,k));
            
                            IndexLoc = IndexLoc + 1;
                            ZeroTrigger = 0;

                        end

                end
        Text(IndexLoc) = '*LOAD_NODE_POINT';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = '$#     nid       dof      lcid        sf       cid        m1        m2        m3';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = sprintf('%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f',nid,1,lcid,1,27,0,0,0);
        IndexLoc = IndexLoc + 1;     
        ZeroTrigger = 0;
end

%%Modify string matrix with y Forces_Modified

ZeroTrigger = 0;

for (i = 1:NumNodes)
        
                
        lcid = lcid + 1;
    
        Name = append('Y Force ',num2str(lcid));

        nid = Forces_Modified(i,1,1);
        
        Text(IndexLoc) = '*DEFINE_CURVE_TITLE';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = Name;
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = '$#    lcid      sidr       sfa       sfo      offa      offo    dattyp     lcint';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = sprintf('%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f',lcid,0,1,1,0,0,0,0);
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = '$#                a1                  o1';
        IndexLoc = IndexLoc + 1;
        
                for k = 1:NumTimeSteps_Modified;
                    if k~= 1
                        PreviousForce = Forces_Modified(i,3,k-1);
                    else 
                        PreviousForce = Forces_Modified(i,3,k);
                    end
                    NextForce = Forces_Modified(i,3,k+1);
                    CurrentForce = Forces_Modified(i,3,k);
                    
                        if k == NumTimeSteps_Modified

                            Text(IndexLoc) = sprintf('%20.8e%20.4f',TimeSteps_Modified(k),Forces_Modified(i,3,k));
                            IndexLoc = IndexLoc + 1;

                        elseif NextForce == 0 && CurrentForce == 0 && ZeroTrigger == 0 && PreviousForce == 0
                            Text(IndexLoc) = sprintf('%20.8e%20.4f',TimeSteps_Modified(k),Forces_Modified(i,3,k));
            
                            IndexLoc = IndexLoc + 1;
                            
                            ZeroTrigger = 1;

                        elseif NextForce == 0 && CurrentForce == 0 && ZeroTrigger == 1  && PreviousForce == 0

                            SkipCount = SkipCount + 1;

                        else 
                            Text(IndexLoc) = sprintf('%20.8e%20.4f',TimeSteps_Modified(k),Forces_Modified(i,3,k));
            
                            IndexLoc = IndexLoc + 1;
                            ZeroTrigger = 0;

                        end

                end
                % for k = 1:NumTimeSteps_Modified;
                % Text(IndexLoc) = sprintf('%20.4e%20.4f',TimeSteps_Modified(k),Forces_Modified(i,3,k));
                % 
                % IndexLoc = IndexLoc + 1;
                % end
        Text(IndexLoc) = '*LOAD_NODE_POINT';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = '$#     nid       dof      lcid        sf       cid        m1        m2        m3';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = sprintf('%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f',nid,2,lcid,1,27,0,0,0);
        IndexLoc = IndexLoc + 1;
        ZeroTrigger = 0;

end

%%Modify string matrix with z forces

ZeroTrigger = 0;

for (i = 1:NumNodes)
        
               
        lcid = lcid + 1;
    
        Name = append('Z Force ',num2str(lcid));

        nid = Forces_Modified(i,1,1);
        
        Text(IndexLoc) = '*DEFINE_CURVE_TITLE';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = Name;
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = '$#    lcid      sidr       sfa       sfo      offa      offo    dattyp     lcint';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = sprintf('%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f',lcid,0,1,1,0,0,0,0);
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = '$#                a1                  o1';
        IndexLoc = IndexLoc + 1;

                for k = 1:NumTimeSteps_Modified;
                    if k~= 1
                        PreviousForce = Forces_Modified(i,4,k-1);
                    else 
                        PreviousForce = Forces_Modified(i,4,k);
                    end
                    NextForce = Forces_Modified(i,4,k+1);
                    CurrentForce = Forces_Modified(i,4,k);
                    
                        if k == NumTimeSteps_Modified

                            Text(IndexLoc) = sprintf('%20.8e%20.4f',TimeSteps_Modified(k),Forces_Modified(i,4,k));
                            IndexLoc = IndexLoc + 1;

                        elseif NextForce == 0 && CurrentForce == 0 && ZeroTrigger == 0 && PreviousForce == 0
                            Text(IndexLoc) = sprintf('%20.8e%20.4f',TimeSteps_Modified(k),Forces_Modified(i,4,k));
            
                            IndexLoc = IndexLoc + 1;
                            
                            ZeroTrigger = 1;

                        elseif NextForce == 0 && CurrentForce == 0 && ZeroTrigger == 1  && PreviousForce == 0

                            SkipCount = SkipCount + 1;

                        else 
                            Text(IndexLoc) = sprintf('%20.8e%20.4f',TimeSteps_Modified(k),Forces_Modified(i,4,k));
            
                            IndexLoc = IndexLoc + 1;
                            ZeroTrigger = 0;

                        end

                end        
                % for k = 1:NumTimeSteps_Modified;
                % Text(IndexLoc) = sprintf('%20.4e%20.4f',TimeSteps_Modified(k),Forces_Modified(i,4,k));
                % 
                % IndexLoc = IndexLoc + 1;
                % end
        Text(IndexLoc) = '*LOAD_NODE_POINT';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = '$#     nid       dof      lcid        sf       cid        m1        m2        m3';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = sprintf('%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f',nid,3,lcid,1,27,0,0,0);
        IndexLoc = IndexLoc + 1;
        ZeroTrigger = 0;

end
  %reterminate kfile

        Text(OutputTextLength-SkipCount) = '*END';

TextArrayTime = toc
%Print modified string vector to new kfile

tic

for(i = 1:(OutputTextLength-SkipCount))
    printText = append(Text(i),'\n');
    fprintf(fileid,printText) ;
end

WritingTime = toc

fclose('all');
output = Text;

