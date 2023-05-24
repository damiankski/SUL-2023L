clc; % czysci command window
clear; %czysci zmienne
close; %zamyka wszystkie okna
%% Geometria i geometria odwrotna

% Deklaracja danych
y_max = 100;
L = 180;
R=100;
Y=180;
alpha=asin(R/(2*L));
alpha_prim=pi/2 - alpha;
delta_max = 25;

% określenie wektora wychylenia steru
delta=-25:0.1:25;

% zamiana wychyelnia steru na wysunięcie siłownika
delta_h = -(Y-sqrt(L^2+R^2-2*L*R*cos(alpha_prim-delta*pi/180)));

% Wykres wydłużenia siłownika w funkcji kąta wychylenia steru
plot(delta,delta_h);
grid on
xlabel('\delta [\circ]');
ylabel('\delta_h [mm]');
grid on
close

%% Dynamika układu
% Deklaracja danych

v_dzwieku = 340.3;
Ma= 0.3;
v_lotu = v_dzwieku*Ma;
c = 2.37;
rho = 1.2255;
b = 12.45;
wsp1 = 0.5*rho * c^2 * b;

% Określenie wektora dopuszczalnych prędkości
V = (0.1*v_dzwieku:10:0.8*v_dzwieku)';

% Zebranie charakterystyk aerodynamicznych z programu X-FOIL
delta_dyn = [-25, -20, -10, 0, 10, 20, 25];
delta_dyn = deg2rad(delta_dyn);
cm_h = [-0.033139, -0.027379, -0.017291, -0.000038, 0.017291, 0.027379, 0.033139];
M_h = wsp1*cm_h;

%Określenie obciążenia na siłowniku
delta_h_dyn = -(Y-sqrt(L^2+R^2-2*L*R.*cos(alpha_prim-delta_dyn)));
beta = acos((R^2 +delta_h_dyn.*(delta_h_dyn+2*L))./(2*R*(L+delta_h_dyn))) - pi/2;
R_B = M_h./(R*cos(beta));
    
Q = V.^2*R_B;

%Wykres znormalizowanego obciążenia w funkcji wychylenia steru
plot(delta_dyn,R_B,'LineWidth',2);
grid on
xlabel('\delta [\circ]');
ylabel('R_B/v^2 [N/(m/s)^2]');
axis([-pi/6 pi/6 -0.02 0.02])
grid on
close

%% Siłownik

% Deklaracja danych
A_1 = 5.03*1e-3;      % m^2
A_2 = 1.59*1e-3;      % m^2
m = 10;               % kg
K = 1.8e5;            % Pa
V_1 = 2.26*1e-4;      % m^3
V_2 = 6.68*1e-5;      % m^3
b_tlum = -5;               % kg/s

% warunki początkowe
p_01 = 1e6;           % Pa
p_02 = p_01*A_1/A_2;  % Pa

x_0 = 0;              % m
xp_0 = 0;             % m/s

%% Dane wejściowe do symulacji

v_lotu = 0.5*340;     % m/s