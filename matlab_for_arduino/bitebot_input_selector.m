function action_start_time = bitebot_input_selector(bitebot, mass_plot, current_char)
    if(current_char == 'e')
        print('Starting Envenomation');
        bitebot.start_envenomation();
    elseif(current_char == 'd')
        print('Dropping Fang');
        bitebot.release_latch();
    elseif(current_char == 'v')
        print('Pulling Vacuum');
        bitebot.start_refill();
    % CRITICAL: Clear the character so it doesn't trigger again
    set(mass_plot, 'CurrentCharacter', char(0));
    end
    action_start_time = tic;
end