clear
A = 21;
B = 4;
H =0.12;
center_gravity=[];

Y_MAX = sqrt(H./B);
X_MAX = sqrt(H./A);

Y3 = 0;                     %3���߹�y�����ֵ
Y4 = Y_MAX ./ 3;            %4���߹�y�����ֵ   
Y5 = Y_MAX.*2 ./ 3;         %5���߹�y�����ֵ
Y=[-Y5 -Y4 Y3 Y4 Y5];
Density = 0.1458; 
for m = 0.964-0.848:0.001:0.964
    M = [];
    Z_center_gravity = [];
    Z_center_gravity = rib_Center_Gravity_Z(H , Density ,A ,B ,Y);%�������߹ǵ�������z������� ��������

    M = rib_Panel_quality(H , Density ,A ,B ,Y);                  %�������߹����� ��������
    
    Z_center_gravity(end+1) = keel_Center_Gravity(Y_MAX , Density , H,B);            %���������������
    
    M(end+1)= keel_Panel_quality(Y_MAX , Density , H,B);                    %���������������
    
    %���Φ�˵����ļ�����
    Z_center_gravity(end+1) = B.*0.043.^2+0.04+0.25+0.015;
    M(end+1) = 0.106;
    %�����������ļ�����
    Z_center_gravity(end+1) =B.*0.043.^2+0.02+0.015;
    M(end+1) = m;
    
    center_gravity(end+1) = boat_Center_Gravity(Z_center_gravity,M);
end
title('�������������ĵĹ�ϵͼ');
xlabel('���� kg');
ylabel('���� m');
hold on
plot( 0.964-0.848:0.001:0.964,center_gravity);
