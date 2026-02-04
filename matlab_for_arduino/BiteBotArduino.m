classdef BiteBotArduino
    properties
        arduino_object
        press_reg_pin
        press_valve_pin
        press_pump_pin
        vacuum_valve_pin
    end
    
    methods
        function obj = BiteBotArduino(a,press_reg_pin,press_valve_pin,press_pump_pin,vacuum_valve_pin)
            obj.arduino_object = a;
            obj.press_reg_pin = press_reg_pin;
            obj.press_valve_pin = press_valve_pin;
            obj.press_pump_pin = press_pump_pin;
            obj.vacuum_valve_pin = vacuum_valve_pin;

        end
        function activate(obj)
            configurePin(obj.arduino_object, obj.blink_pin, "DigitalOutput");
            writeDigitalPin(obj.arduino_object, obj.blink_pin, 1);
            pause(3);
            writeDigitalPin(obj.arduino_object, obj.blink_pin, 0);
        end
    end
end