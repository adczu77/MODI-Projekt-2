clear;
filename = 'danedynucz41.txt';
delimiterIn = ' ';
headerlinesIn = 0;
DaneDynUcz = importdata(filename,delimiterIn,headerlinesIn);

filename = 'danedynwer41.txt';
delimiterIn = ' ';
headerlinesIn = 0;
DaneDynWer = importdata(filename,delimiterIn,headerlinesIn);

udynucz = DaneDynUcz(:,1);
udynwer = DaneDynWer(:,1);
ydynucz = DaneDynUcz(:,2);
ydynwer = DaneDynWer(:,2);

% Modele nieliniowe o dynamice pierwszego rzędu

% stopień wielomianu n=2

k = size(ydynucz,1);
M = [udynucz(3:k-1) udynucz(3:k-1).^2 ydynucz(3:k-1) ydynucz(3:k-1).^2];
w = M\ydynucz(4:k);
EdynuczARX = 0;
EdynuczOE = 0;
EdynwerARX = 0;
EdynwerOE = 0;
YmodARXucz(1:3)=ydynucz(1:3);
YmodOEucz(1:3)=ydynucz(1:3);
YmodARXwer(1:3)=ydynwer(1:3);
YmodOEwer(1:3)=ydynwer(1:3);
for i=4:k
    YmodARXucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*ydynucz(i-1)+w(4)*ydynucz(i-1)^2;
    YmodOEucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*YmodOEucz(i-1)+w(4)*YmodOEucz(i-1)^2;
    YmodARXwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*ydynwer(i-1)+w(4)*ydynwer(i-1)^2;
    YmodOEwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*YmodOEwer(i-1)+w(4)*YmodOEwer(i-1)^2;
end
for i=1:k
    EdynuczARX=EdynuczARX+(YmodARXucz(i)-ydynucz(i))^2;
    EdynwerARX=EdynwerARX+(YmodARXwer(i)-ydynwer(i))^2;
    EdynuczOE=EdynuczOE+(YmodOEucz(i)-ydynucz(i))^2;
    EdynwerOE=EdynwerOE+(YmodOEwer(i)-ydynwer(i))^2;
end

figure
tiledlayout(2,1)
ax1=nexttile;
hold on
plot(ax1,ydynucz)
plot(ax1,YmodARXucz)
title("Zbiór uczący - model ARX rzędu 1, stopień wielomianu 2. E="+EdynuczARX)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
ax2=nexttile;
hold on
plot(ax2,ydynucz)
plot(ax2,YmodOEucz)
title("Zbiór uczący - model OE rzędu 1, stopień wielomianu 2. E="+EdynuczOE)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
print('modi2_2c_wykres1.png','-dpng','-r400')

figure
tiledlayout(2,1)
ax1=nexttile;
hold on
plot(ax1,ydynwer)
plot(ax1,YmodARXwer)
title("Zbiór weryfikujący - model ARX rzędu 1, stopień wielomianu 2. E="+EdynwerARX)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
ax2=nexttile;
hold on
plot(ax2,ydynwer)
plot(ax2,YmodOEwer)
title("Zbiór weryfikujący - model OE rzędu 1, stopień wielomianu 2. E="+EdynwerOE)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
print('modi2_2c_wykres2.png','-dpng','-r400')

% stopień wielomianu n=3

k = size(ydynucz,1);
M = [udynucz(3:k-1) udynucz(3:k-1).^2 udynucz(3:k-1).^3 ydynucz(3:k-1) ydynucz(3:k-1).^2 ydynucz(3:k-1).^3];
w = M\ydynucz(4:k);
EdynuczARX = 0;
EdynuczOE = 0;
EdynwerARX = 0;
EdynwerOE = 0;
YmodARXucz(1:3)=ydynucz(1:3);
YmodOEucz(1:3)=ydynucz(1:3);
YmodARXwer(1:3)=ydynwer(1:3);
YmodOEwer(1:3)=ydynwer(1:3);
for i=4:k
    YmodARXucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*udynucz(i-1)^3+w(4)*ydynucz(i-1)+w(5)*ydynucz(i-1)^2+w(6)*ydynucz(i-1)^3;
    YmodOEucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*udynucz(i-1)^3+w(4)*YmodOEucz(i-1)+w(5)*YmodOEucz(i-1)^2+w(6)*YmodOEucz(i-1)^3;
    YmodARXwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*udynwer(i-1)^3+w(4)*ydynwer(i-1)+w(5)*ydynwer(i-1)^2+w(6)*ydynwer(i-1)^3;
    YmodOEwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*udynwer(i-1)^3+w(4)*YmodOEwer(i-1)+w(5)*YmodOEwer(i-1)^2+w(6)*YmodOEwer(i-1)^3;
end
for i=1:k
    EdynuczARX=EdynuczARX+(YmodARXucz(i)-ydynucz(i))^2;
    EdynwerARX=EdynwerARX+(YmodARXwer(i)-ydynwer(i))^2;
    EdynuczOE=EdynuczOE+(YmodOEucz(i)-ydynucz(i))^2;
    EdynwerOE=EdynwerOE+(YmodOEwer(i)-ydynwer(i))^2;
end

figure
tiledlayout(2,1)
ax1=nexttile;
hold on
plot(ax1,ydynucz)
plot(ax1,YmodARXucz)
title("Zbiór uczący - model ARX rzędu 1, stopień wielomianu 3. E="+EdynuczARX)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
ax2=nexttile;
hold on
plot(ax2,ydynucz)
plot(ax2,YmodOEucz)
title("Zbiór uczący - model OE rzędu 1, stopień wielomianu 3. E="+EdynuczOE)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
print('modi2_2c_wykres3.png','-dpng','-r400')

figure
tiledlayout(2,1)
ax1=nexttile;
hold on
plot(ax1,ydynwer)
plot(ax1,YmodARXwer)
title("Zbiór weryfikujący - model ARX rzędu 1, stopień wielomianu 3. E="+EdynwerARX)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
ax2=nexttile;
hold on
plot(ax2,ydynwer)
plot(ax2,YmodOEwer)
title("Zbiór weryfikujący - model OE rzędu 1, stopień wielomianu 3. E="+EdynwerOE)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
print('modi2_2c_wykres4.png','-dpng','-r400')

% stopień wielomianu n=4

k = size(ydynucz,1);
M = [udynucz(3:k-1) udynucz(3:k-1).^2 udynucz(3:k-1).^3 udynucz(3:k-1).^4 ydynucz(3:k-1) ydynucz(3:k-1).^2 ydynucz(3:k-1).^3 ydynucz(3:k-1).^4];
w = M\ydynucz(4:k);
EdynuczARX = 0;
EdynuczOE = 0;
EdynwerARX = 0;
EdynwerOE = 0;
YmodARXucz(1:3)=ydynucz(1:3);
YmodOEucz(1:3)=ydynucz(1:3);
YmodARXwer(1:3)=ydynwer(1:3);
YmodOEwer(1:3)=ydynwer(1:3);
for i=4:k
    YmodARXucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*udynucz(i-1)^3+w(4)*udynucz(i-1)^4+w(5)*ydynucz(i-1)+w(6)*ydynucz(i-1)^2+w(7)*ydynucz(i-1)^3+w(8)*ydynucz(i-1)^4;
    YmodOEucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*udynucz(i-1)^3+w(4)*udynucz(i-1)^4+w(5)*YmodOEucz(i-1)+w(6)*YmodOEucz(i-1)^2+w(7)*YmodOEucz(i-1)^3+w(8)*YmodOEucz(i-1)^4;
    YmodARXwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*udynwer(i-1)^3+w(4)*udynwer(i-1)^4+w(5)*ydynwer(i-1)+w(6)*ydynwer(i-1)^2+w(7)*ydynwer(i-1)^3+w(8)*ydynwer(i-1)^4;
    YmodOEwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*udynwer(i-1)^3+w(4)*udynwer(i-1)^4+w(5)*YmodOEwer(i-1)+w(6)*YmodOEwer(i-1)^2+w(7)*YmodOEwer(i-1)^3+w(8)*YmodOEwer(i-1)^4;
end
for i=1:k
    EdynuczARX=EdynuczARX+(YmodARXucz(i)-ydynucz(i))^2;
    EdynwerARX=EdynwerARX+(YmodARXwer(i)-ydynwer(i))^2;
    EdynuczOE=EdynuczOE+(YmodOEucz(i)-ydynucz(i))^2;
    EdynwerOE=EdynwerOE+(YmodOEwer(i)-ydynwer(i))^2;
end

figure
tiledlayout(2,1)
ax1=nexttile;
hold on
plot(ax1,ydynucz)
plot(ax1,YmodARXucz)
title("Zbiór uczący - model ARX rzędu 1, stopień wielomianu 4. E="+EdynuczARX)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
ax2=nexttile;
hold on
plot(ax2,ydynucz)
plot(ax2,YmodOEucz)
title("Zbiór uczący - model OE rzędu 1, stopień wielomianu 4. E="+EdynuczOE)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
print('modi2_2c_wykres5.png','-dpng','-r400')

figure
tiledlayout(2,1)
ax1=nexttile;
hold on
plot(ax1,ydynwer)
plot(ax1,YmodARXwer)
title("Zbiór weryfikujący - model ARX rzędu 1, stopień wielomianu 4. E="+EdynwerARX)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
ax2=nexttile;
hold on
plot(ax2,ydynwer)
plot(ax2,YmodOEwer)
title("Zbiór weryfikujący - model OE rzędu 1, stopień wielomianu 4. E="+EdynwerOE)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
print('modi2_2c_wykres6.png','-dpng','-r400')

% stopień wielomianu n=5

k = size(ydynucz,1);
M = [udynucz(3:k-1) udynucz(3:k-1).^2 udynucz(3:k-1).^3 udynucz(3:k-1).^4 udynucz(3:k-1).^5 ydynucz(3:k-1) ydynucz(3:k-1).^2 ydynucz(3:k-1).^3 ydynucz(3:k-1).^4 ydynucz(3:k-1).^5];
w = M\ydynucz(4:k);
EdynuczARX = 0;
EdynuczOE = 0;
EdynwerARX = 0;
EdynwerOE = 0;
YmodARXucz(1:3)=ydynucz(1:3);
YmodOEucz(1:3)=ydynucz(1:3);
YmodARXwer(1:3)=ydynwer(1:3);
YmodOEwer(1:3)=ydynwer(1:3);
for i=4:k
    YmodARXucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*udynucz(i-1)^3+w(4)*udynucz(i-1)^4+w(5)*udynucz(i-1)^5+w(6)*ydynucz(i-1)+w(7)*ydynucz(i-1)^2+w(8)*ydynucz(i-1)^3+w(9)*ydynucz(i-1)^4+w(10)*ydynucz(i-1)^5;
    YmodOEucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*udynucz(i-1)^3+w(4)*udynucz(i-1)^4+w(5)*udynucz(i-1)^5+w(6)*YmodOEucz(i-1)+w(7)*YmodOEucz(i-1)^2+w(8)*YmodOEucz(i-1)^3+w(9)*YmodOEucz(i-1)^4+w(10)*YmodOEucz(i-1)^5;
    YmodARXwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*udynwer(i-1)^3+w(4)*udynwer(i-1)^4+w(5)*udynwer(i-1)^5+w(6)*ydynwer(i-1)+w(7)*ydynwer(i-1)^2+w(8)*ydynwer(i-1)^3+w(9)*ydynwer(i-1)^4+w(10)*ydynwer(i-1)^5;
    YmodOEwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*udynwer(i-1)^3+w(4)*udynwer(i-1)^4+w(5)*udynwer(i-1)^5+w(6)*YmodOEwer(i-1)+w(7)*YmodOEwer(i-1)^2+w(8)*YmodOEwer(i-1)^3+w(9)*YmodOEwer(i-1)^4+w(10)*YmodOEwer(i-1)^5;
end
for i=1:k
    EdynuczARX=EdynuczARX+(YmodARXucz(i)-ydynucz(i))^2;
    EdynwerARX=EdynwerARX+(YmodARXwer(i)-ydynwer(i))^2;
    EdynuczOE=EdynuczOE+(YmodOEucz(i)-ydynucz(i))^2;
    EdynwerOE=EdynwerOE+(YmodOEwer(i)-ydynwer(i))^2;
end

figure
tiledlayout(2,1)
ax1=nexttile;
hold on
plot(ax1,ydynucz)
plot(ax1,YmodARXucz)
title("Zbiór uczący - model ARX rzędu 1, stopień wielomianu 5. E="+EdynuczARX)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
ax2=nexttile;
hold on
plot(ax2,ydynucz)
plot(ax2,YmodOEucz)
title("Zbiór uczący - model OE rzędu 1, stopień wielomianu 5. E="+EdynuczOE)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
print('modi2_2c_wykres7.png','-dpng','-r400')

figure
tiledlayout(2,1)
ax1=nexttile;
hold on
plot(ax1,ydynwer)
plot(ax1,YmodARXwer)
title("Zbiór weryfikujący - model ARX rzędu 1, stopień wielomianu 5. E="+EdynwerARX)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
ax2=nexttile;
hold on
plot(ax2,ydynwer)
plot(ax2,YmodOEwer)
title("Zbiór weryfikujący - model OE rzędu 1, stopień wielomianu 5. E="+EdynwerOE)
xlabel("k")
ylabel("y",'HorizontalAlignment','right','Rotation',0)
hold off
print('modi2_2c_wykres8.png','-dpng','-r400')