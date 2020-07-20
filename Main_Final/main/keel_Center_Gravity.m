function Ans = keel_Center_Gravity(Y_MAX , Density  ,Z_UP,B)

    %   �������ǵ�����
    thick = 1;              %���
    keel_Z_section = @(y) B.*y.^2; %�������޾��
    f1 = @(y,z) y.*0+Density.*z.*thick;%
    f2 = @(y,z) y.*0+thick.*Density;   %�������
    a = integral2(f1, -Y_MAX ,Y_MAX ,keel_Z_section ,  Z_UP);
    b = integral2(f2, -Y_MAX ,Y_MAX ,keel_Z_section ,  Z_UP);
    Ans = a./b;

end

