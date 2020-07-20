%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: C:\Users\luoxihao\Desktop\my\脚本max\Main_Final\main_low\Data_High.xlsx
%    工作表: Sheet1
%
% 由 MATLAB 于 2020-07-13 11:12:16 自动生成

%% 设置导入选项并导入数据
opts = spreadsheetImportOptions("NumVariables", 9);

% 指定工作表和范围
opts.Sheet = "Sheet1";
opts.DataRange = "A2:I1797";

% 指定列名称和类型
opts.VariableNames = ["A", "B", "H", "P", "C_weight", "center_gravity", "M", "c", "Moment"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double"];

% 导入数据
DataHigh = readtable("C:\Users\luoxihao\Desktop\my\脚本max\Main_Final\Filter\Filter.xlsx", opts, "UseExcel", false);
scatter3(DataHigh.A(:),DataHigh.B(:),DataHigh.H(:),40,DataHigh.Moment(:),'filled');
colorbar;
xlabel('A');
ylabel('B');
zlabel('H');
title('ABH与复原力矩的关系')
%% 清除临时变量
clear opts