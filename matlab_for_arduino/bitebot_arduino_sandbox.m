% 1. Create the instance
%myBot = BiteBotArduino();
myBot = BiteBotArduino('D4');
%myBot.arduino_object = arduino(); % premade standard arduino object
%myBot.blink_pin = 'D4';

% 2. Call the method
myBot.activate();