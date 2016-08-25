% ########################################################################
%
%           1D Double Integrator Heuristic Synthesis Demo
%
% ########################################################################

figure

xrange = [-3, -3, 3, 3];
integration_range = integration_rectangle(xrange);

[X,Y] = meshgrid(linspace(integration_range(1), integration_range(3),200), ...
                 linspace(integration_range(2), integration_range(4),200)); 
[Xl,Yl] = meshgrid(linspace(integration_range(1), integration_range(3),20), ...
                 linspace(integration_range(2), integration_range(4),20)); 

% Plot value function (closed form solution)
Za = dblInt1D_costToGo(X, Y);
sa=surf(X,Y,Za);
hold on 
Zal = dblInt1D_costToGo(Xl, Yl);
sal=surf(Xl,Yl,Zal);
shading interp

set(sa,'EdgeColor', 'none', 'FaceColor', [.9,.2,0], 'FaceAlpha', 0.3)
set(sal, 'FaceColor', 'none', 'EdgeColor', 'black', 'EdgeAlpha', 0.7)

% Vanilla version of the technique
 problem = @double_int_1D;
 degrees = [2, 4, 8, 12];
 alphas = [0.15, 0.2, 0.4, 0.8];
             
% Use symmetry reduction (not discussed in paper due to page limits; mentioned in conclusion)
% problem = @double_int_1D_symmetry;
% degrees = [2, 4, 6];
% alphas = [0.15, 0.2, 0.8];

hold on
for i=1:length(degrees)
    d = degrees(i);
    f = problem(xrange, d);
    Z = f(X,Y);

    % SOS asmissible heuristic for polynomial of degree d
    s=surf(X,Y,Z);

    % Cosmetics
    set(s, 'FaceColor', 'interp', 'faceAlpha', alphas(i));
    set(s, 'EdgeColor', 'none');

    title('', 'interpreter', 'latex', 'FontSize', 14)
    xlabel('$x_1$', 'interpreter', 'latex','FontSize', 16)
    ylabel('$x_2$','interpreter', 'latex','FontSize', 16)

end

