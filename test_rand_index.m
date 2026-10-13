%% Two arbitrary partitions
p1 = [1 2 3 3 2 1 1 3 3 1 2 2];
p2 = [3 2 3 2 2 1 1 2 3 1 3 1];

% Compute the unadjusted rand index
ri = rand_index(p1, p2);
assert(ri == 7/11);

% Compute the adjusted rand index
ari = rand_index(p1, p2, 'adjusted');
assert(ari == 1/12);

%% Two perfect partitions
p1 = [1 1 1];
p2 = [1 1 1];

% Compute the unadjusted rand index
ri = rand_index(p1, p2);
assert(ri == 1);

% Compute the adjusted rand index
ari = rand_index(p1, p2, 'adjusted');
assert(ari == 1);

%% Relabeling clusters does not change the partition
p1 = [1 1 2 2];
p2 = [9 9 4 4];
assert(rand_index(p1, p2) == 1);
assert(rand_index(p1, p2, 'adjusted') == 1);

%% Opposite pair relationships
assert(rand_index([1 1 1], [1 2 3]) == 0);
assert(rand_index([1 1 1], [1 2 3], 'adjusted') == 0);

%% Invalid inputs fail with an informative error
try
    rand_index([1 2], [1]);
    error('Expected an error for unequal partition lengths.');
catch err
    assert(contains(err.message, 'same number of points'));
end

try
    rand_index(1, 1);
    error('Expected an error for a single point.');
catch err
    assert(contains(err.message, 'at least two points'));
end
