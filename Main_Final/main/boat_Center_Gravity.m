function  Ans  = boat_Center_Gravity( Z,M )
    %   汇总船的重心
    m=0;
    z_m=0;
    for i=1:length(Z)
        z_m = z_m+M(i).*Z(i);

        M(i);
        m = m+M(i);
    end
    Ans = z_m./m;
end

