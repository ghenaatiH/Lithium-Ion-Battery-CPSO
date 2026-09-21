function x=ParseSolution(xhat)
    % Without Top  
    %weights=[0.5,0.5,0.5,1000,5,0.5,0.5,1000]; 
    %bias =  [0.5,0.5,0.5,0,   5,0.5,0.5,0   ];
    
    % With Top ( Operating Time)
    weights=[0.5,0.5,0.5,1000,5,0.5,0.5,1000,0.05,1000,0.5]; 
    bias =  [0.5,0.5,0.5,0,   5,0.5,0.5,0   ,0.06,   0,0.5];
    
    x=xhat.*weights+bias;
end