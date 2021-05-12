function f = app_input_eq(m_payload, m_balloon, V, ground_temp)

    %% inputs that aren't worth putting in the GUI
    R = 2076.9; % J/kgK gas constant for He at 300K

    %% calcs
    est_alt = 40000; % altitude to aproximate temperature at before iteration
    starting_alt = 0; % m
    final_alt = 80000; % m 
    n = 100001; % altitude steps
    
    m = m_payload + m_balloon; %kg volume of payload + balloon (not incl He)
    temp_offset = ground_temp - 15; % with no offset, standard conditions are 15 C

    altitudes = linspace(starting_alt, final_alt, n);
    [rho,a,T,P,nu,h,sigma] = atmos(altitudes, 'toffset', temp_offset);
    
    
    %for loop iterates a few times in case the est_alt guess is way off
    for i = 1:5
        for j = 1:length(altitudes)
            if altitudes(j) >= est_alt
                break
            end
        end
        est_temp = T(j);

        output = altitude_at_est_temp(altitudes, est_temp, temp_offset, R, m, V, rho, T, P);
        est_alt = output(1);
    end

    f = est_alt;
end

