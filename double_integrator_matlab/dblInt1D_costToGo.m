function V = dblInt1D_costToGo(x0, v0, xg, vg, umax)
    % Returns the cost-to-go from position x0, velocity v0 (can be
    % matrices) towards a goal xg position, vg velocity
        
    if nargin < 5
       umax = 1;
    end
    if nargin < 3
       xg = 0;
       vg = 0;
    end
    
    % Switching curve
    xsplit = @(v) sign(vg-v).*((v-vg).^2./2/umax+vg*(v-vg)/umax)+xg;
    % Side w/r to switching
    side = sign(xsplit(v0)-x0);    
    % Switching velocity
    vswitch = side.*sqrt(v0.^2+vg.^2-2*side*umax.*x0+2*side*umax*xg)/sqrt(2);
    % Cost to go
    V = (abs(v0-vswitch)+abs(vswitch-vg))/umax;
     
    % Plots (only on if a single initial input state is given)
    if(length(x0)==1)
        vs = linspace(-5,5,100);
        plot(xsplit(vs), vs)
        hold on
        firstpar = @(v) side*(v-v0).^2./2/umax+side*v0*(v-v0)/umax+x0;
        plot(firstpar(vs), vs);
        plot(x0, v0, 'r*')
        plot(firstpar(vswitch), vswitch, 'b*')
        grid on  
    end
end