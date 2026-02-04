% create variables
a = arduino;
press_reg_pin = 'D4';
press_valve_pin = 'D7';
press_pump_pin = 'D8';
vacuum_valve_pin = 'D12';
biteBot = BiteBotArduino(a,press_reg_pin,press_valve_pin,press_pump_pin,vacuum_valve_pin);