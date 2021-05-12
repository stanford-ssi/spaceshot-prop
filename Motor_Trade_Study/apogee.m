function f = apogee(launch_alt, wet_mass, dry_mass, time, thrust)
    n = 500;
    Cd = 0.45; % from open rocket of hichhiker
    diameter = 4; % in
    g = 9.81;
    
    diameter_meters = diameter / 39.37;
    A = pi * (diameter_meters / 2)^2;
    
    p = polyfit(time,thrust,6);
    end_time = time(length(time));
    t = linspace(0, end_time, n);
    T = p(1) .* t.^6 + p(2) .* t.^5 + p(3) .* t.^4 + p(4) .* t.^3 + p(5) * t.^2 + p(6) .* t + p(7);
    
    m = ((dry_mass - wet_mass) / end_time) .* t + wet_mass;
    
    h(1) = launch_alt;
    v(1) = 0;
    dt = t(2) - t(1);
    for i = 1:n
        [rho,a,Temp,P,nu,z,sigma] = atmos(h(i));
        drag = 0.5 * rho * Cd * A * v(i)^2;
        Fg = -g * m(i);
        F = T(i) - drag + Fg;
        a = F / m(i);
        v(i+1) = v(i) + a * dt;
        h(i+1) = h(i) + v(i+1) * dt;
    end
    
    while v(i) > 0
        [rho,a,Temp,P,nu,z,sigma] = atmos(h(i));
        drag = 0.5 * rho * Cd * A * v(i)^2;
        Fg = -g * dry_mass;
        F = Fg - drag;
        a = F / dry_mass;
        v(i+1) = v(i) + a * dt;
        h(i+1) = h(i) + v(i+1) * dt;
        i = i+1;
    end

    f(1) = h(length(h));
    f(2) = max(v);
end