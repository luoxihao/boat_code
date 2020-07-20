function  Ans  = rib_Center_Gravity_Z(Z_UP , Density ,A , B , Y)
%���߹ǵ����� ��������
    thick = 1;%
    X = sqrt((Z_UP-B.*Y.^2)./A);
    M = rib_Panel_quality( Z_UP , Density ,A , B, Y );% ���ÿ���߹ǵ�����

    a=zeros(1,5,'double');
    for i=1:5
        Z_section = @(x) A.*x.^2+B.*Y(i).^2;  %z������
        f1 = @(x,z) thick.*Density.*z;
        % f2 = @(x,z) x.*(1./x).*thick.*Density;
        a(i) = integral2(f1,-X(i), X(i), Z_section ,Z_UP);% ���������
        % Ans(end+1) = a./M(i);
        % b = integral2(f2,-X, X, Z_section ,Z_UP);

    end


    Ans=a./M;% z������



end


