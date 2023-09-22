set_time_format -unit ns -decimal_places 3
create_clock -name {CLOCK_50} -period 20 [get_ports { CLOCK_50 }]
derive_clock_uncertainty
