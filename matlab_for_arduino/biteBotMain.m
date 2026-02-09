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
envenomation_time = 1;
latch_time = 10;
vacuum_time = 1;
reference_mass = 500; %gram
biteBot = BiteBotArduino(press_reg_pin, a, press_valve_pin, ...
    press_pump_pin, vacuum_valve_pin, lc_data_pin, lc_clock_pin, ...
    latch_pin, reference_mass);
biteBot.blink();

%% Setup Graph

mass_plot = figure('WindowStyle', 'normal');
h = animatedline('LineWidth', 2);
xlabel("Time (s)");
ylabel("Weight (g)");
title("Real-Time Load Cell Reading (HX711)");

% Initialize the character to something empty
set(mass_plot, 'CurrentCharacter', char(0));

startTime = datetime('now');

%% Loop

while(true)
    % Update graph
    current_weight = biteBot.read_lc();
    addpoints(h, t, current_weight);
    
    % Use drawnow to flush the graphics and capture the keypress
    drawnow limitrate;

    % Check for the character input
    current_char = get(mass_plot, 'CurrentCharacter');
    if current_char == 'q'
        break;
    end

    % Do work with char
    if ~isempty(current_char) && current_char ~= char(0)
        action_char = current_char;
        action_start_time = bitebot_input_selector(obj,mass_plot,current_char);
    end

    % Check if action time has concluded
    if ~isnan(action_start_time)
        reset_action = bitebot_conclude_action(obj, ...
            action_char, envenomation_time, ...
            latch_time, vacuum_time);
        if reset_action
            action_start_time = NaN;
            reset_action = False;
        end
    end
    
end