clc; % czysci command window
clear; %czysci zmienne
close; %zamyka wszystkie okna
%% Geometria i geometria odwrotna

% Deklaracja danych
L = 180;    % mm
R=100;      % mm
Y=180;      % mm
alpha=asin(R/(2*L));      %rad
alpha_prim=pi/2 - alpha;  %rad
delta_max = 25;           % stopnie

% określenie wektora wychylenia steru
delta=-delta_max:0.1:delta_max;

% zamiana wychyelnia steru na wysunięcie siłownika [mm]
delta_h = -(Y-sqrt(L^2+R^2-2*L*R*cos(alpha_prim-delta*pi/180)));

% Wykres wydłużenia siłownika w funkcji kąta wychylenia steru
plot(delta,delta_h)
grid on
xlabel('\delta [\circ]');
ylabel('\delta_h [mm]');
grid on

close %zamyka okno z wykresem
%% Dynamika układu
% Deklaracja danych

v_dzwieku = 340.3;         % m/s
c = 2.37;                  % m
rho = 1.2255;              % kg/m^3
b = 12.45;                 % m
wsp1 = 0.5*rho * c^2 * b;  % współczynnik wymiarujący moment zawiasowy-

% Określenie wektora dopuszczalnych prędkości
V = (0.1*v_dzwieku:10:0.8*v_dzwieku)';

% Zebranie charakterystyk aerodynamicznych z programu X-FOIL
delta_dyn = [-25, -20, -10, 0, 10, 20, 25]; % stopnie
delta_dyn = deg2rad(delta_dyn); % rad

cm_h = [-0.033139, -0.027379, -0.017291, -0.000038, 0.017291, 0.027379, 0.033139];
M_h = wsp1*cm_h; 

%Określenie obciążenia na siłowniku
delta_h_dyn = -(Y-sqrt(L^2+R^2-2*L*R.*cos(alpha_prim-delta_dyn)));
beta = acos((R^2 +delta_h_dyn.*(delta_h_dyn+2*L))./(2*R*(L+delta_h_dyn))) - pi/2;
R_B = M_h./(R*cos(beta));

 % wyjściowa tablica do modelu w Simulink
Q = V.^2*R_B;  % N

% utworzenie siatki pod wizualizację 3D
[X,Y] = meshgrid(delta_dyn, V);   
% uwtorzenie wartości powierzchni
Z = M_h./(R*cos(acos((R^2 +delta_h_dyn.*(delta_h_dyn+2*L))./(2*R*(L+delta_h_dyn))) - pi/2)).*V.^2;

surf(rad2deg(X),Y,Z)
xlabel('\delta [\circ]')
ylabel('V [m/s]')
zlabel('R_B [N]')
grid on

close %zamyka okno z wykresem

%Wykres znormalizowanego obciążenia w funkcji wychylenia steru
figure
plot(rad2deg(delta_dyn),R_B,'LineWidth',2);
grid on
xlabel('\delta [\circ]');
ylabel('\it{R_B}/v^2 \it{[N/(m/s)^2]}');
axis([-30 30 -0.02 0.02])

close %zamyka okno z wykresem
%% Siłownik

% Deklaracja danych
A_1 = 5.03*1e-3;      % m^2
A_2 = 1.59*1e-3;      % m^2
m = 10;               % kg
K = 1.8e5;            % Pa
V_1 = 2.26*1e-4;      % m^3
V_2 = 6.68*1e-5;      % m^3
b_tlum = -5;          % kg/s

% warunki początkowe
p_01 = 1e6;           % Pa
p_02 = p_01*A_1/A_2;  % Pa

x_0 = 0;              % m
xp_0 = 0;             % m/s
%% Dane wejściowe

v_lotu = 0.5*340;     % m/s
kat_wychylenia =7;    % stopnie
czas_wymuszenia = 8;  % s
