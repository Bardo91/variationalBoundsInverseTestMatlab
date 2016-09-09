[Xg,Yg] = meshgrid(-1:0.5:1,-1:0.5:1);
[d1,d2] = size(Xg);
Xs = [reshape(Xg,d1*d2,1),reshape(Yg,d1*d2,1)]';
n = length(Xs);

sigma = 1;
gamma = 1;

K = ComputeFullKder(sigma, gamma, Xs, 0.1, 0.1);
% figure(4);
% imagesc(K);
% colorbar;

%% CHECK BOUNDS
eigenVals = eig(A);
beta = 2;
alpha = max(eigenVals)*1;

A  = K;
[m,n] = size(A);
B = inv(A);

minii = @(i,j)...
        1/alpha ...
        +((A(j,j) - sFun(j,j,A)/alpha)*(1 - A(i,i)/alpha)^2 ...
        -2*(A(i,j) - sFun(i,j,A)/alpha)*(1-A(i,i)/alpha)*(-A(i,j)/alpha)...
        +(A(i,i)-sFun(i,i,A)/alpha)*(A(i,j)/alpha)^2)...
        /((A(i,i) - sFun(i,i,A)/alpha)*(A(j,j) - sFun(j,j,A)/alpha)...
        -(A(i,j) - sFun(i,j,A)/alpha)^2);
                    
maxii = @(i, x, y)...
        1/beta;
 
 
bestMinBound = -999999;
bestMaxBound = 9999999;

lim = 1;
step = 0.5;

for i = 1:m
    for j = i:n
        if i ~= j
            % min Bound
            boundMin = minii(i,j);
            %display(['BOUND: ', num2str(bound), '. VAL:', num2str(B(1,1))]); 
            if boundMin > B(1,1)
               display(['Error! with x = ', num2str(i), ' , and y = ', num2str(j)]); 
            else
                if boundMin > bestMinBound
                    bestMinBound = boundMin;
                end
            end

    %         % max bound
    %         boundMax = maxii(1,x,y);
    %         %display(['BOUND: ', num2str(bound), '. VAL:', num2str(B(1,1))]); 
    %         if boundMax < B(1,1)
    %            display(['Error! with x = ', num2str(x), ' , and y = ', num2str(y)]); 
    %         else
    %             if boundMax < bestMaxBound
    %                 bestMaxBound = boundMax;
    %             end
    %         end
        end
    end
end

bestMinBound
B(1,1)