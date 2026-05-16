function [filepath, confirmation_array, cal_domain, strict_cal_domain, zero_domain, golay_framelen, static_domain] = import_resense_data(combination)
    filepath = "";
    confirmation_array = [];
    cal_domain = [];
    strict_cal_domain = [];
    zero_domain = [];
    static_domain = [];
    golay_framelen = []; % Initialize golay_framelen for cases without specific values
    switch combination
        case 'S12_Y1_R0_T0'
            confirmation_array = [2 3 5 7 8]; % for test data
            filepath = 'load_cell_test_data.csv';
            cal_domain = 1:100;
    
        % Rung 1
    
        case 'S12_Y0_R1_T1'
            confirmation_array = []; %n1 trial 1
            filepath = 'static_rung1_trial1.csv';
            cal_domain = 35e3:44e3;
            strict_cal_domain = 36e3:41.5e3;
            zero_domain = 1:4e3;

        case 'S21_Y0_R1_T1'
            confirmation_array = [];
            filepath = 'hex21_data/h21_static_n1_t1.csv';
            cal_domain = 1e3:11e3;
            strict_cal_domain = 4e3:7e3;
            static_domain = 14e3:16e3;
    
        case 'S12_Y1_R1_T1'
            confirmation_array = [1:7 9:12]; %n1 trial 1
            filepath = 'manual_n1_trial1.csv';
            cal_domain = 1:10000;
            strict_cal_domain = 6e3:8.5e3;
            
    
        case 'S12_Y1_R1_T2'
            confirmation_array = [1 2 4:11]; %n1 trial 1
            filepath = 'manual_rung1_trial2.csv';
            cal_domain = 1:10e3;
            strict_cal_domain = 5e3:7e3;
            zero_domain = 1:1e3;

        case 'S21_Y1_R1_T1'
            confirmation_array = 1:10;
            filepath = 'h21_manual_n1_t1.csv';
            cal_domain = 1:8e3;
            strict_cal_domain = 4e3:5.5e3;
            golay_framelen = 95;
    
        % Rung 2
    
        case 'S12_Y0_R2_T1'
            confirmation_array = []; %n1 trial 1
            filepath = 'static_rung2_trial1.csv';
            cal_domain = 1:20e3;
            strict_cal_domain = 10e3:15e3;
    
        case 'S12_Y0_R2_T2'
            confirmation_array = []; %n1 trial 1
            filepath = 'static_rung2_trial2.csv';
            cal_domain = 1:10e3;
            strict_cal_domain = 5e3:8e3;
    
        case 'S12_Y0_R2_T3'
            confirmation_array = []; %n1 trial 1
            filepath = 'static_rung2_trial3.csv';
            cal_domain = 1:10e3;
            strict_cal_domain = 5e3:7.5e3;

        case 'S21_Y0_R2_T1'
            confirmation_array = [];
            filepath = 'hex21_data/h21_static_n2_t1.csv';
            cal_domain = 1e3:11e3;
            strict_cal_domain = 4e3:7e3;
            static_domain = 16e3:18e3;
            
        case 'S12_Y1_R2_T1'
            confirmation_array = 1; % for n2 trial 1
            filepath = 'manual_n2_trial1.csv';
            cal_domain = 2000:12000;
            
        case 'S12_Y1_R2_T2'
            confirmation_array = [2 3 4 5]; % for n2 trial 2
            filepath = 'manual_n2_trial2.csv';
            cal_domain = 2000:8000;
            strict_cal_domain = 4e3:7e3;
        
        case 'S12_Y1_R2_T3'
            confirmation_array = 1:10; % for n2 trial 3
            filepath = 'manual_n2_trial3.csv';
            cal_domain = 2000:12000;
    
        case 'S12_Y1_R2_T4'
            confirmation_array = 1:10; % for n2 trial 2
            filepath = 'manual_rung2_trial4.csv';
            cal_domain = 1:10e3;
            strict_cal_domain = 6e3:8e3;
            zero_domain = 1:1e3;

        case 'S21_Y1_R2_T1'
            confirmation_array = 1:11;
            filepath = 'hex21_data/h21_manual_n2_t1.csv';
            cal_domain = 3e3:8e3;
            strict_cal_domain = 5e3:6.5e3;
            zero_domain = 8e3:10e3;
            golay_framelen = 85;
    
        % Rung 3
    
        case 'S12_Y0_R3_T1'
            confirmation_array = []; %n1 trial 1
            filepath = 'static_rung3_trial1.csv';
            cal_domain = 1:12e3;
            strict_cal_domain = 5e3:7.5e3;

        case 'S21_Y0_R3_T1'
            confirmation_array = [];
            filepath = 'hex21_data/h21_static_n3_t1.csv';
            cal_domain = 4e3:11e3;
            strict_cal_domain = 6e3:8e3;
            static_domain = 19e3:22e3;
    
        case 'S12_Y1_R3_T1'
            confirmation_array = 6; % for n3 trial 1
            filepath = 'manual_n3_trial1.csv';
            cal_domain = 2000:12000;
    
        case 'S12_Y1_R3_T2'
            confirmation_array = [1 2 3 4 5 6 7 8 9]; % for n3 trial 2
            filepath = 'manual_n3_trial2.csv';
            cal_domain = 2000:12000;
    
        case 'S12_Y1_R3_T3'
            confirmation_array = [1 2 3 4 5 6 7 8]; % for n3 trial 3
            filepath = 'manual_n3_trial3.csv';
            cal_domain = 4000:13000;
    
        case 'S12_Y1_R3_T4'
            confirmation_array = 1:9; % for n3 trial 4
            filepath = 'manual_n3_trial4.csv';
            cal_domain = 2000:12000;
            strict_cal_domain = 5e3:7e3;
            golay_framelen = 51;

        case 'S21_Y1_R3_T1'
            confirmation_array = 1:10;
            filepath = 'hex21_data/h21_manual_n3_t1.csv';
            cal_domain = 100e3:110e3;
            strict_cal_domain = 103e3:105e3;

        case 'S21_Y1_R3_T2'
            confirmation_array = [];
            filepath = 'hex21_data/h21_manual_n3_t2.csv';
            cal_domain = 1e3:10e3;
            strict_cal_domain = 53e3:9e3;

        case 'S21_Y1_R3_T3'
            confirmation_array = 1:10;
            filepath = 'hex21_data/h21_manual_n3_t3.csv';
            cal_domain = 4e3:11e3;
            strict_cal_domain = 6e3:9e3;
            zero_domain = 11e3:14e3;

        case 'S21_Y1_R3_T4'
            confirmation_array = 1:10;
            filepath = 'hex21_data/h21_manual_n3_t4.csv';
            cal_domain = 4e3:11e3;
            strict_cal_domain = 6e3:9e3;
            zero_domain = 10e3:12e3;
            golay_framelen = 91;
            
        otherwise
            fprintf('Combination %s not recognized.\n', combination);
    end
end