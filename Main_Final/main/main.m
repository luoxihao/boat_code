%% ������ �������A B H ��ֵ Z = Ax^2+ By^2
%% ��ʼ��
clear
clc
boat.A = zeros(1,2000,'double');
boat.B = zeros(1,2000,'double') ;
boat.H = zeros(1,2000,'double');
boat.M = zeros(1,2000,'double');
boat.c = zeros(1,2000,'double');
boat.Moment = zeros(1,2000,'double');
boat.center_gravity = zeros(1,2000,'double');
boat.c_weight = zeros(1,2000,'double');
boat.p = zeros(1,2000,'double');

count =1;

Density = 0.1458; 
for H= 0.14:0.14
    for A = 5:0.5:33
        for B = 1:0.5:7
            if A <= B
                continue;
            end
%%  �������ݳ�ʼ��
            Y_MAX = sqrt(H./B);
            X_MAX = sqrt(H./A);

            Y3 = 0;                            %3���߹�y�����ֵ
            Y4 = Y_MAX ./ 3;                    %4���߹�y�����ֵ   
            Y5 = Y_MAX.*2 ./ 3;                  %5���߹�y�����ֵ
            Y=[-Y5 -Y4 Y3 Y4 Y5];

%%  �������߹ǵ�������z������� ��������            
            Z_center_gravity = rib_Center_Gravity_Z(H , Density ,A ,B ,Y);

%%  �������߹����� ��������
            M = rib_Panel_quality(H , Density ,A ,B ,Y);                 

%%  ���������������            
            Z_center_gravity(end+1) = keel_Center_Gravity(Y_MAX , Density , H,B);          

%%  ���������������            
            M(end+1)= keel_Panel_quality(Y_MAX , Density , H,B);                    
            
%%  ���Φ�˵����ļ�����
            Z_center_gravity(end+1) = B.*0.043.^2+0.04+0.25+0.015;
            M(end+1) = 0.106;

%%  �����������ļ�����
            Z_center_gravity(end+1) =B.*0.043.^2+0.02+0.015;
            M(end+1) = 0.8481;
            
            center_gravity = boat_Center_Gravity(Z_center_gravity,M);
            M = sum(M);

            if center_gravity>H-0.02      
                disp('������');                                           %����̫�ߵ����ɾȥ
                continue;
            end
%% ���ˮƽ��ˮ��
            p = find_waterline(A,B,H,M);

%%  ��135��ʱ�ĳ�ˮ��
            c = find_135_waterline(A,B,H,X_MAX,M,135);

%%  135��ˮ��
            if c==-10        %���û�����ˮ�ߵ�c��ѭ����һ��
                disp('��135��ˮ��');
                continue;
            end

%%  ����
            COB = find_COB(A,B,H,X_MAX,c,135);

%%  ����
            COM = [0 0 center_gravity];

%%  ��ԭ����
            P = -135./180.*pi;
            g = 9.8;
            F = [2.*g.*M.*sin(P) 0 2.*g.*M.*cos(P)];                            %�����ֳ�ʼ��
            Moment = cross(COB - COM,F);
            Moment = norm(Moment);


%%  ���������������������
            if abs(norm(Moment))<0.01
                boat.A(count) = A;
                boat.B(count) = B ;
                boat.H(count) = H;
                boat.M(count) = M;
                boat.c(count) =c;
                boat.Moment(count)=norm(Moment);
                boat.center_gravity(count) = center_gravity;
                boat.c_weight(count) = B.*0.043.^2+0.02+0.015;
                boat.p(count) = p;
                disp(['���� = ',num2str(center_gravity)]);
                disp(['�������� = ',num2str(sum(M))]);
                disp(['c = ',num2str(c),'  A = ',num2str(A),'   B = ',num2str(B)]);
                disp(['���� = ',num2str(COB)]);
                count=count+1;
%%
            end
        end 
    end 
end
%% �������excel
Varname= {'A','B','H','P','C_weight','center_gravity','M','c','Moment'};
T = table(boat.A',boat.B',boat.H',boat.p',boat.c_weight',boat.center_gravity',boat.M',boat.c',boat.Moment','VariableNames',Varname);
writetable(T,'Data1.xlsx');
type 'Data1.xlsx'

