%% Post Script Analysis

clear;
load('live_graph_results.mat');
raw_data.time(1) = 0;
raw_data.mass(raw_data.mass < 0) = 0;
raw_data.time = smooth_time_data(raw_data.time);

plot(raw_data.time,raw_data.mass);
hold on;

starting_indexes = find_starting_indexes(raw_data.mass, 10);
ending_indexes = find_ending_indexes(raw_data.mass, 10);

scatter(raw_data.time(starting_indexes),raw_data.mass(starting_indexes));
scatter(raw_data.time(ending_indexes),raw_data.mass(ending_indexes));

num_starts = length(starting_indexes);
max_mass = zeros(num_starts,1);
static_mass = zeros(num_starts,1);
duration = zeros(num_starts,1);

for i = 1:num_starts
    max_mass(i) = max(raw_data.mass(starting_indexes(i):ending_indexes(i)));
    static_mass(i) = mean(raw_data.mass(starting_indexes(i)+10:ending_indexes(i)));
    duration(i) = raw_data.time(ending_indexes(i)) - raw_data.time(starting_indexes(i));
end
time_segments_1 = raw_data.time(starting_indexes(1):ending_indexes(1))';
time_segments_2 = raw_data.time(starting_indexes(2):ending_indexes(2))';
time_segments_3 = raw_data.time(starting_indexes(3):ending_indexes(3))';
time_segments_4 = raw_data.time(starting_indexes(4):ending_indexes(4))';
time_segments_5 = raw_data.time(starting_indexes(5):ending_indexes(5))';
time_segments_6 = raw_data.time(starting_indexes(6):ending_indexes(6))';
time_segments_7 = raw_data.time(starting_indexes(7):ending_indexes(7))';
time_segments_8 = raw_data.time(starting_indexes(8):ending_indexes(8))';
time_segments_9 = raw_data.time(starting_indexes(9):ending_indexes(9))';
time_segments_10 = raw_data.time(starting_indexes(10):ending_indexes(10))';

mass_segments_1 = raw_data.mass(starting_indexes(1):ending_indexes(1))';
mass_segments_2 = raw_data.mass(starting_indexes(2):ending_indexes(2))';
mass_segments_3 = raw_data.mass(starting_indexes(3):ending_indexes(3))';
mass_segments_4 = raw_data.mass(starting_indexes(4):ending_indexes(4))';
mass_segments_5 = raw_data.mass(starting_indexes(5):ending_indexes(5))';
mass_segments_6 = raw_data.mass(starting_indexes(6):ending_indexes(6))';
mass_segments_7 = raw_data.mass(starting_indexes(7):ending_indexes(7))';
mass_segments_8 = raw_data.mass(starting_indexes(8):ending_indexes(8))';
mass_segments_9 = raw_data.mass(starting_indexes(9):ending_indexes(9))';
mass_segments_10 = raw_data.mass(starting_indexes(10):ending_indexes(10))';

%% Helper Functions

function starting_indexes = find_starting_indexes(mass, barrier)
    starting_indexes = [];
    mass_logic = mass > barrier;
    for i = 2:length(mass_logic)
        if mass_logic(i) && ~mass_logic(i-1)
            starting_indexes(end+1) = i; % Store the index where the condition starts
        end
    end
end

function ending_indexes = find_ending_indexes(mass, barrier)
    ending_indexes = [];
    mass_logic = mass > barrier;
    for i = 2:length(mass_logic)
        if ~mass_logic(i) && mass_logic(i-1)
            ending_indexes(end+1) = i; % Store the index where the condition starts
        end
    end
end

function smooth_time = smooth_time_data(time)
smooth_time = time;
    for i = 2:length(smooth_time)
        if smooth_time(i-1) >= smooth_time(i)
            smooth_time(i) = smooth_time(i) + 0.1;
        end
    end
end