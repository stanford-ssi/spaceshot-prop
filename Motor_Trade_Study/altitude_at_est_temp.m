function alt = altitude_at_est_temp(altitudes, est_temp, temp_offset, R, m, V, rho, T1, P)

    air_densities_wrong = (P ./ (R * est_temp)) + (m / V); % calculated from Fb = Fg and PV = mRT
    
%     plot(P, air_densities_wrong)
%     hold on
%     plot(P, rho)
    
    if air_densities_wrong(1) > rho(1)
        top = air_densities_wrong;
        bottom = rho;
    else
        top = rho;
        bottom = air_densities_wrong;
    end
    
    boolean_error = true;
    for j = 1:length(P)
        if top(j) <= bottom(j)
            break
        end
    end
    if j == length(P)
        boolean_error = false;
    end

    equilibrium_pressure = P(j);

    for k = 1:length(P)
        if P(k) <= equilibrium_pressure
            break
        end
    end

    alt(1) = altitudes(k);
    alt(2) = k;
    if k == length(P)
        alt(1) = 0;
    end
    alt(3) = boolean_error;
end