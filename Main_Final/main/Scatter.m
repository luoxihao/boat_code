%% ������ӱ���е�����
% ���ڴ����µ��ӱ�������ݵĽű�:
%
%    ������: C:\Users\luoxihao\Desktop\my\�ű�max\Main_Final\main_low\Data_High.xlsx
%    ������: Sheet1
%
% �� MATLAB �� 2020-07-13 11:12:16 �Զ�����

%% ���õ���ѡ���������
opts = spreadsheetImportOptions("NumVariables", 9);

% ָ��������ͷ�Χ
opts.Sheet = "Sheet1";
opts.DataRange = "A2:I1797";

% ָ�������ƺ�����
opts.VariableNames = ["A", "B", "H", "P", "C_weight", "center_gravity", "M", "c", "Moment"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double"];

% ��������
DataHigh = readtable("C:\Users\luoxihao\Desktop\my\�ű�max\Main_Final\Filter\Filter.xlsx", opts, "UseExcel", false);
scatter3(DataHigh.A(:),DataHigh.B(:),DataHigh.H(:),40,DataHigh.Moment(:),'filled');
colorbar;
xlabel('A');
ylabel('B');
zlabel('H');
title('ABH�븴ԭ���صĹ�ϵ')
%% �����ʱ����
clear opts