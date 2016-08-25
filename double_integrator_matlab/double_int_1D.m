% ########################################################################
% 
%                   1D Double Integrator Heuristic     
% 
% ########################################################################

function fun = double_int_1D(xrange, Hdeg)
%clear; clc;

%Hdeg = 12;    % Polynomial degree of heuristic
Ldeg = Hdeg;  % polynomial degree of multipliers

% ~~~~~~~~~~~~~~~~~~~~~~~~~    Constraints     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%xrange = [-3, -3, 3, 3]; % given as [x1_min, x2_min, x1_max, x2_max] 

sdpvar x1
sdpvar x2 
sdpvar u
x=[x1 x2];

integration_range =  integration_rectangle(xrange);
urange = [-1, 1];
g1=x1-xrange(1);
g2=xrange(3)-x1;
g3=x2-xrange(2);
g4=xrange(4)-x2;
g5=u-urange(1);
g6=urange(2)-u;

% ~~~~~~~~~~~~~~~~~~~~~~~~~    Multipliers     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[m1,c_m1] = polynomial(x1,Ldeg);
[m2,c_m2] = polynomial(x1,Ldeg);
[m3,c_m3] = polynomial(x2,Ldeg);
[m4,c_m4] = polynomial(x2,Ldeg);
[m5,c_m5] = polynomial(u,Ldeg);
[m6,c_m6] = polynomial(u,Ldeg);

% ~~~~~~~~~~~~~~~~~~~~~~~~~    Family of H     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Quadratic formulation
%v = monolist(x,Hdeg/2);
%Q = sdpvar(length(v));
%H = v'*Q*v;

% Generic polynomial formulation
[H, c_H]= polynomial(x,Hdeg);
dHdt = jacobian(H, x)*[x2;u];

% ~~~~~~~~~~~~~~~~~~~~~~~    SOS Constraints   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

F = [sos(dHdt+1-[g1 g2 g3 g4 g5 g6]*[m1 m2 m3 m4 m5 m6]') ... 
     sos(m1), sos(m2), sos(m3), sos(m4), sos(m5), sos(m6), ...
     c_H(1)==0]; % use Q(1, 1) == 0 for the quadratic formulation
 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    Solve   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

obj=int(H,x,integration_range(1:2), integration_range(3:4));
ops = sdpsettings('solver','sdpt3','sdpt3.maxit',100);
[sol,w,M] = solvesos(F,-obj,ops,[c_m1', c_m2', c_m3', c_m4', ...
                     c_m5', c_m6', ...
                     c_H']); % use Q(:)' for quadratic formulation
sol

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    Plot   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Evaluate yalmip output
fun = yalmip2matlabFun('H');

end