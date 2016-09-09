function v = vFun( i, A)

    v = 0;
    
    [n, m] = size(A);
    
    for k = 1:n
        v = v + A(i, k)^2;
    end

end