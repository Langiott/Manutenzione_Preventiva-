%% Caricamento del dataset 
load('B0005.mat'); 

%% Calcolo numero cicli 

numCicli = numel(B0005.cycle);

%% Inizializzazione delle strutture 

% Inizializzazione della tabella finale per i dati 

dataset = table([],[],[],[],'VariableNames',{'type','ambient_temperature','time','data'});

%% Estrazione dei dati 

%Estrazione dei dati dalla struttura originale per il popolamento della
%tabella dichiarata precedentemente 

for i = 1: numCicli
    cycleType = B0005.cycle(i).type;
    cycleData = B0005.cycle(i).data;
    cycleTime = B0005.cycle(i).time; 
    cycleAmbient = B0005.cycle(i).ambient_temperature;

%% Divisione dei dati per tipologia di ciclo e popolamento delle strutture corrispondenti 

    switch cycleType
        case 'charge'
            % Inizializzazione dell'array di strutture per i dati di questo ciclo
            dataStructArray = struct('Time', {}, 'Voltage_measured', {}, 'Current_measured', {}, ...
                                     'Temperature_measured', {}, 'Current_charge', {}, 'Voltage_charge', {});
            % Popolamento l'array di strutture
            for j = 1:length(cycleData.Time)
                dataStructArray(j).Time = cycleData.Time(j);
                dataStructArray(j).Voltage_measured = cycleData.Voltage_measured(j);
                dataStructArray(j).Current_measured = cycleData.Current_measured(j);
                dataStructArray(j).Temperature_measured = cycleData.Temperature_measured(j);
                dataStructArray(j).Current_charge = cycleData.Current_charge(j);
                dataStructArray(j).Voltage_charge = cycleData.Voltage_charge(j);
            end
            % Conversione di dataStructArray in una tabella
            dataTable = struct2table(dataStructArray);

            % Creazione di una nuova riga per il dataset
            newRow = {cycleType, cycleAmbient, datetime(cycleTime, 'Format', 'yyyy-MM-dd HH:mm:ss'), dataTable};
            dataset = [dataset; newRow];
            

        case 'discharge'
             % Inizializza l'array di strutture per i dati di questo ciclo
             dataStructArray = struct('Time', {},'Capacity', {}, 'Voltage_measured', {}, 'Current_measured', {}, ...
                                 'Temperature_measured', {}, 'Current_load', {}, 'Voltage_load', {});
        
            % Popolamento l'array di strutture
            for j = 1:length(cycleData.Time)
                %Inserimento dei dati nella struttura 
                dataStructArray(j).Time = cycleData.Time(j); 
                dataStructArray(j).Capacity = cycleData.Capacity; 
                dataStructArray(j).Voltage_measured = cycleData.Voltage_measured(j);  
                dataStructArray(j).Current_measured = cycleData.Current_measured(j); 
                dataStructArray(j).Temperature_measured = cycleData.Temperature_measured(j); 
                dataStructArray(j).Current_load = cycleData.Current_load(j); 
                dataStructArray(j).Voltage_load = cycleData.Voltage_load(j); 
            end
            
            % Conversione di dataStructArray in una tabella
            dataTable = struct2table(dataStructArray);

            % Creazione di una nuova riga per il dataset
            newRow = {cycleType, cycleAmbient, datetime(cycleTime, 'Format', 'yyyy-MM-dd HH:mm:ss'), dataTable};
            dataset = [dataset; newRow];

        case 'impedance'
            % Inizializza l'array di strutture per i dati di questo ciclo
            dataStructArray = struct('Sense_current', {},'Battery_current', {}, 'Current_ratio', {}, 'Battery_impedance', {}, ...
                                 'Rectified_impedance', {}, 'Re', {}, 'Rct', {});
        
            % Popolamento l'array di strutture
            for j = 1:length(cycleData.Sense_current)
                %Inserimento dei dati nella struttura 
                dataStructArray(j).Sense_current = cycleData.Sense_current(j);
                dataStructArray(j).Battery_current = cycleData.Battery_current(j); 
                dataStructArray(j).Current_ratio = cycleData.Current_ratio(j); 
                dataStructArray(j).Battery_impedance = cycleData.Battery_impedance(j); 
                % Normalizzazione dimensione dei vari vettori 
                if j > length(cycleData.Rectified_Impedance)
                    dataStructArray(j).Rectified_impedance = NaN;
                else
                    dataStructArray(j).Rectified_impedance = cycleData.Rectified_Impedance(j);
                end
                dataStructArray(j).Re = cycleData.Re; 
                dataStructArray(j).Rct= cycleData.Rct; 
            end
            
            % Conversione di dataStructArray in una tabella
            dataTable = struct2table(dataStructArray);

            % Creazione di una nuova riga per il dataset
            newRow = {cycleType, cycleAmbient, datetime(cycleTime, 'Format', 'yyyy-MM-dd HH:mm:ss'), dataTable};
            dataset = [dataset; newRow];
   end
end
%% Salvataggio dei dati estratti in un file .mat

save('dataset.mat', "dataset");




