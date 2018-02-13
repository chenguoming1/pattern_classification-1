function [X,Y] = coin_simulator(P,Q,D)
    N = P+Q;
    X = zeros(N,D); % NxD matrix data, 1 represents heads, 0 tails
    Y = zeros(N,1); % Nx1 labels 

    for i=1:Q % quarter :
        X(i,:) = randi([0,1],1,D);
        Y(i) = 1; % quarters have label 1
    end

    for j = Q+1:N % pennies
        X(j,:) = randi([0,1],1,D);
        Y(j) = 0; % pennies have label 0
    end
end
%% 