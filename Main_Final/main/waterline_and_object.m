A = 21;
B = 4;
H =0.12;
p = [];

for M = 0.964-0.848:0.001:0.964
W_density = 1000;   %水密度
% Ans = 0;
%二分查找
low=0; 
Accuracy =  0.000001;%设置查找的底部
high=H-Accuracy; %设置查找的顶部
while low<=high
    % low
    % high
    if (low~=0&&high~=H-Accuracy)
      
    end
    mid = (low + high)./2;%求出当前区间的中心
    Y_max = sqrt(mid./B);
    X_max = @(y,x,z) sqrt((mid-B.*y.^2)./A);
    X_min = @(y,x,z) -sqrt((mid-B.*y.^2)./A);
    Z_min = @(y,x,z) A.*x.^2+B.*y.^2;
    f = @(y,x,z) 1+x.*0+y.*0+z.*0;
    V = integral3(f, -Y_max, Y_max, X_min, X_max, Z_min, mid,'Method','tiled');% 排开水的体积
    F = V*W_density;  
    
    if(abs(M-F)<=0.001)  %满足精度的结果存入结果数组
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
title('重物质量与水平吃水线的关系图');
xlabel('重量 kg');
ylabel('水平吃水线 m');
hold on
plot(0.964-0.848:0.001:0.964,p)