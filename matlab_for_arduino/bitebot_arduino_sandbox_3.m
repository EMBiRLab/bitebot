%uses bitebot class for everything

%clear workspace
clear;
clc;

%% create variables
a = arduino;
press_reg_pin = 'D4';
press_valve_pin = 'D7';
press_pump_pin = 'D8';
vacuum_valve_pin = 'D12';
lc_data_pin = "D3";
lc_clock_pin = "D2";
latch_pin = "A0";
reference_mass = 500; %gram
biteBot = BiteBotArduino(a, press_reg_pin, press_valve_pin, ...
    press_pump_pin, vacuum_valve_pin, lc_data_pin, lc_clock_pin, ...
    latch_pin, reference_mass);
biteBot.blink();

%% Loop

while(true)
    % Read load cell data
    loadCellData = biteBot.read_lc();

    % Display load cell data
    disp(loadCellData);
end