function Ans = find_135_waterline(A,B,H,X_MAX,M,Angle)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%-----135���ˮ�ߵ�c---------------------------------------------------------------------------------------------

    %����һ������ˮ��


    K = tan(Angle./180.*pi);                %�����ˮ�߷���

    C=[H+K.*X_MAX H H-K.*X_MAX];         %������봬�ף�xozƽ��ͶӰ�����н��ߵ������Сֵ
    
    % disp(C)
    %�Ķ���
    low=C(1);                   %���ò��ҵĵײ�
    Accuracy =  0.000001;               
    high=C(3)-Accuracy;         %���ò��ҵĶ���
    Ans = -10;                  %�������ڴ�Ž��

    while low<=high
        c = (low + high)./2; %�����ǰ���������
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
        % %ȷ���������� 1
        f = @(x,y,z) z.*0 + 1;
        X_min = X(2);
        X_max = X_MAX ;
        Y_min = @(x,y,z) -sqrt((H-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2 ;
        Z_max = @(x,y,z) x.*0+H;
        
        a = integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        
        % %---------------------------------------------------
        % %ȷ���������� 2
        f = @(x,y,z) z.*0 + 1;
        X_max = X(2);
        X_min = (H-c)./K;  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2;
        Z_max = @(x,y,z) x.*0+H;
        a =  a+ 2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %---------------------------------------------------
        % %ȷ���������� 3
        f = @(x,y,z) z.*0 + 1;
        X_max = X(2);
        X_min = (H-c)./K;  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) -sqrt((x.*K+c-A.*x.^2)./B);                
        Y_max = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Z_min = @(x,y,z) x.*K+c;
        Z_max = @(x,y,z) x.*0+H;
        a = a + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        
        %---------------------------------------------------------
        F = a*1000;
        if(abs(M-F)<=0.001)  %���㾫�ȵĽ������������
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

    %����һ��û�����ʱ��ʼ�ڶ������
    if Ans==-10  
        disp('��');
        % �������Ƕ���ˮ��(���2)�����贬����͵㲻��ˮ�� (c�� 0��  0.1513 )
        % �Ķ���
        low=0; 
        Accuracy =  0.000001;%���ò��ҵĵײ�
        high=C(1)-Accuracy; %���ò��ҵĶ���
        Ans = -10;          %�������ڴ�Ž��������


        while low<=high
            
            c = (low + high)./2;%�����ǰ���������
            syms x
            f = A.*x.^2-x.*K-c==0; %���ˮ���봬��xozƽ��Ľ���
            T = double(solve(f));
            X = zeros(1,2,'double');
            for i=1:2
                if isreal(T(i)) 
                X(i) =T(i) ;
                end
            end
            % X = sort(X);
            %�ϰ벿�ֻ���
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
            X_min = X(1);  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
            Y_min = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
            Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
            Z_min = @(x,y,z) A.*x.^2+B.*y.^2;
            Z_max = @(x,y,z) x.*0+H;
            t =  t+ 2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
            
            %-----------------------------------------------------------------------
            %
            f = @(x,y,z) z.*0 + 1;
            X_max = X(2);
            X_min = X(1);  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
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
            
            if(abs(M-F)<=0.001)  %���㾫�ȵĽ������������
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

