function  Ans  = boat_Center_Gravity( Z,M )
    %   ���ܴ�������
    m=0;
    z_m=0;
    for i=1:length(Z)
        z_m = z_m+M(i).*Z(i);

        M(i);
        m = m+M(i);
    end
    Ans = z_m./m;
end

