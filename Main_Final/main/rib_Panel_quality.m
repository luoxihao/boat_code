function Ans= rib_Panel_quality( Z_UP , ro ,A , B, Y )
    %   计算肋骨面板的质量
    % Y = [Y1 Y2 Y3 Y4 Y5];
    thick = 1;%
    X = sqrt((Z_UP-B.*Y.^2)./A);%x的上下限

    Ans=zeros(1,5,'double');
    for i=1:5
        f2 = @(x,z) 1.*thick.*ro+x.*0;%被积函数句柄
        Z_section = @(x) A.*x.^2+B.*Y(i).^2;%z的下限
        Ans(i)=integral2(f2,-X(i), X(i), Z_section ,Z_UP);%结果存入数组中
    end
end

