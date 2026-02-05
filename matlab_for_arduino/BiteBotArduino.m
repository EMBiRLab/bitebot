classdef BiteBotArduino
    properties
        arduino_object
        latch
        loadcell
        press_reg_pin
        press_valve_pin
        press_pump_pin
        vacuum_valve_pin
        lc_data_pin
        lc_clock_pin
        latch_pin
    end
    
    methods
        function obj = BiteBotArduino(a, press_reg_pin, press_valve_pin, ...
                press_pump_pin, vacuum_valve_pin, lc_data_pin, lc_clock_pin, ...
                latch_pin)
            % Set Object Parameters
            obj.arduino_object = a;
            obj.press_reg_pin = press_reg_pin;
            obj.press_valve_pin = press_valve_pin;
            obj.press_pump_pin = press_pump_pin;
            obj.vacuum_valve_pin = vacuum_valve_pin;
            obj.lc_data_pin = lc_data_pin;
            obj.lc_clock_pin = lc_clock_pin;
            obj.latch_pin = latch_pin;

            % Configure inputs and outputs
            configurePin(obj.arduino_object, obj.press_reg_pin, "DigitalOutput");
            configurePin(obj.arduino_object, obj.press_valve_pin, "DigitalOutput");
            configurePin(obj.arduino_object, obj.press_pump_pin, "DigitalOutput");
            configurePin(obj.arduino_object, obj.vacuum_valve_pin, "DigitalOutput");
            obj.latch = servo(obj.arduino_object, obj.latch_pin);
            obj.loadcell = addon(obj.arduino_object, 'basicHX711/basic_HX711', ...
                {'D3', 'D2'});
        end
        function blink(obj)
            writeDigitalPin(obj.arduino_object, obj.vacuum_valve_pin, 1);
            pause(3);
            writeDigitalPin(obj.arduino_object, obj.vacuum_valve_pin, 0);
        end
    end
end