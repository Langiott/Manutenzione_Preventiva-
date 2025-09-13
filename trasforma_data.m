%------------------------------------------------------------------------------------------------------------------
% Trasforma dataset creato dal file refactor_dataset2.m in un formato piu semplice chiamto data 
%------------------------------------------------------------------------------------------------------------------
%                          Operazioni preliminari 
%  
% dataset = removevars(dataset,["ambient_temperature","time"]);
% data = dataset.data;
%------------------------------------------------------------------------------------------------------------------

num_rows = size(data, 1);

% Ciclo per estrarre riga per riga
for i = 1:num_rows
    riga_i = data{i}; % Estrae la riga i-esima come table
    % Puoi fare qualcosa con la riga estratta qui
end

%------------------------------------------------------------------------------------------------------------------
% 
%                                          data{1}
%
% Time     Voltage_measured    Current_measured    Temperature_measured    Current_charge    Voltage_charge
%     ______    ________________    ________________    ____________________    ______________    ______________
% 
%          0          3.873            -0.0012007              24.655                    0            0.003     
%      2.532         3.4794               -4.0303              24.666               -4.036             1.57     
%------------------------------------------------------------------------------------------------------------------
% Estrapola dati utili 
data = data{1};  % for 1


time = data.Time;
voltage = data.Voltage_measured;
current = data.Current_measured;
temperature = data.Temperature_measured;
current2= data.Current_charge;
voltage2 = data.Voltage_charge;

% Crea dataset
voltage_measured = table(time, voltage, 'VariableNames', {'time', 'voltage_measured'});
current_measured = table(time, current, 'VariableNames', {'time', 'current_measured'});
temperature_measured = table(time, temperature, 'VariableNames', {'time', 'temperature_measured'});
current_charge = table(time, current2, 'VariableNames', {'time', 'current_charge'});
voltage_charge = table(time, voltage2, 'VariableNames', {'time', 'voltage_charge'});

% class(dataset)---->TABLE
dataset = table(voltage_measured,current_measured,temperature_measured,current_charge,voltage_charge)
%------------------------------------------------------------------------------------------------------------------
%                                     dataset 
%           
%      voltage_measured              current_measured              temperature_measured              current_charge              voltage_charge     
%  time     voltage_measured     time     current_measured     time     temperature_measured     time     current_charge     time     voltage_charge
% __________________________    __________________________    ______________________________    ________________________    ________________________
% 
%      0          3.873              0       -0.0012007            0           24.655                0             0             0        0.003     
%  2.532         3.4794          2.532          -4.0303        2.532           24.666            2.532        -4.036         2.532         1.57     

%Trasforma table in timetable
voltage_measured = array2timetable(voltage, 'RowTimes', time, 'VariableNames', {'voltage_measured'});
current_measured = array2timetable(current, 'RowTimes', time, 'VariableNames', {'current_measured'});
temperature_measured= array2timetable(temperature, 'RowTimes', time, 'VariableNames', {'temperature_measured'});
current_charge = array2timetable(current2, 'RowTimes', time, 'VariableNames', {'current_charge'});
voltage_charge = array2timetable(voltage2, 'RowTimes', time, 'VariableNames', {'voltage_charge'});
% Sincronizzare le timetable
timetable = synchronize(voltage_measured, current_measured, temperature_measured, current_charge, voltage_charge);
timetable = timetable(:, {'voltage_measured', 'current_measured', 'temperature_measured', 'current_charge', 'voltage_charge'});

%------------------------------------------------------------------------------------------------------------------
% timetable =   789×5 timetable
% 
%        Time       voltage_measured    current_measured    temperature_measured    current_charge    voltage_charge
%     __________    ________________    ________________    ____________________    ______________    ______________
% 
%     0 sec               3.873            -0.0012007              24.655                    0            0.003     
%     2.532 sec          3.4794               -4.0303              24.666               -4.036             1.57     
%     5.5 sec            4.0006                1.5127              24.675                  1.5            4.726     
%     8.344 sec          4.0124                1.5091              24.694                  1.5            4.742     