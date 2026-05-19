function reset_bool = bitebot_conclude_action(bitebot, action_start_time, ...
    action_char, envenomation_time, ...
    latch_time, vacuum_time)

    current_time = datetime('now');
    delta_t = current_time - action_start_time;
    elapsed_time = seconds(delta_t);
    reset_bool = false; % Initialize reset_bool to false
    if(action_char == 'e' && elapsed_time > envenomation_time)
        print('Ending Envenomation');
        bitebot.end_envenomation();
        reset_bool = true;
    elseif(action_char == 'd' && elapsed_time > latch_time)
        print('Resetting Fang');
        bitebot.reset_latch();
        reset_bool = true;
    elseif(action_char == 'v' && elapsed_time > vacuum_time)
        print('Ending Vacuum');
        bitebot.end_refill();
        reset_bool = true;
    end
end