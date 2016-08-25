% 1D double integrator case 
function fun = double_int_1D_symmetry(xrange, Hdeg)
    Ldeg = Hdeg;
    sdpvar x1
    sdpvar x2 
    sdpvar u
    x=[x1 x2];

    % normal to the symmetry halfspace
    ns = [1;0]; % hardcoded because integral is hard to define in general

    % constraints
    urange = [-1, 1];
    g1=x1-xrange(1);
    g2=xrange(3)-x1;
    g3=x2-xrange(2);
    g4=xrange(4)-x2;
    g5=u-urange(1);
    g6=urange(2)-u;
    gsym=[x1, x2]*ns;

    integration_range = integration_rectangle(xrange);
    
    % Multipliers
    [m1,c_m1] = polynomial(x1,Ldeg);
    [m2,c_m2] = polynomial(x1,Ldeg);
    [m3,c_m3] = polynomial(x2,Ldeg);
    [m4,c_m4] = polynomial(x2,Ldeg);
    [m5,c_m5] = polynomial(u,Ldeg);
    [m6,c_m6] = polynomial(u,Ldeg);
    [msym,c_msym] = polynomial(x,Ldeg);

    % Family of H
    [H, c_H]= polynomial(x,Hdeg);
    dHdt = jacobian(H, x)*[x2;u];

    % Problem constraints
    F = [sos(dHdt+1-[g1 g2 g3 g4 g5 g6 gsym]*[m1 m2 m3 m4 m5 m6 msym]'),...
         sos(m1), sos(m2), sos(m3), sos(m4), sos(m5), sos(m6)
         sos(msym), c_H(1)==0];

    % Solve
    obj=int(H,x,[0, integration_range(2)], integration_range(3:4));
    ops = sdpsettings('solver','sdpt3','sdpt3.maxit',100);
    sol = solvesos(F,-obj,ops,[c_m1', c_m2', c_m3', c_m4', ...
                   c_m5', c_m6', c_msym', c_H'])
   
    % Evaluate yalmip output
    fun_raw = yalmip2matlabFun('H');

    halfspace = @(X, Y) sign(permute(sum(bsxfun(@times, permute(cat(3, X, Y), ...
                [1 3 2]), ns'), 2), [1 3 2]));

    fun = @(X, Y) fun_raw(halfspace(X,Y).*X, halfspace(X,Y).*Y);
end