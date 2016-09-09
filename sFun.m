function s = sFun( i, j, A)

    s = 0;
    
    [n, m] = size(A);
    
    for k = 1:n
        s = s + A(i,k)*A(k,j);
    end

end