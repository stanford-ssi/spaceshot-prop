clear; clc; close all;

rocket_mass = 5.174; % kg, without motor
stability_mass = 5; % kg


%launch_alt = 29000; %m
motor_list = ["O5280", "N5800", "O3400", "N2900", "N3800", "N4100", "N3301", "N1100", "N2540", "N5600", "N2501", "N3180", "N2500", "N2850", "N3300", "N1560", "N1000", "N1975", "N2000", "N3400", "N2200", "N1800", "N10000", "N2600", "N2220"];

V = 1529.1097; % balloon volume, m^3
r = ((3/(4*pi))*V)^(1/3); % balloon radius, m
ground_temp = 25; % degrees C
thickness = 0.0000076; % thickness of balloon material, m
density = 941; % density of balloon material, kg/m^3
SA = 4 * pi * r^2; % surface area of balloon, m^2
m_balloon = SA * thickness * density; % balloon mass, kg


for i = 1:length(motor_list)
    name = motor_list(i);
    m = motor(name);
    time = m(1,:);
    thrust = m(2,:);
    prop_mass = m(3);
    motor_total_mass = m(4);

    wet_mass = motor_total_mass + rocket_mass;
    dry_mass = wet_mass - prop_mass;
    
    launch_alt(i) = app_input_eq(wet_mass + stability_mass, m_balloon, V, ground_temp);
    
    f = apogee(launch_alt(i), wet_mass, dry_mass, time, thrust);
    apogees(i) = f(1);
    max_velocities(i) = f(2);
    
    
    
end
apogees = apogees ./ 1000;
launch_alt = launch_alt ./ 1000;
a = [motor_list; apogees; max_velocities; launch_alt];
RESULTS = a';







