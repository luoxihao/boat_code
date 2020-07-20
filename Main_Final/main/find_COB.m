function Ans = find_COB(A,B,H,X_MAX,c,Angle)
%FIND_FLAATING_HEART �˴���ʾ�йش˺�����ժҪ
    K = tan(Angle./180.*pi);                %�����ˮ�߷���

    C=[H+K.*X_MAX H H-K.*X_MAX];         %������봬�ף�xozƽ��ͶӰ�����н��ߵ������Сֵ
    if c>=C(1)
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
        
        v_c = integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        
        % %---------------------------------------------------
        % %ȷ���������� 2
        f = @(x,y,z) z.*0 + 1;
        X_max = X(2);
        X_min = (H-c)./K;  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2;
        Z_max = @(x,y,z) x.*0+H;
        v_c =  v_c+ 2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %---------------------------------------------------

        % %ȷ���������� 3
        f = @(x,y,z) z.*0 + 1;
        X_max = X(2);
        X_min = (H-c)./K;  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) -sqrt((x.*K+c-A.*x.^2)./B);                
        Y_max = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Z_min = @(x,y,z) x.*K+c;
        Z_max = @(x,y,z) x.*0+H;
        v_c = v_c + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);




%��z�������ĵ�z



        f = @(x,y,z) z.*0 + z;
        X_min = X(2);
        X_max = X_MAX ;
        Y_min = @(x,y,z) -sqrt((H-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2 ;
        Z_max = @(x,y,z) x.*0+H;
        
        z_c = integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        
        % %---------------------------------------------------
        % %ȷ���������� 2
        f = @(x,y,z) z.*0 + z;
        X_max = X(2);
        X_min = (H-c)./K;  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2;
        Z_max = @(x,y,z) x.*0+H;
        z_c =  z_c+ 2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %---------------------------------------------------
        % %ȷ���������� 3
        f = @(x,y,z) z.*0 + z;
        X_max = X(2);
        X_min = (H-c)./K;  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) -sqrt((x.*K+c-A.*x.^2)./B);                
        Y_max = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Z_min = @(x,y,z) x.*K+c;
        Z_max = @(x,y,z) x.*0+H;
        z_c = z_c + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);



%��x�������ĵ�x


        f = @(x,y,z) z.*0 + x;
        X_min = X(2);
        X_max = X_MAX ;
        Y_min = @(x,y,z) -sqrt((H-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2 ;
        Z_max = @(x,y,z) x.*0+H;
        
        x_c = integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        
        % %---------------------------------------------------
        % %ȷ���������� 2
        f = @(x,y,z) z.*0 + x;
        X_max = X(2);
        X_min = (H-c)./K;  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2;
        Z_max = @(x,y,z) x.*0+H;
        x_c =  x_c+ 2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %---------------------------------------------------
        % %ȷ���������� 3
        f = @(x,y,z) z.*0 + x;
        X_max = X(2);
        X_min = (H-c)./K;  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) -sqrt((x.*K+c-A.*x.^2)./B);                
        Y_max = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Z_min = @(x,y,z) x.*K+c;
        Z_max = @(x,y,z) x.*0+H;
        x_c = x_c + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);

        Ans =[x_c./v_c 0 z_c./v_c];
    else

%�ڶ��������--------------------------------------------------------------------------------
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
        v_c = integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        
        %-----------------------------------------------------------------------
        %
        f = @(x,y,z) z.*0 + 1;
        X_max = X(2);
        X_min = X(1);  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2;
        Z_max = @(x,y,z) x.*0+H;
        v_c =  v_c+ 2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        
        %-----------------------------------------------------------------------
        %
        f = @(x,y,z) z.*0 + 1;
        X_max = X(2);
        X_min = X(1);  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) -sqrt((x.*K+c-A.*x.^2)./B);                
        Y_max = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Z_min = @(x,y,z) x.*K+c;
        Z_max = @(x,y,z) x.*0+H;
        v_c = v_c + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %-----------------------------------------------------------------------
        f = @(x,y,z) z.*0 + 1;
        X_min = -X_MAX;
        X_max = X(1);
        Y_min = @(x,y,z) -sqrt((H-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2 ;
        Z_max = @(x,y,z) x.*0+H;
        v_c = v_c + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);

%��z�������ĵ�z

        f = @(x,y,z) z.*0 + z;
        X_min = X(2);
        X_max = X_MAX ;
        Y_min = @(x,y,z) -sqrt((H-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2 ;
        Z_max = @(x,y,z) x.*0+H;
        z_c = integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        
        %-----------------------------------------------------------------------
        %
        f = @(x,y,z) z.*0 + z;
        X_max = X(2);
        X_min = X(1);  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2;
        Z_max = @(x,y,z) x.*0+H;
        z_c =  z_c+ 2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        
        %-----------------------------------------------------------------------
        %
        f = @(x,y,z) z.*0 + z;
        X_max = X(2);
        X_min = X(1);  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) -sqrt((x.*K+c-A.*x.^2)./B);                
        Y_max = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Z_min = @(x,y,z) x.*K+c;
        Z_max = @(x,y,z) x.*0+H;
        z_c = z_c + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %-----------------------------------------------------------------------
        f = @(x,y,z) z.*0 + z;
        X_min = -X_MAX;
        X_max = X(1);
        Y_min = @(x,y,z) -sqrt((H-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2 ;
        Z_max = @(x,y,z) x.*0+H;
        z_c =z_c + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);


%��x�������ĵ�x


        f = @(x,y,z) z.*0 + x;
        X_min = X(2);
        X_max = X_MAX ;
        Y_min = @(x,y,z) -sqrt((H-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2 ;
        Z_max = @(x,y,z) x.*0+H;
        x_c = integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);

        %-----------------------------------------------------------------------
        %
        f = @(x,y,z) z.*0 + x;
        X_max = X(2);
        X_min = X(1);  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2;
        Z_max = @(x,y,z) x.*0+H;
        x_c =  x_c+ 2.*integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);

        %-----------------------------------------------------------------------
        %
        f = @(x,y,z) z.*0 + x;
        X_max = X(2);
        X_min = X(1);  %��ˮ�߷�����װ巽����xozƽ��Ľ����x��ֵ
        Y_min = @(x,y,z) -sqrt((x.*K+c-A.*x.^2)./B);                
        Y_max = @(x,y,z) sqrt((x.*K+c-A.*x.^2)./B);
        Z_min = @(x,y,z) x.*K+c;
        Z_max = @(x,y,z) x.*0+H;
        x_c = x_c + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        %-----------------------------------------------------------------------
        f = @(x,y,z) z.*0 + x;
        X_min = -X_MAX;
        X_max = X(1);
        Y_min = @(x,y,z) -sqrt((H-A.*x.^2)./B);
        Y_max = @(x,y,z) sqrt((H-A.*x.^2)./B);
        Z_min = @(x,y,z) A.*x.^2+B.*y.^2 ;
        Z_max = @(x,y,z) x.*0+H;
        x_c =x_c + integral3(f,X_min,X_max,Y_min,Y_max,Z_min,Z_max);
        Ans =[x_c./v_c 0 z_c./v_c];
    end
end

