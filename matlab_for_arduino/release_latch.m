function release_latch(latch)
    writePosition(latch, 0.0);
    pause(5); % Wait for X seconds before moving to the next position
    writePosition(latch, 0.5);
end