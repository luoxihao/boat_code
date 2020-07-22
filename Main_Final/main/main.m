%% 求重心 遍历求解A B H 的值 Z = Ax^2+ By^2
%% 初始化
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
%%  计算数据初始化
            Y_MAX = sqrt(H./B);
            X_MAX = sqrt(H./A);

            Y3 = 0;                            %3号肋骨y的最大值
            Y4 = Y_MAX ./ 3;                    %4号肋骨y的最大值   
            Y5 = Y_MAX.*2 ./ 3;                  %5号肋骨y的最大值
            Y=[-Y5 -Y4 Y3 Y4 Y5];

%%  求出五块肋骨的重心在z轴的坐标 返回数组            
            Z_center_gravity = rib_Center_Gravity_Z(H , Density ,A ,B ,Y);

%%  求出五块肋骨重量 返回数组
            M = rib_Panel_quality(H , Density ,A ,B ,Y);                 

%%  求出龙骨面板的重心            
            Z_center_gravity(end+1) = keel_Center_Gravity(Y_MAX , Density , H,B);          

%%  求出龙骨面板的质量            
            M(end+1)= keel_Panel_quality(Y_MAX , Density , H,B);                    
            
%%  添加桅杆的重心及质量
            Z_center_gravity(end+1) = B.*0.043.^2+0.04+0.25+0.015;
            M(end+1) = 0.106;

%%  添加重物的重心及质量
            Z_center_gravity(end+1) =B.*0.043.^2+0.02+0.015;
            M(end+1) = 0.8481;
            
            center_gravity = boat_Center_Gravity(Z_center_gravity,M);
            M = sum(M);

            if center_gravity>H-0.02      
                disp('跳重心');                                           %重心太高的情况删去
                continue;
            end
%% 求出水平吃水线
            p = find_waterline(A,B,H,M);

%%  求135度时的吃水线
            c = find_135_waterline(A,B,H,X_MAX,M,135);

%%  135吃水线
            if c==-10        %如果没求出吃水线的c就循环下一次
                disp('跳135吃水线');
                continue;
            end

%%  求浮心
            COB = find_COB(A,B,H,X_MAX,c,135);

%%  重心
            COM = [0 0 center_gravity];

%%  复原力矩
            P = -135./180.*pi;
            g = 9.8;
            F = [2.*g.*M.*sin(P) 0 2.*g.*M.*cos(P)];                            %力部分初始化
            Moment = cross(COB - COM,F);
            Moment = norm(Moment);


%%  满足条件的情况存入数组
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
                disp(['重心 = ',num2str(center_gravity)]);
                disp(['船体质量 = ',num2str(sum(M))]);
                disp(['c = ',num2str(c),'  A = ',num2str(A),'   B = ',num2str(B)]);
                disp(['浮心 = ',num2str(COB)]);
                count=count+1;
%%
            end
        end 
    end 
end
%% 结果存入excel
Varname= {'A','B','H','P','C_weight','center_gravity','M','c','Moment'};
T = table(boat.A',boat.B',boat.H',boat.p',boat.c_weight',boat.center_gravity',boat.M',boat.c',boat.Moment','VariableNames',Varname);
writetable(T,'Data1.xlsx');
type 'Data1.xlsx'

