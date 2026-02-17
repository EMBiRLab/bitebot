classdef BiteBotArduino
    properties
        arduino_object
        latch
        loadcell
        cal
        press_reg_pin
        press_valve_pin
        press_pump_pin
        vacuum_valve_pin
        lc_data_pin
        lc_clock_pin
        latch_pin
    end
    methods
        function obj = BiteBotArduino(press_reg_pin, a, press_valve_pin, ...
                press_pump_pin, vacuum_valve_pin, lc_data_pin, lc_clock_pin, ...
                latch_pin, reference_mass)
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

            % define load cell
            % code is being iffy, so might do this without class method to
            % call loadcell
            lc_pins = {obj.lc_data_pin, obj.lc_clock_pin};
            lc_pins = lc_pins';
            obj.loadcell = addon(obj.arduino_object, 'basicHX711/basic_HX711', lc_pins);

            %calibrate load cell
            input('Clear load cell then press enter to continue...', 's');
            obj.cal = calibration(50, 500);
            obj.cal.tare_weight = tare(obj.cal, obj.loadcell);
            precision = 2; 
            msg = sprintf('Add %%.%dfg mass then press enter to continue...', precision);
            msg_formatted = sprintf(msg, reference_mass);
            input(msg_formatted, 's');
            obj.cal.scale_factor = scale(obj.cal, obj.loadcell);
            cal_weight = get_weight(obj.cal, obj.loadcell);
            scale_error = (cal_weight - reference_mass)./5;
            disp(compose("Mass of %f detected", cal_weight));
            disp(compose("Scale error of %f percent", scale_error));
            input('Remove 500g mass then press enter to continue...', 's');
        end
        function mass = read_lc(obj)
            mass = get_weight(obj.cal, obj.loadcell);
        end
        function blink(obj)
            writeDigitalPin(obj.arduino_object, obj.vacuum_valve_pin, 1);
            pause(3);
            writeDigitalPin(obj.arduino_object, obj.vacuum_valve_pin, 0);
        end
        function release_latch(obj)
            writePosition(obj.latch, 0.0);
        end
        function reset_latch(obj)
            writePosition(obj.latch, 0.5);
        end
        function start_envenomation(obj)
            writeDigitalPin(obj.arduino_object,obj.press_reg_pin,1);
            writeDigitalPin(obj.arduino_object,obj.press_valve_pin,1);
        end
        function end_envenomation(obj)
            writeDigitalPin(obj.arduino_object,obj.press_reg_pin,0);
            writeDigitalPin(obj.arduino_object,obj.press_valve_pin,0);
            writeDigitalPin(obj.arduino_object,obj.vacuum_valve_pin,1);
            pause(1);
            writeDigitalPin(obj.arduino_object,obj.vacuum_valve_pin,0);
        end
        function start_refill(obj)
            writeDigitalPin(obj.arduino_object,obj.press_pump_pin,1);
            writeDigitalPin(obj.arduino_object,obj.vacuum_valve_pin,1);
        end
        function end_refill(obj)
            writeDigitalPin(obj.arduino_object,obj.press_pump_pin,0);
            writeDigitalPin(obj.arduino_object,obj.vacuum_valve_pin,0);
        end
    end
end