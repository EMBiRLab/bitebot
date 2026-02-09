clear;
clc;

a = arduino;
%lc_pins = {char('D3'); char('D2')};
loadcell = addon(a, 'basicHX711/basic_HX711', {'D3', 'D2'});