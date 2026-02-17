%uses bitebot class for everything

%clear workspace
close;
clear;
clc;

%% Create Variables

%add path
addpath('C:\Users\ciepm\OneDrive\Documents\Github\bitebot\HX711_v3.0\HX711_v3.0')

%query user for testing epithet
epithet = input('Enter brief testing description: ', 's');

%create data loggers
data_time = zeros(10000, 1);
data_mass = zeros(10000, 1);
data_action_char = strings(10000, 1);

% Create Arduino object and initialize BiteBot
a = arduino;
press_reg_pin = 'D4';
press_valve_pin = 'D7';
press_pump_pin = 'D8';
vacuum_valve_pin = 'D12';
lc_data_pin = "D3";
lc_clock_pin = "D2";
latch_pin = "A0";
envenomation_time = 1;
latch_time = 5;
vacuum_time = 2.5;
reference_mass = 500; %gram
biteBot = BiteBotArduino(press_reg_pin, a, press_valve_pin, ...
    press_pump_pin, vacuum_valve_pin, lc_data_pin, lc_clock_pin, ...
    latch_pin, reference_mass);
%biteBot.blink();

%% Setup Graph

mass_plot = figure('WindowStyle', 'normal');
h = animatedline('LineWidth', 2);
xlabel("Time (s)");
ylabel("Weight (g)");
title("Real-Time Load Cell Reading (HX711)");
set(mass_plot, 'CurrentCharacter', char(0));

% Initialize the character to something empty
set(mass_plot, 'CurrentCharacter', char(0));

%initialize loop variables
start_time = datetime('now');
action_start_time = NaT;
action_char = NaN;

%% Loop
i = 0;

while(true)
    i = i+1;
    % Update graph
    current_weight = i;
    %current_weight = biteBot.read_lc();
    dt = seconds(datetime('now') - start_time);
    addpoints(h, dt, current_weight);
    
    % Use drawnow to flush the graphics and capture the keypress
    drawnow limitrate;

    % Check for the character input
    current_char = get(mass_plot, 'CurrentCharacter');
    if current_char == 'q'
        %print("End of Test");
        break;
    end

    % Do work with char
    if ~isempty(current_char) && current_char ~= char(0)
        action_char = current_char;
        action_start_time = bitebot_input_selector(biteBot,current_char);
        % CRITICAL: Clear the character so it doesn't trigger again
        set(mass_plot, 'CurrentCharacter', char(0));
    end

    %add data to logger
    data_time(i) = dt;
    data_mass(i) = current_weight;
    if ~isempty(current_char)
        data_action_char(i) = "NA";
    else
        data_action_char(i) = string(char(action_char));
    end

    % Check if action time has concluded
    if ~isnat(action_start_time)
        reset_action = bitebot_conclude_action(biteBot, action_start_time, ...
            action_char, envenomation_time, ...
            latch_time, vacuum_time);
        if reset_action
            action_start_time = NaT;
            reset_action = false;
            action_char = NaN;
        end
    end

    pause(0.05);
    
end

%% Save Data

%devise filename
safe_datetime = replace(string(start_time), ...
    [" ", ":", "-"], "_");

safe_epithet = replace(epithet, ...
    [" ", ":", "-"], "_");

file_name_and_path = "../data/bitebot_" + safe_datetime + "_" ...
    + safe_epithet + ".csv";

% Preallocate with NaT for time and NaN for numbers
T = table(data_time, ...
    data_mass, ...
    data_action_char, ...
    'VariableNames', {'Time', 'Mass', 'Action'});

writetable(T, file_name_and_path);

%print("Test Data Stored");

% Close the figure window
close(mass_plot);