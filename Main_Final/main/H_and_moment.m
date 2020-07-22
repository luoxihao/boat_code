B=4;
A=21;
Density = 0.1458; 
Ans_Moment=[];
for H = 0.01:0.01:1
    disp(H);
    Y_MAX = sqrt(H./B);
    X_MAX = sqrt(H./A);

    Y3 = 0;                     %3号肋骨y的最大值
    Y4 = Y_MAX ./ 3;            %4号肋骨y的最大值   
    Y5 = Y_MAX.*2 ./ 3;         %5号肋骨y的最大值
    Y=[-Y5 -Y4 Y3 Y4 Y5];

  %     Z_center_gravity = rib_Center_Gravity_Z(H , Density ,A ,B ,Y);%求出五块肋骨的重心在z轴的坐标 返回数组

%     M = rib_Panel_quality(H , Density ,A ,B ,Y);                  %求出五块肋骨重量 返回数组

%     Z_center_gravity(end+1) = keel_Center_Gravity(Y_MAX , Density , H,B);            %求出龙骨面板的重心

%     M(end+1)= keel_Panel_quality(Y_MAX , Density , H,B);                    %求出龙骨面板的质量

    %添加桅杆的重心及质量
%     Z_center_gravity(end+1) = B.*0.043.^2+0.04+0.25+0.015;
%     M(end+1) = 0.106;
    %添加重物的重心及质量
%     Z_center_gravity(end+1) =B.*0.043.^2+0.02+0.015;
%     M(end+1) = 0.8481;
       M = 1.1505;

    
%     center_gravity = boat_Center_Gravity(Z_center_gravity,M);
center_gravity = 0.074360582;
    M = sum(M);



    % %-----135求吃水线的c---------------------------------------------------------------------------------------------
    c = find_135_waterline(A,B,H,X_MAX,M,135);
    %%-------135吃水线---end----------------------------------------------------------------------------------------

    %------浮心------------------------------------------------------------------------------------------------------------------
                COB = find_COB(A,B,H,X_MAX,c,135);
    %------重心----------------------------------------------------------------------------------------------------------------------
                COM = [0 0 center_gravity];
    %-------复原力矩---------------------------------------------------------------------------------------------------------------------
                P = -135./180.*pi;
                g = 9.8;
                F = [g.*M.*cos(P) 0 g.*M.*sin(P)];                            %力部分初始化
                Moment = cross(COB - COM,F);
                Ans_Moment(end+1) = Moment(2);
end

title('H与复原力矩的关系图');
xlabel('H');
ylabel('复原力矩');
hold on
grid on
plot(0.01:0.01:1,Ans_Moment);