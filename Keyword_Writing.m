%%Keyword writing
function output = Keyword_Writing(Forces, NumNodes,TimeSteps, NumTimeSteps, KFileName)

%Create name for new file
OutputFileName = insertBefore(KFileName,'.k','Modified');

%Create new kfile
fileid = fopen(OutputFileName,'a+');


%Read existing kfile into string vector
Text = readlines(KFileName);
TextLength = length(Text);
Text = [Text; strings(3*NumTimeSteps*NumNodes+3*8*NumNodes-1,1)];
OutputTextLength = length(Text);

%%Modify string matrix with x forces

%Overall counter and load curve ID
lcid = 10;
IndexLoc = TextLength-1;

for (i = 1:NumNodes)
        
        lcid = lcid + 1;
    
        Name = append('X Force ',num2str(lcid));

        nid = Forces(i,1,1);
        
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

                for k = 1:NumTimeSteps;
                Text(IndexLoc) = sprintf('%20.4e%20.4f',TimeSteps(k),Forces(i,2,k));
            
                IndexLoc = IndexLoc + 1;
                end
        Text(IndexLoc) = '*LOAD_NODE_POINT';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = '$#     nid       dof      lcid        sf       cid        m1        m2        m3';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = sprintf('%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f',nid,1,lcid,1,27,0,0,0);
        IndexLoc = IndexLoc + 1;

        
        


        

end

%%Modify string matrix with y forces

for (i = 1:NumNodes)
        
                
        lcid = lcid + 1;
    
        Name = append('Y Force ',num2str(lcid));

        nid = Forces(i,1,1);
        
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

                for k = 1:NumTimeSteps;
                Text(IndexLoc) = sprintf('%20.4e%20.4f',TimeSteps(k),Forces(i,3,k));
            
                IndexLoc = IndexLoc + 1;
                end
        Text(IndexLoc) = '*LOAD_NODE_POINT';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = '$#     nid       dof      lcid        sf       cid        m1        m2        m3';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = sprintf('%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f',nid,2,lcid,1,27,0,0,0);
        IndexLoc = IndexLoc + 1;

end

%%Modify string matrix with z forces

for (i = 1:NumNodes)
        
               
        lcid = lcid + 1;
    
        Name = append('Z Force ',num2str(lcid));

        nid = Forces(i,1,1);
        
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

                for k = 1:NumTimeSteps;
                Text(IndexLoc) = sprintf('%20.4e%20.4f',TimeSteps(k),Forces(i,4,k));
            
                IndexLoc = IndexLoc + 1;
                end
        Text(IndexLoc) = '*LOAD_NODE_POINT';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = '$#     nid       dof      lcid        sf       cid        m1        m2        m3';
        IndexLoc = IndexLoc + 1;
        Text(IndexLoc) = sprintf('%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f',nid,3,lcid,1,27,0,0,0);
        IndexLoc = IndexLoc + 1;


end
  %reterminate kfile

        Text(OutputTextLength) = '*END';


%Print modified string vector to new kfile

for(i = 1:OutputTextLength)
    printText = append(Text(i),'\n');
    fprintf(fileid,printText) ;
end


fclose('all');
output = Text;

