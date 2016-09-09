%% Parameters.
A = [4 -1 1 -1; 
    1 2 1 -1; 
    1 -1 4 -1 ; 
    1 -1 1 2];

beta = 2;

[n, m] = size(A);

%% First diagonal element.
 
minii = @(i, x, y)-x*y*A(i,i) +x + y + 1/(2*beta)*(...
     (x*y*sFun(i,i,A) - (x+y)*A(i,i)+1)...
     - sqrt(x*x*uFun(i,A) - 2*x*A(i,i) + 1)*...
     sqrt(y*y*vFun(i,A) - 2*y*A(i,i) + 1));

maxii = @(i, x, y)-x*y*A(i,i) +x + y + 1/(2*beta)*(...
     (x*y*sFun(i,i,A) - (x+y)*A(i,i)+1)...
     + sqrt(x*x*uFun(i,A) - 2*x*A(i,i) + 1)*...
     sqrt(y*y*vFun(i,A) - 2*y*A(i,i) + 1));

B = inv(A);

lim = 1;
step = 0.01;

bestMinBound = -999999;
bestMaxBound = 9999999;
for x = -lim:step:lim
    for y = -lim:step:lim
        % min Bound
        boundMin = minii(1,x,y);
        %display(['BOUND: ', num2str(bound), '. VAL:', num2str(B(1,1))]); 
        if boundMin > B(1,1)
           display(['Error! with x = ', num2str(x), ' , and y = ', num2str(y)]); 
        else
            if boundMin > bestMinBound
                bestMinBound = boundMin;
            end
        end
        
        % max bound
        boundMax = maxii(1,x,y);
        %display(['BOUND: ', num2str(bound), '. VAL:', num2str(B(1,1))]); 
        if boundMax < B(1,1)
           display(['Error! with x = ', num2str(x), ' , and y = ', num2str(y)]); 
        else
            if boundMax < bestMaxBound
                bestMaxBound = boundMax;
            end
        end
    end
end

bestMinBound
bestMaxBound