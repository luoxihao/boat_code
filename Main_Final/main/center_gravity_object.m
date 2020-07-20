clear
A = 21;
B = 4;
H =0.12;
center_gravity=[];

Y_MAX = sqrt(H./B);
X_MAX = sqrt(H./A);

Y3 = 0;                     %3号肋骨y的最大值
Y4 = Y_MAX ./ 3;            %4号肋骨y的最大值   
Y5 = Y_MAX.*2 ./ 3;         %5号肋骨y的最大值
Y=[-Y5 -Y4 Y3 Y4 Y5];
Density = 0.1458; 
for m = 0.964-0.848:0.001:0.964
    M = [];
    Z_center_gravity = [];
    Z_center_gravity = rib_Center_Gravity_Z(H , Density ,A ,B ,Y);%求出五块肋骨的重心在z轴的坐标 返回数组

    M = rib_Panel_quality(H , Density ,A ,B ,Y);                  %求出五块肋骨重量 返回数组
    
    Z_center_gravity(end+1) = keel_Center_Gravity(Y_MAX , Density , H,B);            %求出龙骨面板的重心
    
    M(end+1)= keel_Panel_quality(Y_MAX , Density , H,B);                    %求出龙骨面板的质量
    
    %添加桅杆的重心及质量
    Z_center_gravity(end+1) = B.*0.043.^2+0.04+0.25+0.015;
    M(end+1) = 0.106;
    %添加重物的重心及质量
    Z_center_gravity(end+1) =B.*0.043.^2+0.02+0.015;
    M(end+1) = m;
    
    center_gravity(end+1) = boat_Center_Gravity(Z_center_gravity,M);
end
title('重物质量与重心的关系图');
xlabel('重量 kg');
ylabel('重心 m');
hold on
plot( 0.964-0.848:0.001:0.964,center_gravity);
