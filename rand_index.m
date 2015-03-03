function INDEX = rand_index(C1, C2, MOD)
    %% THROW ERRORS
    if length(C1)~=length(C2)
        error('Both partitions must contain the same number of points');
    end
    if MOD~=1 && MOD~=0
        error('The value of MOD must be either 1 or 0.')
    end
    
    %% PRELIMS
    N = length(C1);
    [junk1 junk2 C1] = unique(C1);
    N1 = max(C1);
    [junk1 junk2 C2] = unique(C2);
    N2 = max(C2);
    
    %% FORM MATCHING MATRIX
    for i=1:1:N1
        for j=1:1:N2
            G1 = find(C1==i);
            G2 = find(C2==j);
            n(i,j) = length(intersect(G1,G2));
        end
    end
    
    %% CALCULATE RAND INDEX
    if MOD==0
        ss = sum(sum(n.^2));
        ss1 = sum(sum(n,1).^2);
        ss2 =sum(sum(n,2).^2);
        INDEX = (nchoosek2(N,2) + ss - 0.5*ss1 - 0.5*ss2)/nchoosek2(N,2);
    end
    
    
    %% CALCULATE ADJUSTED RAND INDEX
    if MOD==1
        ssm = 0;
        sm1 = 0;
        sm2 = 0;
        for i=1:1:N1
            for j=1:1:N2
                ssm = ssm + nchoosek2(n(i,j),2);
            end
        end
        temp = sum(n,2);
        for i=1:1:N1
            sm1 = sm1 + nchoosek2(temp(i),2);
        end
        temp = sum(n,1);
        for i=1:1:N2
            sm2 = sm2 + nchoosek2(temp(i),2);
        end
        NN = ssm - sm1*sm2/nchoosek2(N,2);
        DD = (sm1 + sm2)/2 - sm1*sm2/nchoosek2(N,2);
        INDEX = NN/DD;
    end 
    

    function c = nchoosek2(a,b)
        if a>1
            c = nchoosek(a,b);
        else
            c = 0;
        end
    end
end
