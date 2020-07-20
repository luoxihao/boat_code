A = 21;
B = 4;
H =0.12;
p = [];

for M = 0.964-0.848:0.001:0.964
W_density = 1000;   %ˮ�ܶ�
% Ans = 0;
%���ֲ���
low=0; 
Accuracy =  0.000001;%���ò��ҵĵײ�
high=H-Accuracy; %���ò��ҵĶ���
while low<=high
    % low
    % high
    if (low~=0&&high~=H-Accuracy)
      
    end
    mid = (low + high)./2;%�����ǰ���������
    Y_max = sqrt(mid./B);
    X_max = @(y,x,z) sqrt((mid-B.*y.^2)./A);
    X_min = @(y,x,z) -sqrt((mid-B.*y.^2)./A);
    Z_min = @(y,x,z) A.*x.^2+B.*y.^2;
    f = @(y,x,z) 1+x.*0+y.*0+z.*0;
    V = integral3(f, -Y_max, Y_max, X_min, X_max, Z_min, mid,'Method','tiled');% �ſ�ˮ�����
    F = V*W_density;  
    
    if(abs(M-F)<=0.001)  %���㾫�ȵĽ������������
        Ans = mid ;
        p(end+1)=Ans;
        break
        % disp(['-----------------------------------------------------------------'])
    end

    if (M < F)
        high = mid - Accuracy;
    end
    
    if M>F
        low = mid + Accuracy;
    end

end
end
title('����������ˮƽ��ˮ�ߵĹ�ϵͼ');
xlabel('���� kg');
ylabel('ˮƽ��ˮ�� m');
hold on
plot(0.964-0.848:0.001:0.964,p)