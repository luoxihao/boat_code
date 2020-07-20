function Ans = keel_Panel_quality( Y_MAX , Density  ,Z_UP,B )
    %   ���������������
    thick = 1;              %���
    keel_Z_section = @(y) B.*y.^2; %z��������

    f2 = @(y,z) y.*0+thick.*Density;   %�����������

    b = integral2(f2, -Y_MAX ,Y_MAX ,keel_Z_section ,  Z_UP);

    Ans = b;

end

