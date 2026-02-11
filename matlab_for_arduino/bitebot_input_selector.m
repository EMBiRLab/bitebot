function action_start_time = bitebot_input_selector(bitebot, current_char)
    if(current_char == 'e')
        print('Starting Envenomation');
        bitebot.start_envenomation();
        action_start_time = datetime('now');
    elseif(current_char == 'd')
        print('Dropping Fang');
        bitebot.release_latch();
        action_start_time = datetime('now');
    elseif(current_char == 'r')
        print('Resetting Fang');
        bitebot.reset_latch();
        action_start_time = NaN;
    elseif(current_char == 'v')
        print('Pulling Vacuum');
        bitebot.start_refill();
        action_start_time = datetime('now');
    else
        print('Invalid Character Input');
        action_start_time = NaN;
    end
end