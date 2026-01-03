clear;
bitebot_path = 'C:\Users\ciepm\OneDrive\Documents\Github\bitebot';
addpath(genpath(bitebot_path));
a = arduino; %only valid when arduinosetup is used
%a = arduino("COM5", "Uno", Libraries = ["I2C","SPI","Servo"])
methods(a);
%% Configure Arduino Pins
% Configure specified Arduino pins and protocol interfaces.

%set pins
lc_data_pin = "D3";
lc_clock_pin = "D2";
latch_pin = "A0";
pressure_regulator_pin = "D4";
pressure_valve_pin = "D7";
peristaltic_pump_pin = "D8";
vacuum_valve_pin = "D12";

% set outputs
latch = servo(a, latch_pin);
LoadCell = addon(a, 'basicHX711/basic_HX711',{'D3','D2'});
configurePin(a, pressure_regulator_pin, "DigitalOutput");
configurePin(a, pressure_valve_pin, "DigitalOutput");
configurePin(a, peristaltic_pump_pin, "DigitalOutput");
configurePin(a, vacuum_valve_pin, "DigitalOutput");

while true
    current_char = input('Enter a character: ', 's');
    if(current_char == 'p')
        writeDigitalPin(a,pressure_regulator_pin,1);
        writeDigitalPin(a,pressure_valve_pin,1);
        
        pause(0.5);
        
        writeDigitalPin(a,pressure_regulator_pin,0);
        writeDigitalPin(a,pressure_valve_pin,0);
    elseif(current_char == 'v')
        writeDigitalPin(a,peristaltic_pump_pin,1);
        writeDigitalPin(a,vacuum_valve_pin,1);
        
        pause(3);
        
        writeDigitalPin(a,peristaltic_pump_pin,0);
        writeDigitalPin(a,vacuum_valve_pin,0);
    end
end