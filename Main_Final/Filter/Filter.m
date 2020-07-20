%% ������ӱ���е�����
% ���ڴ����µ��ӱ�������ݵĽű�:
%
%    ������: C:\Users\luoxihao\Desktop\my\�ű�max\Main_Final\main_low\Data_High.xlsx
%    ������: Sheet1
%
% �� MATLAB �� 2020-07-10 16:53:21 �Զ�����

%% ���õ���ѡ���������
clear
clc

opts = spreadsheetImportOptions("NumVariables", 9);

% ָ��������ͷ�Χ
opts.Sheet = "Sheet1";
opts.DataRange = "A2:I3273";

% ָ�������ƺ�����
opts.VariableNames = ["A", "B", "H", "P", "C_weight", "center_gravity", "M", "c", "Moment"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double"];

% ��������
DataHigh = readtable("C:\Users\luoxihao\Desktop\my\�ű�max\Main_Final\main_low\Data_High.xlsx", opts, "UseExcel", false);

boat.A = zeros(1,300,'double');
boat.B = zeros(1,300,'double') ;
boat.H = zeros(1,300,'double');
boat.M = zeros(1,300,'double');
boat.c = zeros(1,300,'double');
boat.Moment = zeros(1,300,'double');
boat.center_gravity = zeros(1,300,'double');
boat.c_weight = zeros(1,300,'double');
boat.p = zeros(1,300,'double');
count =1;

Size = size(DataHigh.A);
for i =1:Size(1)
    % if sqrt(DataHigh.A(i)/DataHigh.B(i)) > 2.7 && sqrt(DataHigh.A(i)/DataHigh.B(i)) < 3%�����
        % if DataHigh.center_gravity(i) <= DataHigh.H(i)/2
        if DataHigh.center_gravity(i)<DataHigh.P(i)
            if sqrt(DataHigh.H(i)./DataHigh.B(i)) <=0.24
                % disp([num2str(sqrt(DataHigh.A(i)/DataHigh.B(i))),'  ',num2str(i),'    ',num2str(DataHigh.A(i)),'    ',num2str(DataHigh.B(i)),'   ',num2str(count)]);
                disp(sqrt(DataHigh.H(i)/DataHigh.B(i)));
                boat.A(count) = DataHigh.A(i);
                boat.B(count) = DataHigh.B(i);
                boat.H(count) = DataHigh.H(i);
                boat.p(count) = DataHigh.P(i);
                boat.c_weight(count) = DataHigh.C_weight(i);
                boat.center_gravity(count) = DataHigh.center_gravity(i);
                boat.M(count) = DataHigh.M(i);
                boat.c(count) =DataHigh.c(i);
                boat.Moment(count)=DataHigh.Moment(i);
                count = count+1;

            end
        % end
        end
    % end
end

Varname= {'A','B','H','P','C_weight','center_gravity','M','c','Moment'};
T = table(boat.A',boat.B',boat.H',boat.p',boat.c_weight',boat.center_gravity',boat.M',boat.c',boat.Moment','VariableNames',Varname);


writetable(T,'Filter.xlsx');
type 'Filter.xlsx'
%---------------------------------------------------------------------------------------------------
disp(boat);
%% �����ʱ����
clear opts