%clear workspace
clear;

% create variables
a = arduino;
press_reg_pin = 'D4';
press_valve_pin = 'D7';
press_pump_pin = 'D8';
vacuum_valve_pin = 'D12';
lc_data_pin = "D3";
lc_clock_pin = "D2";
latch_pin = "A0";
biteBot = BiteBotArduino(a, press_reg_pin, press_valve_pin, ...
    press_pump_pin, vacuum_valve_pin, lc_data_pin, lc_clock_pin, ...
    latch_pin);
biteBot.blink();