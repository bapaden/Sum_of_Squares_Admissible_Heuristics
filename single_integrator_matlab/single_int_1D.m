% ########################################################################
%
%           1D Single Integrator Heuristic Synthesis Demo
%
% ########################################################################

clear;clc;close all
Hdegree = 10; % polynomial degree of H
Ldegree = 10; % polynomial degree of multipliers  

e = 2:2:Hdegree;
sdpvar x
sdpvar u
c_H = sdpvar(length(e), 1);

% Semialgebraic sets describing X_free and Omega
g_x = 1-x^2;
g_u = 1-u^2;

% Multipliers
[lx,c_lx] = polynomial(x,Ldegree);
[ldx,c_ldx] = polynomial(x,Ldegree);
[ldu,c_ldu] = polynomial(u,Ldegree);

% Define heuristic H parameterized by coefficients c_H
H = repmat(x, [1, length(e)]).^e*c_H;
dHdt = jacobian(H, x)*u;

% Problem constraints (cf eq. (20) and (39))
F = [sos(dHdt+1-ldx*g_x-ldu*g_u), sos(H-lx*g_x), sos(ldx), sos(ldu), sos(lx)];

% Solve
tic
opts = sdpsettings('solver','sdpt3','sdpt3.maxit',500);
[sol,v,Q] = solvesos(F,-sum(c_H),opts,[c_lx, c_ldx, c_ldu])
toc

% Plot
figure('pos',[10 10 900 600])
xv = linspace(-1,1,101);
fun = yalmip2matlabFun('H');
Hv = fun(xv);
plot(xv, Hv)
hold on 
plot(xv, abs(xv))
title(['Admissible Heuristic for the 1D-Single integrator. Polynomial Degree of Heuristic: ' num2str(Hdegree)],'Interpreter', 'Latex','Fontsize',16)
xlabel('$X$','Interpreter','Latex','Fontsize',16)
ylabel('$H(x)$','Interpreter','Latex','Fontsize',16)
legend('H(x)-Admissible Heuristic','V(x)-Optimal cost-to-go')



