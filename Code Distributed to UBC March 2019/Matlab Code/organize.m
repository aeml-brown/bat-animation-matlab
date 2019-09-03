function [Points2] = organize(Points,W)
% This function is important because it organizes the data. The function
% has 2 inputs.Points represents an array which contains the column headers
% with the names of all the points tracked. At the end of the organization,
% Points2 is a row of all names of the points tracked, and the named
% columns correspond to the column of coordinates in the Bat array in the
% animation function.
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%


 
col = W/3;
Points2 = cell(1,col);
% everytime the header equals the name of the point followed by "_Z", the
% name of the point is added to Points2 array in its corresponding
% position. Because this looks at every third header, the corresponding
% position is the position of the z-header divided by 3. This loops through
% the entire Points array and creates a switch statement on the value of
% every header. It considers the cases for all of the z-coordinate names.
for i=1:+1:W
    
    switch Points{1,i} 
        
        case 'Le01L_Z'
          
          Points2{1,i/3} = 'Le01L';
        
        case 'Le01R_Z'
          
          Points2{1,i/3} = 'Le01R';
        
        case 'Le02L_Z'
         
          Points2{1,i/3} = 'Le02L';
        
        case 'Le02R_Z'
       
          Points2{1,i/3} = 'Le02R';
        
        case 'Le03L_Z'
         
          Points2{1,i/3} = 'Le03L';
       
        case 'Le03R_Z'
         
          Points2{1,i/3} = 'Le03R';
        
        case 'Mf01L_Z'    
          
          Points2{1,i/3} = 'Mf01L';
        
        case 'Mf01R_Z'
         
          Points2{1,i/3} = 'Mf01R';
        
        case 'Mf02L_Z'    
       
          Points2{1,i/3} = 'Mf02L';
        
        case 'Mf02R_Z'
         
          Points2{1,i/3} = 'Mf02R';
        
        case 'Mf03L_Z'    
        
          Points2{1,i/3} = 'Mf03L';
       
        case 'Mf03R_Z'
          
          Points2{1,i/3} = 'Mf03R';
        
        case 'Mi01L_Z'    
       
          Points2{1,i/3} = 'Mi01L';
       
        case 'Mi01R_Z'
          
          Points2{1,i/3} = 'Mi01R';
        
        case 'Mi02L_Z'    
          Points2{1,i/3} = 'Mi02L';
        
        case 'Mi02R_Z'
          
          Points2{1,i/3} = 'Mi02R';
        
        case 'Mi03L_Z'    
         
          Points2{1,i/3} = 'Mi03L';
        
        case 'Mi03R_Z'
          
          Points2{1,i/3} = 'Mi03R';
        
        case 'Mi04L_Z'    
        
          Points2{1,i/3} = 'Mi04L';
        
        case 'Mi04R_Z'
        
          Points2{1,i/3} = 'Mi06R';
        
        case 'Mi05L_Z'    
        
          Points2{1,i/3} = 'Mi05L';
        
        case 'Mi05R_Z'
          
          Points2{1,i/3} = 'Mi05R';
        
        case 'Mi06L_Z'    
          
          Points2{1,i/3} = 'Mi06L';
        
        case 'Mi06R_Z'
      
          Points2{1,i/3} = 'Mi04R';
        
        case 'Mi07L_Z'    
         
          Points2{1,i/3} = 'Mi07L';
        
        case 'Mi07R_Z'
        
          Points2{1,i/3} = 'Mi07R';
        
        case 'Mi08L_Z'    
          
          Points2{1,i/3} = 'Mi08L';
        
        case 'Mi08R_Z'
         
          Points2{1,i/3} = 'Mi08R';
       
        case 'Mi09L_Z'    
       
          Points2{1,i/3} = 'Mi09L';
        
        case 'Mi09R_Z'
      
          Points2{1,i/3} = 'Mi09R';
        
        case 'Mm01L_Z' 
        
          Points2{1,i/3} = 'Mm01L';
        
        case 'Mm01R_Z'
        
          Points2{1,i/3} = 'Mm01R';
       
        case 'Mm02L_Z'   
     
          Points2{1,i/3} = 'Mm02L';
        
        case 'Mm02R_Z'
 
          Points2{1,i/3} = 'Mm02R';
        
        case 'Mm03L_Z'    

          Points2{1,i/3} = 'Mm03L';
        
        case 'Mm03R_Z'
    
          Points2{1,i/3} = 'Mm03R';
        
        case 'Mo01L_Z'   
   
          Points2{1,i/3} = 'Mo01L';
        
        case 'Mo01R_Z'

          Points2{1,i/3} = 'Mo01R';
        
        case 'Mo02L_Z'    

          Points2{1,i/3} = 'Mo02L';
        
        case 'Mo02R_Z'

          Points2{1,i/3} = 'Mo02R';
        
        case 'Mo03L_Z'    
  
          Points2{1,i/3} = 'Mo03L';
        
        case 'Mo03R_Z'
    
          Points2{1,i/3} = 'Mo03R';
        
        case 'shdL_Z'

          Points2{1,i/3} = 'shdL';
        
        case 'shdR_Z'
    
          Points2{1,i/3} = 'shdR';
        
        case 'wstL_Z'
    
          Points2{1,i/3} = 'wstL';
        
        case 'wstR_Z'

          Points2{1,i/3} = 'wstR';
        
        case 'elbL_Z'
  
          Points2{1,i/3} = 'elbL';
       
        case 'elbR_Z'
  
          Points2{1,i/3} = 'elbR';
        
        case 't3L_Z'
      
          Points2{1,i/3} = 't3L';
        
        case 't3R_Z'
      
          Points2{1,i/3} = 't3R';
        
        case 't4L_Z'
  
          Points2{1,i/3} = 't4L';
        
        case 't4R_Z'
 
          Points2{1,i/3} = 't4R';
        
        case 't5L_Z'
          Points2{1,i/3} = 't5L';
        
        case 't5R_Z'
 
          Points2{1,i/3} = 't5R';
        
        case 'mcp3L_Z'
   
          Points2{1,i/3} = 'mcp3L';
        
        case 'mcp3R_Z'
       
          Points2{1,i/3} = 'mcp3R';
        
        case 'mcp4L_Z'
  
          Points2{1,i/3} = 'mcp4L';
        
        case 'mcp4R_Z'
     
          Points2{1,i/3} = 'mcp4R';
        
        case 'mcp5L_Z'
    
          Points2{1,i/3} = 'mcp5L';
        
        case 'mcp5R_Z'
    
          Points2{1,i/3} = 'mcp5R';
       
        case 'ip3L_Z'
   
          Points2{1,i/3} = 'ip3L';
        
        case 'ip3R_Z'
   
          Points2{1,i/3} = 'ip3R';
        
        case 'ip4L_Z'

          Points2{1,i/3} = 'ip4L';
        
        case 'ip4R_Z'
    
          Points2{1,i/3} = 'ip4R';
        
        case 'ip5L_Z'
     
          Points2{1,i/3} = 'ip5L';
        
        case 'ip5R_Z'
     
          Points2{1,i/3} = 'ip5R';
        
        case 'hipL_Z'
    
          Points2{1,i/3} = 'hipL';
        
        case 'hipR_Z'
 
          Points2{1,i/3} = 'hipR';
        
        case 'kneeL_Z'
    
          Points2{1,i/3} = 'kneeL';
        
        case 'kneeR_Z'
   
          Points2{1,i/3} = 'kneeR';
        
        case 'ankL_Z'
  
          Points2{1,i/3} = 'ankL';
       
        case 'ankR_Z'
   
          Points2{1,i/3} = 'ankR';
        
        case 'lmb_Z'
 
          Points2{1,i/3} = 'lmb';
       
        case 'str_Z'
    
          Points2{1,i/3} = 'str';
        
        case 'Sj18L_Z'
  
          Points2{1,i/3} = 'Sj18L';
        
        case 'Sj18R_Z'
  
          Points2{1,i/3} = 'Sj18R';
        
        case 'Sj19L_Z'
 
          Points2{1,i/3} = 'Sj19L';
        
        case 'Sj19R_Z'

          Points2{1,i/3} = 'Sj19R';
        
        case 'Sj20L_Z'
  
          Points2{1,i/3} = 'Sj20L';
        
        case 'Sj20R_Z'

          Points2{1,i/3} = 'Sj20R';
        
        case 'Sj21L_Z'
    
          Points2{1,i/3} = 'Sj21L';
        
        case 'Sj21R_Z'
   
          Points2{1,i/3} = 'Sj21R';
        
        case 'Te01L_Z'
    
          Points2{1,i/3} = 'Te01L';
        
        case 'Te01R_Z'
      
          Points2{1,i/3} = 'Te01R';
        
        case 'Te02L_Z'
  
          Points2{1,i/3} = 'Te02L';
        
        case 'Te02R_Z'
  
          Points2{1,i/3} = 'Te02R';
        
        case 'Te03L_Z'

          Points2{1,i/3} = 'Te03L';
        
        case 'Te03R_Z'
     
          Points2{1,i/3} = 'Te03R';
        
        case 'Te04L_Z'
        
          Points2{1,i/3} = 'Te04L';
       
        case 'Te04R_Z'
          
          Points2{1,i/3} = 'Te04R';
        
        case 'Te05L_Z'
          
          Points2{1,i/3} = 'Te05L';
        
        case 'Te05R_Z'
          
          Points2{1,i/3} = 'Te05R';
        
        case 'Te06L_Z'
         
          Points2{1,i/3} = 'Te06L';
        
        case 'Te06R_Z'
          
          Points2{1,i/3} = 'Te06R';
        
        case 'Te07L_Z'
          
          Points2{1,i/3} = 'Te07L';
        
        case 'Te07R_Z'
          
          Points2{1,i/3} = 'Te07R';
        
        case 'Te08L_Z'
          
          Points2{1,i/3} = 'Te08L';
        
        case 'Te08R_Z'
         
          Points2{1,i/3} = 'Te08R';
       
        case 'Te09L_Z'
          
          Points2{1,i/3} = 'Te09L';
        
        case 'Te09R_Z'
          
          Points2{1,i/3} = 'Te09R';
        
        case 'Sn01L_Z'
          
          Points2{1,i/3} = 'Sn01L';
        
        case 'Sn01R_Z'
         
          Points2{1,i/3} = 'Sn01R';
        
        case 'Sn02L_Z'
          
          Points2{1,i/3} = 'Sn02L';
        
        case 'Sn02R_Z'
          
          Points2{1,i/3} = 'Sn02R';
        
        case 'Sn03L_Z'
          
          Points2{1,i/3} = 'Sn03L';
        
        case 'Sn03R_Z'
          
          Points2{1,i/3} = 'Sn03R';
        
        case 'Sn04L_Z'
          
          Points2{1,i/3} = 'Sn04L';
        
        case 'Sn04R_Z'
          
          Points2{1,i/3} = 'Sn04R';
        
        case 'Sn05L_Z'
          
          Points2{1,i/3} = 'Sn05L';
        
        case 'Sn05R_Z'
          
          Points2{1,i/3} = 'Sn05R';
        
        case 'Sn06L_Z'
          
          Points2{1,i/3} = 'Sn06L';
        
        case 'Sn06R_Z'
          
          Points2{1,i/3} = 'Sn06R';
    end
   
    
    %Points3 = Points2;
    
end
end

