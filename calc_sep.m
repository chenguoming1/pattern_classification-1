function measure= calc_sep(P,Q,D,TRIALS)
    count_inseperable = 0;
    N = P+Q;
    for i=1:TRIALS
        [X,Y]=coin_simulator(P,Q,D);
        %X
        match = 0;
        for i = 1:Q % compare each Q row to each penny row
            for j = Q+1:N % penny row
                if(X(i,:) == X(j,:))
                    match= match+ 1;
                end
            end
        end
        if(match > 0)
            count_inseperable = count_inseperable+1;
        end
    end

    measure = 1-count_inseperable/TRIALS;
end