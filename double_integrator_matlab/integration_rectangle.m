function rec = integration_rectangle(xrange, umax)
    % Returns the biggest feasible rectangle for a 1D double integrator
    % within the rectangle defined by xrange. The "biggest feasible 
    % rectangle" is s.t. ANY optimal trajectory that starts within it will 
    % never get out of the rectangle defined by xrange.
    
    if nargin < 2
        umax=1;
    end
    
    xmin = xrange(1);
    xmax = xrange(3);
    k = 1/2/umax;
    h = sqrt((xmax-xmin)/6/k);
    L = k*h^2+xmin;
    R = xmax-k*h^2;
    hmin = max(-h, xrange(2));
    hmax = min(h, xrange(4));
    
    rec = [L, hmin, R, hmax]; %in the form [x1_min, x2_min, x1_max, x2_max]
end