clc; % czysci command window
clear; %czysci zmienne
close; %zamyka wszystkie okna

y_max = 100;
alpha=pi/12;
L = 230;
R=100;
Y=180;

DeltaH = sqrt(-(2*L*R*cos(pi/2-alpha)-L^2-R^2))-Y


x=-y_max/2:0.5:y_max/2;


delta_h = (pi/2-alpha-acos((L^2+R^2-(Y+x+DeltaH).^2)/(2*L*R)))*180/pi;
figure;
plot(x,delta_h);
grid on
xlabel('\Delta h [mm]');
ylabel('\delta [\circ]');
axis([-90 90 -25 25])
grid on
hold on

