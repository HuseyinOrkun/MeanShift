function test_points = test()
    nPtsPerClust = 250;
    nClust = 4; % define 4 clusters
    totalNumPts = nPtsPerClust*nClust;
    m(:,1) = [0.1,0.2]';
    m(:,2) = [0.2,0.6]';
    m(:,3) = [0.8,0.9]';
    m(:,4) = [0.5,0.1]';
    var = .1;

    nPtsPerClust = [100,125,150,200];
    %rng(0); % comment out if you want to make the data random
    x = var*randn(2,sum(nPtsPerClust));
    %*** build the point set
    ox = zeros(2,0);
    for i = 1:nClust
        ox = [ox,repmat(m(:,i),1,nPtsPerClust(i))];   
    end
    x = ox + x;
    test_points = x.';
    figure;scatter(test_points(:,1),test_points(:,2)); hold on; 
end