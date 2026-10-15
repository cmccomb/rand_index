function ri = rand_index(p1, p2, varargin)
%RAND_INDEX Computes the rand index between two partitions.
%   RAND_INDEX(p1, p2) computes the rand index between partitions p1 and
%   p2. Both p1 and p2 must be specified as N-by-1 or 1-by-N vectors in
%   which each element is a finite real numeric cluster label. Labels do
%   not need to be consecutive integers; only equality matters.
%
%   RAND_INDEX(p1, p2, 'adjusted') computes the adjusted rand index
%   between partitions p1 and p2. The adjustment accounts for chance
%   correlation.

    %% Parse the input and throw errors
    % Check inputs
    adj = 0;
    if nargin == 0
        error('Arguments must be supplied.');
    end
    if nargin == 1
        error('Two partitions must be supplied.');
    end
    if nargin > 3
        error('Too many input arguments');
    end
    if nargin == 3
        if strcmp(varargin{1}, 'adjusted')
            adj = 1;
        else
            error('%s is an unrecognized argument.', varargin{1});
        end
    end
    if numel(p1)~=numel(p2)
        error('Both partitions must contain the same number of points.');
    end
    if numel(p1) < 2
        error('Partitions must contain at least two points.');
    end
    if ~isnumeric(p1) || ~isnumeric(p2) || ...
            ~isreal(p1) || ~isreal(p2) || ...
            any(~isfinite(p1(:))) || any(~isfinite(p2(:)))
        error('Partitions must contain finite real numeric labels.');
    end
    if ~isvector(p1) || ~isvector(p2)
        error('Partitions must be vectors with one label per observation.');
    end

	%% Preliminary computations and cleansing of the partitions
    N = numel(p1);
    [~, ~, p1] = unique(p1);
    N1 = max(p1);
    [~, ~, p2] = unique(p2);
    N2 = max(p2);

    n = zeros(N1,N2);
    %% Create the matching matrix
    for i = 1:length(p1)
        n(p1(i), p2(i)) = n(p1(i), p2(i)) + 1;
    end

    %% If required, calculate the basic rand index
    if adj==0
        ss = sum(sum(n.^2));
        ss1 = sum(sum(n,1).^2);
        ss2 =sum(sum(n,2).^2);
        ri = (nchoosek2(N,2) + ss - 0.5*ss1 - 0.5*ss2)/nchoosek2(N,2);
    end


    %% Otherwise, calculate the adjusted rand index
    if adj==1
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

        % Special case to handle perfect partitions
        if (NN == 0 && DD==0)
            ri = 1;
        else
            ri = NN/DD;
        end
    end


    %% Special definition of n choose k
    function c = nchoosek2(a,b)
        if a>1
            c = nchoosek(a,b);
        else
            c = 0;
        end
    end
end
