%#codegen
function [ blinky ] = blink_leds(dummy_input)

    persistent blinky_cnt   % holds value but doesn't carry name into different functions

    if (isempty(blinky_cnt))  
        blinky_cnt = 0;
    end
    
    blinky_cnt = blinky_cnt + 1;
    if blinky_cnt == 160000000
        blinky_cnt = 0;
    end
%     blinky = floor(blinky_cnt/10000000);  % For Harware
    blinky = floor(blinky_cnt/10);          % For matlab testing
end
