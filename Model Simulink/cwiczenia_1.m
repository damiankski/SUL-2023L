clc;
clear;
close all;

tiledlayout(2,2);

nexttile;
alpha = 0:0.1:2*pi;
plot(alpha,sin(alpha),'r')
xlabel('angle (0 \leq \alpha \leq 2 \pi');
ylabel('sin(\alpha)')
axis equal;
grid on

nexttile;
alpha1 = 0:0.1:4*pi;
plot(alpha1,cos(alpha1),'m-','LineWidth',1)
xlabel('angle (0 \leq \alpha \leq 2 \pi)');
ylabel('cos(\alpha)')
axis equal;
grid on

nexttile([1 2]);
hold on
for a = [0.5 1 2 3 4]
    plot(alpha,a*sin(alpha));
end

title('sines');
xlabel('angle (0 \leq \alpha \leq 2 \pi)');
ylabel('cos(\alpha)')
grid on
legend('a=0.5','a=1','a=2','a=3','a=4')

exportgraphics(gcf,'sines.png','Resolution',300)


%x = 0:0.1:2*pi;
%y = sin(x)

%plot(x,y)
%hold on
%xlabel('x')
%ylabel('sin(x)')

%plot(x,cos(x))
%hold off