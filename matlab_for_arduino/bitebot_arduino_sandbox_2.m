%uses bitebot class for everything except LC

%clear workspace
clear;

%% create variables
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

% create LC in sandbox
lc_pins = {char(lc_data_pin), char(lc_clock_pin)};
loadCell = addon(biteBot.arduino_object, 'basicHX711/basic_HX711', lc_pins');

%%
input('Clear load cell then press enter to continue...', 's');
cal = calibration(50, 500);
cal.tare_weight = tare(cal, loadCell);
input('Add 500g mass then press enter to continue...', 's');
cal.scale_factor = scale(cal,loadCell);
cal_weight = get_weight(cal,loadCell);
%disp(["Mass of ", cal_weight, "g detected."]);
input('Remove 500g mass then press enter to continue...', 's');