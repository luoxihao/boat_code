function Ans = find_135_waterline(A,B,H,X_MAX,M,Angle)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%-----135求吃水线的c---------------------------------------------------------------------------------------------

    %设有一个角在水面


    K = tan(Angle./180.*pi);                %定义吃水线方程

    C=[H+K.*X_MAX H H-K.*X_MAX];         %求出线与船甲（xoz平面投影）板有角线的最大最小值
    
    % disp(C)
    %改二分
    low=C(1);                   %设置查找的底部
    Accuracy =  0.000001;               
    high=C(3)-Accuracy;         %设置查找的顶部
    Ans = -10;                  %定义用于存放结果

    while low<=high
        c = (low + high)./2; %求出当前区间的中心
        % if P ==0
        %     P=c;
        % elseif P==c
        %     break;
        % else
        %     P=c;
        % end
        syms x
        t =zeros(1,2,'double');
        f = A.*x.^2-x.*K-c==0;
        T = double(solve(f));
        for i=1:2
            if isreal(T(i)) 
            t(i) =T(i) ;
            end
        end
        X = sort(t);
        % %确定积分区域 1
        f = @(x,y,z) z.*0 + 1;
        X_min = X(2);
        X_max = X_MAX ;
        Y_min = @(x,y,z) -sqrt((H-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2 ;
        Z_max = @(x,y,z) x.*0+H;
        
        a = integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        
        % %---------------------------------------------------
        % %确定积分区域 2
        f = @(x,y,z) z.*0 + 1;
        X_max = X(2);
        X_min = (H-c)./K;  %吃水线方程与甲板方程在xoz平面的交点的x的值
        Y_min = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2;
        Z_max = @(x,y,z) x.*0+H;
        a =  a+ 2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %---------------------------------------------------
        % %确定积分区域 3
        f = @(x,y,z) z.*0 + 1;
        X_max = X(2);
        X_min = (H-c)./K;  %吃水线方程与甲板方程在xoz平面的交点的x的值
        Y_min = @(x,y,z) -sqrt((x.*K+c-A.*x.^2)./B);                
        Y_max = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Z_min = @(x,y,z) x.*K+c;
        Z_max = @(x,y,z) x.*0+H;
        a = a + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        
        %---------------------------------------------------------
        F = a*1000;
        if(abs(M-F)<=0.001)  %满足精度的结果存入结果数组
            % disp(['c = ',num2str(c)]);
            Ans = c ;
            % disp(['-----------------------------------------------------------------'])
        end
        if M > F
            high = c - Accuracy;
        end
        
        if M < F
            low = c + Accuracy;
        end
    end

    %当第一个没出结果时开始第二个情况
    if Ans==-10  
        disp('空');
        % 设两个角都在水里(情况2)：假设船的最低点不在水中 (c从 0到  0.1513 )
        % 改二分
        low=0; 
        Accuracy =  0.000001;%设置查找的底部
        high=C(1)-Accuracy; %设置查找的顶部
        Ans = -10;          %定义用于存放结果的数组


        while low<=high
            
            c = (low + high)./2;%求出当前区间的中心
            syms x
            f = A.*x.^2-x.*K-c==0; %求吃水线与船的xoz平面的交点
            T = double(solve(f));
            X = zeros(1,2,'double');
            for i=1:2
                if isreal(T(i)) 
                X(i) =T(i) ;
                end
            end
            % X = sort(X);
            %上半部分积分
            f = @(x,y,z) z.*0 + 1;
            X_min = X(2);
            X_max = X_MAX ;
            Y_min = @(x,y,z) -sqrt((H-A.*x.^2)./B);
            Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
            Z_min = @(x,y,z) A.*x.^2+B.*y.^2 ;
            Z_max = @(x,y,z) x.*0+H;
            t = integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
            
            %-----------------------------------------------------------------------
            %
            f = @(x,y,z) z.*0 + 1;
            X_max = X(2);
            X_min = X(1);  %吃水线方程与甲板方程在xoz平面的交点的x的值
            Y_min = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
            Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
            Z_min = @(x,y,z) A.*x.^2+B.*y.^2;
            Z_max = @(x,y,z) x.*0+H;
            t =  t+ 2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
            
            %-----------------------------------------------------------------------
            %
            f = @(x,y,z) z.*0 + 1;
            X_max = X(2);
            X_min = X(1);  %吃水线方程与甲板方程在xoz平面的交点的x的值
            Y_min = @(x,y,z) -sqrt((x.*K+c-A.*x.^2)./B);                
            Y_max = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
            Z_min = @(x,y,z) x.*K+c;
            Z_max = @(x,y,z) x.*0+H;
            t = t + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
            %-----------------------------------------------------------------------
            f = @(x,y,z) z.*0 + 1;
            X_min = -X_MAX;
            X_max = X(1);
            Y_min = @(x,y,z) -sqrt((H-A.*x.^2)./B);
            Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
            Z_min = @(x,y,z) A.*x.^2+B.*y.^2 ;
            Z_max = @(x,y,z) x.*0+H;
            t = t + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
            %-----------------------------------------------------------------------
            F = t*1000;
            
            if(abs(M-F)<=0.001)  %满足精度的结果存入结果数组
                % disp(['secondX=',num2str(X)]);
                Ans = c ;
            end
            
            if M > F
                high = c - Accuracy;
            end
            
            if M < F
                low = c + Accuracy;
            end
            
        end
    end
end

