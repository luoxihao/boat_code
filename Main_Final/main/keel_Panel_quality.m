function Ans = keel_Panel_quality( Y_MAX , Density  ,Z_UP,B )
    %   计算龙骨面板质量
    thick = 1;              %厚度
    keel_Z_section = @(y) B.*y.^2; %z积分下限

    f2 = @(y,z) y.*0+thick.*Density;   %被积函数句柄

    b = integral2(f2, -Y_MAX ,Y_MAX ,keel_Z_section ,  Z_UP);

    Ans = b;

end

