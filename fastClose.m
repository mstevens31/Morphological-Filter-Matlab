function out = fastClose(strucElementLength,data)
clear invar

% set up output vector
out = zeros(1,length(data));


for i = ceil(strucElementLength/2):length(data)-ceil(strucElementLength/2)
    windowStart = i-floor(strucElementLength/2);
    windowEnd = i+floor(strucElementLength/2);
    
 
%     put window on data
   window = data(windowStart:windowEnd);
   
%    window = window;
   
   if i == ceil(strucElementLength/2);
%        for the first time through the loop, just do a max of the
%        whole window
       [invar.val,invar.locTemp] = max(window); 
%        locate all invars - only used for a count
       
%        number of invars
%         invar.val = window(invar.locTemp);
        invar.loc = invar.val == window;
%        outputVector is simply the invariable for all elements
       outputVec = invar.val*ones(1,strucElementLength);
   else    
%        shift the output vector by one element
       outputVec(1:strucElementLength-1) = outputVec(2:end);  
% %        count the number of invariant values
       if invar.count == 1
%             if there is only one, check its location
            if invar.locTemp == 1
% %           if it is located at the far left end of the previous window,...
%           then do a maximum of the whole window
               [invar.val, invar.locTemp] = max(window); 
        %        locate all invars
            
%                invar.val = window(invar.locTemp);
                  invar.loc = invar.val == window;
        %        number of invars
               invar.count = sum(invar.loc);
%                replace the section of the output vector from previous var
%                to new var with new var
               outputVec(invar.locTemp:end) = invar.val*ones(1,strucElementLength-(invar.locTemp-1));
            else
%                 compare the current invar with the new invar
%                     and replace if larger
                if window(end) >= invar.val
                invar.val = window(end);
                outputVec(invar.locTemp:end) = invar.val*ones(1,strucElementLength - (invar.locTemp-1));
%                              
                end
%                 else leave outputVec unchanged
            end
            
       else
%                 compare the current invar with the new invar
            if window(end) >= invar.val
                invar.val = window(end);
                outputVec(invar.locTemp:end) = invar.val*ones(1,strucElementLength - (invar.locTemp-1));
            
            end
%             else leave outputVec unchanged
        end
                    invar.locTemp = find(window == invar.val,1,'first');
 
   end
%        modify the final output
    invar.loc = invar.val == window;
    invar.count = sum(invar.loc);
   out(windowStart:windowEnd) = outputVec;
       
    
end

% adjust the end of the output so that it is not zero
temp = out((length(data)-ceil(strucElementLength/2)+1):end);
a = length(temp);
out((length(data)-ceil(strucElementLength/2)+1):end) = ...
    out(length(data)-ceil(strucElementLength/2))*ones(1,a);


end

