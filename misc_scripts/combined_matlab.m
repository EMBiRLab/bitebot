%% BiteBot: Run Trial (Servo Release) + Plot Load Cell
clear; clc;

port = "COM8";
baud = 115200;

s = serialport(port, baud);
configureTerminator(s,"LF");
s.Timeout = 10;
flush(s);

% Wait for READY
disp("Waiting for Arduino...");
while true
    line = strtrim(readline(s));
    if contains(line,"READY")
        break;
    end
end
disp("Connected");

% Start trial
writeline(s,"S");

% Wait for DATA_BEGIN
while true
    line = strtrim(readline(s));
    if contains(line,"DATA_BEGIN")
        break;
    end
end

% Read until DATA_END
data = [];
while true
    line = strtrim(readline(s));
    if contains(line,"DATA_END")
        break;
    end
    data(end+1,1) = str2double(line); %#ok<SAGROW>
end

% Show what was actually received
fprintf("Received %d samples\n", numel(data));

% Clean NaNs for plotting (optional)
% data = fillmissing(data,'linear');  % or leave NaNs

% Plot
figure;
plot(data, 'LineWidth', 1.5);
xlabel("Sample");
ylabel("Load Cell (g equivalent)");
title("BiteBot Load Cell Response After Lever Release");
grid on;
