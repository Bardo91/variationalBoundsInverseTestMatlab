function u = uFun( i, A)

    u = 0;
    
    [n, m] = size(A);
    
    for k = 1:n
        u = u + A(k,i)^2;
    end

end