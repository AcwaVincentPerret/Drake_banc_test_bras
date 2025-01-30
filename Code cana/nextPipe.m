function [type] = nextPipe(pipeline,index)
   
   %true = curve pipe
   %false = straight pipe 
   N = size(pipeline, 1);
   if index+ 1 > N || pipeline(index+1,1) == 1 || pipeline(index+1,1) == 3
       type = false ;
      
   else 
       type = true ;              
   end  
   
end 
