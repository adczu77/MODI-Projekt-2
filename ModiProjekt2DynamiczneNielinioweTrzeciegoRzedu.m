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
M = [udynucz(3:k-1) udynucz(3:k-1).^2 ydynucz(3:k-1) ydynucz(3:k-1).^2 udynucz(2:k-2) udynucz(2:k-2).^2 ydynucz(2:k-2) ydynucz(2:k-2).^2 udynucz(1:k-3) udynucz(1:k-3).^2 ydynucz(1:k-3) ydynucz(1:k-3).^2];
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
    YmodARXucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*ydynucz(i-1)+w(4)*ydynucz(i-1)^2  +  w(5)*udynucz(i-2)+w(6)*udynucz(i-2)^2+w(7)*ydynucz(i-2)+w(8)*ydynucz(i-2)^2  +  w(9)*udynucz(i-3)+w(10)*udynucz(i-3)^2+w(11)*ydynucz(i-3)+w(12)*ydynucz(i-3)^2;
    YmodOEucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*YmodOEucz(i-1)+w(4)*YmodOEucz(i-1)^2  +  w(5)*udynucz(i-2)+w(6)*udynucz(i-2)^2+w(7)*YmodOEucz(i-2)+w(8)*YmodOEucz(i-2)^2  +  w(9)*udynucz(i-3)+w(10)*udynucz(i-3)^2+w(11)*YmodOEucz(i-3)+w(12)*YmodOEucz(i-3)^2;
    YmodARXwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*ydynwer(i-1)+w(4)*ydynwer(i-1)^2  +  w(5)*udynwer(i-2)+w(6)*udynwer(i-2)^2+w(7)*ydynwer(i-2)+w(8)*ydynwer(i-2)^2  +  w(9)*udynwer(i-3)+w(10)*udynwer(i-3)^2+w(11)*ydynwer(i-3)+w(12)*ydynwer(i-3)^2;
    YmodOEwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*YmodOEwer(i-1)+w(4)*YmodOEwer(i-1)^2  +  w(5)*udynwer(i-2)+w(6)*udynwer(i-2)^2+w(7)*YmodOEwer(i-2)+w(8)*YmodOEwer(i-2)^2  +  w(9)*udynwer(i-3)+w(10)*udynwer(i-3)^2+w(11)*YmodOEwer(i-3)+w(12)*YmodOEwer(i-3)^2;
end
for i=1:k
    EdynuczARX=EdynuczARX+(YmodARXucz(i)-ydynucz(i))^2;
    EdynwerARX=EdynwerARX+(YmodARXwer(i)-ydynwer(i))^2;
    EdynuczOE=EdynuczOE+(YmodOEucz(i)-ydynucz(i))^2;
    EdynwerOE=EdynwerOE+(YmodOEwer(i)-ydynwer(i))^2;
end

% figure
% tiledlayout(2,1)
% ax1=nexttile;
% hold on
% plot(ax1,ydynucz)
% plot(ax1,YmodARXucz)
% title("Zbiór uczący - model ARX rzędu 3, stopień wielomianu 2. E="+EdynuczARX)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% ax2=nexttile;
% hold on
% plot(ax2,ydynucz)
% plot(ax2,YmodOEucz)
% title("Zbiór uczący - model OE rzędu 3, stopień wielomianu 2. E="+EdynuczOE)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% %print('modi2_2c_wykres17.png','-dpng','-r400')
% 
% figure
% tiledlayout(2,1)
% ax1=nexttile;
% hold on
% plot(ax1,ydynwer)
% plot(ax1,YmodARXwer)
% title("Zbiór weryfikujący - model ARX rzędu 3, stopień wielomianu 2. E="+EdynwerARX)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% ax2=nexttile;
% hold on
% plot(ax2,ydynwer)
% plot(ax2,YmodOEwer)
% title(["Zbiór weryfikujący - model OE rzędu 3,", "stopień wielomianu 2. E=inf"])
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% %print('modi2_2c_wykres18.png','-dpng','-r400')
% 
% % stopień wielomianu n=3
% 
% k = size(ydynucz,1);
% M = [udynucz(3:k-1) udynucz(3:k-1).^2 udynucz(3:k-1).^3 ydynucz(3:k-1) ydynucz(3:k-1).^2 ydynucz(3:k-1).^3 udynucz(2:k-2) udynucz(2:k-2).^2 udynucz(2:k-2).^3 ydynucz(2:k-2) ydynucz(2:k-2).^2 ydynucz(2:k-2).^3 udynucz(1:k-3) udynucz(1:k-3).^2 udynucz(1:k-3).^3 ydynucz(1:k-3) ydynucz(1:k-3).^2 ydynucz(1:k-3).^3];
% w = M\ydynucz(4:k);
% EdynuczARX = 0;
% EdynuczOE = 0;
% EdynwerARX = 0;
% EdynwerOE = 0;
% YmodARXucz(1:3)=ydynucz(1:3);
% YmodOEucz(1:3)=ydynucz(1:3);
% YmodARXwer(1:3)=ydynwer(1:3);
% YmodOEwer(1:3)=ydynwer(1:3);
% for i=4:k
%     YmodARXucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*udynucz(i-1)^3+w(4)*ydynucz(i-1)+w(5)*ydynucz(i-1)^2+w(6)*ydynucz(i-1)^3 + w(7)*udynucz(i-2)+w(8)*udynucz(i-2)^2+w(9)*udynucz(i-2)^3+w(10)*ydynucz(i-2)+w(11)*ydynucz(i-2)^2+w(12)*ydynucz(i-2)^3  +  w(13)*udynucz(i-3)+w(14)*udynucz(i-3)^2+w(15)*udynucz(i-3)^3+w(16)*ydynucz(i-3)+w(17)*ydynucz(i-3)^2+w(18)*ydynucz(i-3)^3;
%     YmodOEucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*udynucz(i-1)^3+w(4)*YmodOEucz(i-1)+w(5)*YmodOEucz(i-1)^2+w(6)*YmodOEucz(i-1)^3 + w(7)*udynucz(i-2)+w(8)*udynucz(i-2)^2+w(9)*udynucz(i-2)^3+w(10)*YmodOEucz(i-2)+w(11)*YmodOEucz(i-2)^2+w(12)*YmodOEucz(i-2)^3  +  w(13)*udynucz(i-3)+w(14)*udynucz(i-3)^2+w(15)*udynucz(i-3)^3+w(16)*YmodOEucz(i-3)+w(17)*YmodOEucz(i-3)^2+w(18)*YmodOEucz(i-3)^3;
%     YmodARXwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*udynwer(i-1)^3+w(4)*ydynwer(i-1)+w(5)*ydynwer(i-1)^2+w(6)*ydynwer(i-1)^3 + w(7)*udynwer(i-2)+w(8)*udynwer(i-2)^2+w(9)*udynwer(i-2)^3+w(10)*ydynwer(i-2)+w(11)*ydynwer(i-2)^2+w(12)*ydynwer(i-2)^3  +  w(13)*udynwer(i-3)+w(14)*udynwer(i-3)^2+w(15)*udynwer(i-3)^3+w(16)*ydynwer(i-3)+w(17)*ydynwer(i-3)^2+w(18)*ydynwer(i-3)^3;
%     YmodOEwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*udynwer(i-1)^3+w(4)*YmodOEwer(i-1)+w(5)*YmodOEwer(i-1)^2+w(6)*YmodOEwer(i-1)^3 + w(7)*udynwer(i-2)+w(8)*udynwer(i-2)^2+w(9)*udynwer(i-2)^3+w(10)*YmodOEwer(i-2)+w(11)*YmodOEwer(i-2)^2+w(12)*YmodOEwer(i-2)^3  +  w(13)*udynwer(i-3)+w(14)*udynwer(i-3)^2+w(15)*udynwer(i-3)^3+w(16)*YmodOEwer(i-3)+w(17)*YmodOEwer(i-3)^2+w(18)*YmodOEwer(i-3)^3;
% end
% for i=1:k
%     EdynuczARX=EdynuczARX+(YmodARXucz(i)-ydynucz(i))^2;
%     EdynwerARX=EdynwerARX+(YmodARXwer(i)-ydynwer(i))^2;
%     EdynuczOE=EdynuczOE+(YmodOEucz(i)-ydynucz(i))^2;
%     EdynwerOE=EdynwerOE+(YmodOEwer(i)-ydynwer(i))^2;
% end
% 
% figure
% tiledlayout(2,1)
% ax1=nexttile;
% hold on
% plot(ax1,ydynucz)
% plot(ax1,YmodARXucz)
% title("Zbiór uczący - model ARX rzędu 3, stopień wielomianu 3. E="+EdynuczARX)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% ax2=nexttile;
% hold on
% plot(ax2,ydynucz)
% plot(ax2,YmodOEucz)
% title("Zbiór uczący - model OE rzędu 3, stopień wielomianu 3. E="+EdynuczOE)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% %print('modi2_2c_wykres19.png','-dpng','-r400')
% 
% figure
% tiledlayout(2,1)
% ax1=nexttile;
% hold on
% plot(ax1,ydynwer)
% plot(ax1,YmodARXwer)
% title("Zbiór weryfikujący - model ARX rzędu 3, stopień wielomianu 3. E="+EdynwerARX)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% ax2=nexttile;
% hold on
% plot(ax2,ydynwer)
% plot(ax2,YmodOEwer)
% title("Zbiór weryfikujący - model OE rzędu 3, stopień wielomianu 3. E="+EdynwerOE)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% %print('modi2_2c_wykres20.png','-dpng','-r400')
% 
% % stopień wielomianu n=4
% 
% k = size(ydynucz,1);
% M = [udynucz(3:k-1) udynucz(3:k-1).^2 udynucz(3:k-1).^3 udynucz(3:k-1).^4 ydynucz(3:k-1) ydynucz(3:k-1).^2 ydynucz(3:k-1).^3 ydynucz(3:k-1).^4 udynucz(2:k-2) udynucz(2:k-2).^2 udynucz(2:k-2).^3 udynucz(2:k-2).^4 ydynucz(2:k-2) ydynucz(2:k-2).^2 ydynucz(2:k-2).^3 ydynucz(2:k-2).^4 udynucz(1:k-3) udynucz(1:k-3).^2 udynucz(1:k-3).^3 udynucz(1:k-3).^4 ydynucz(1:k-3) ydynucz(1:k-3).^2 ydynucz(1:k-3).^3 ydynucz(1:k-3).^4];
% w = M\ydynucz(4:k);
% EdynuczARX = 0;
% EdynuczOE = 0;
% EdynwerARX = 0;
% EdynwerOE = 0;
% YmodARXucz(1:3)=ydynucz(1:3);
% YmodOEucz(1:3)=ydynucz(1:3);
% YmodARXwer(1:3)=ydynwer(1:3);
% YmodOEwer(1:3)=ydynwer(1:3);
% for i=4:k
%     YmodARXucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*udynucz(i-1)^3+w(4)*udynucz(i-1)^4+w(5)*ydynucz(i-1)+w(6)*ydynucz(i-1)^2+w(7)*ydynucz(i-1)^3+w(8)*ydynucz(i-1)^4  +  w(9)*udynucz(i-2)+w(10)*udynucz(i-2)^2+w(11)*udynucz(i-2)^3+w(12)*udynucz(i-2)^4+w(13)*ydynucz(i-2)+w(14)*ydynucz(i-2)^2+w(15)*ydynucz(i-2)^3+w(16)*ydynucz(i-2)^4  +  w(17)*udynucz(i-3)+w(18)*udynucz(i-3)^2+w(19)*udynucz(i-3)^3+w(20)*udynucz(i-3)^4+w(21)*ydynucz(i-3)+w(22)*ydynucz(i-3)^2+w(23)*ydynucz(i-3)^3+w(24)*ydynucz(i-3)^4;
%     YmodOEucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*udynucz(i-1)^3+w(4)*udynucz(i-1)^4+w(5)*YmodOEucz(i-1)+w(6)*YmodOEucz(i-1)^2+w(7)*YmodOEucz(i-1)^3+w(8)*YmodOEucz(i-1)^4  +  w(9)*udynucz(i-2)+w(10)*udynucz(i-2)^2+w(11)*udynucz(i-2)^3+w(12)*udynucz(i-2)^4+w(13)*YmodOEucz(i-2)+w(14)*YmodOEucz(i-2)^2+w(15)*YmodOEucz(i-2)^3+w(16)*YmodOEucz(i-2)^4  +  w(17)*udynucz(i-3)+w(18)*udynucz(i-3)^2+w(19)*udynucz(i-3)^3+w(20)*udynucz(i-3)^4+w(21)*YmodOEucz(i-3)+w(22)*YmodOEucz(i-3)^2+w(23)*YmodOEucz(i-3)^3+w(24)*YmodOEucz(i-3)^4;
%     YmodARXwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*udynwer(i-1)^3+w(4)*udynwer(i-1)^4+w(5)*ydynwer(i-1)+w(6)*ydynwer(i-1)^2+w(7)*ydynwer(i-1)^3+w(8)*ydynwer(i-1)^4  +  w(9)*udynwer(i-2)+w(10)*udynwer(i-2)^2+w(11)*udynwer(i-2)^3+w(12)*udynwer(i-2)^4+w(13)*ydynwer(i-2)+w(14)*ydynwer(i-2)^2+w(15)*ydynwer(i-2)^3+w(16)*ydynwer(i-2)^4  +  w(17)*udynwer(i-3)+w(18)*udynwer(i-3)^2+w(19)*udynwer(i-3)^3+w(20)*udynwer(i-3)^4+w(21)*ydynwer(i-3)+w(22)*ydynwer(i-3)^2+w(23)*ydynwer(i-3)^3+w(24)*ydynwer(i-3)^4;
%     YmodOEwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*udynwer(i-1)^3+w(4)*udynwer(i-1)^4+w(5)*YmodOEwer(i-1)+w(6)*YmodOEwer(i-1)^2+w(7)*YmodOEwer(i-1)^3+w(8)*YmodOEwer(i-1)^4  +  w(9)*udynwer(i-2)+w(10)*udynwer(i-2)^2+w(11)*udynwer(i-2)^3+w(12)*udynwer(i-2)^4+w(13)*YmodOEwer(i-2)+w(14)*YmodOEwer(i-2)^2+w(15)*YmodOEwer(i-2)^3+w(16)*YmodOEwer(i-2)^4  +  w(17)*udynwer(i-3)+w(18)*udynwer(i-3)^2+w(19)*udynwer(i-3)^3+w(20)*udynwer(i-3)^4+w(23)*YmodOEwer(i-3)+w(22)*YmodOEwer(i-3)^2+w(23)*YmodOEwer(i-3)^3+w(24)*YmodOEwer(i-3)^4;
% end
% for i=1:k
%     EdynuczARX=EdynuczARX+(YmodARXucz(i)-ydynucz(i))^2;
%     EdynwerARX=EdynwerARX+(YmodARXwer(i)-ydynwer(i))^2;
%     EdynuczOE=EdynuczOE+(YmodOEucz(i)-ydynucz(i))^2;
%     EdynwerOE=EdynwerOE+(YmodOEwer(i)-ydynwer(i))^2;
% end
% 
% figure
% tiledlayout(2,1)
% ax1=nexttile;
% hold on
% plot(ax1,ydynucz)
% plot(ax1,YmodARXucz)
% title("Zbiór uczący - model ARX rzędu 3, stopień wielomianu 4. E="+EdynuczARX)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% ax2=nexttile;
% hold on
% plot(ax2,ydynucz)
% plot(ax2,YmodOEucz)
% title("Zbiór uczący - model OE rzędu 3, stopień wielomianu 4. E="+EdynuczOE)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% %print('modi2_2c_wykres21.png','-dpng','-r400')
% 
% figure
% tiledlayout(2,1)
% ax1=nexttile;
% hold on
% plot(ax1,ydynwer)
% plot(ax1,YmodARXwer)
% title("Zbiór weryfikujący - model ARX rzędu 3, stopień wielomianu 4. E="+EdynwerARX)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% ax2=nexttile;
% hold on
% plot(ax2,ydynwer)
% plot(ax2,YmodOEwer)
% title(["Zbiór weryfikujący - model OE rzędu 3,", "stopień wielomianu 4. E=inf"])
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% %print('modi2_2c_wykres22.png','-dpng','-r400')
% 
% % stopień wielomianu n=5
% 
% k = size(ydynucz,1);
% M = [udynucz(3:k-1) udynucz(3:k-1).^2 udynucz(3:k-1).^3 udynucz(3:k-1).^4 udynucz(3:k-1).^5 ydynucz(3:k-1) ydynucz(3:k-1).^2 ydynucz(3:k-1).^3 ydynucz(3:k-1).^4 ydynucz(3:k-1).^5 udynucz(2:k-2) udynucz(2:k-2).^2 udynucz(2:k-2).^3 udynucz(2:k-2).^4 udynucz(2:k-2).^5 ydynucz(2:k-2) ydynucz(2:k-2).^2 ydynucz(2:k-2).^3 ydynucz(2:k-2).^4 ydynucz(2:k-2).^5 udynucz(1:k-3) udynucz(1:k-3).^2 udynucz(1:k-3).^3 udynucz(1:k-3).^4 udynucz(1:k-3).^5 ydynucz(1:k-3) ydynucz(1:k-3).^2 ydynucz(1:k-3).^3 ydynucz(1:k-3).^4 ydynucz(1:k-3).^5];
% w = M\ydynucz(4:k);
% EdynuczARX = 0;
% EdynuczOE = 0;
% EdynwerARX = 0;
% EdynwerOE = 0;
% YmodARXucz(1:3)=ydynucz(1:3);
% YmodOEucz(1:3)=ydynucz(1:3);
% YmodARXwer(1:3)=ydynwer(1:3);
% YmodOEwer(1:3)=ydynwer(1:3);
% for i=4:k
%     YmodARXucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*udynucz(i-1)^3+w(4)*udynucz(i-1)^4+w(5)*udynucz(i-1)^5+w(6)*ydynucz(i-1)+w(7)*ydynucz(i-1)^2+w(8)*ydynucz(i-1)^3+w(9)*ydynucz(i-1)^4+w(10)*ydynucz(i-1)^5  +  w(11)*udynucz(i-2)+w(12)*udynucz(i-2)^2+w(13)*udynucz(i-2)^3+w(14)*udynucz(i-2)^4+w(15)*udynucz(i-2)^5+w(16)*ydynucz(i-2)+w(17)*ydynucz(i-2)^2+w(18)*ydynucz(i-2)^3+w(19)*ydynucz(i-2)^4+w(20)*ydynucz(i-2)^5  +  w(21)*udynucz(i-3)+w(22)*udynucz(i-3)^2+w(23)*udynucz(i-3)^3+w(24)*udynucz(i-3)^4+w(25)*udynucz(i-3)^5+w(26)*ydynucz(i-3)+w(27)*ydynucz(i-3)^2+w(28)*ydynucz(i-3)^3+w(29)*ydynucz(i-3)^4+w(30)*ydynucz(i-3)^5;
%     YmodOEucz(i)=w(1)*udynucz(i-1)+w(2)*udynucz(i-1)^2+w(3)*udynucz(i-1)^3+w(4)*udynucz(i-1)^4+w(5)*udynucz(i-1)^5+w(6)*YmodOEucz(i-1)+w(7)*YmodOEucz(i-1)^2+w(8)*YmodOEucz(i-1)^3+w(9)*YmodOEucz(i-1)^4+w(10)*YmodOEucz(i-1)^5  +  w(11)*udynucz(i-2)+w(12)*udynucz(i-2)^2+w(13)*udynucz(i-2)^3+w(14)*udynucz(i-2)^4+w(15)*udynucz(i-2)^5+w(16)*YmodOEucz(i-2)+w(17)*YmodOEucz(i-2)^2+w(18)*YmodOEucz(i-2)^3+w(19)*YmodOEucz(i-2)^4+w(20)*YmodOEucz(i-2)^5  +  w(21)*udynucz(i-3)+w(22)*udynucz(i-3)^2+w(23)*udynucz(i-3)^3+w(24)*udynucz(i-3)^4+w(25)*udynucz(i-3)^5+w(26)*YmodOEucz(i-3)+w(27)*YmodOEucz(i-3)^2+w(28)*YmodOEucz(i-3)^3+w(29)*YmodOEucz(i-3)^4+w(30)*YmodOEucz(i-3)^5;
%     YmodARXwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*udynwer(i-1)^3+w(4)*udynwer(i-1)^4+w(5)*udynwer(i-1)^5+w(6)*ydynwer(i-1)+w(7)*ydynwer(i-1)^2+w(8)*ydynwer(i-1)^3+w(9)*ydynwer(i-1)^4+w(10)*ydynwer(i-1)^5  +  w(11)*udynwer(i-2)+w(12)*udynwer(i-2)^2+w(13)*udynwer(i-2)^3+w(14)*udynwer(i-2)^4+w(15)*udynwer(i-2)^5+w(16)*ydynwer(i-2)+w(17)*ydynwer(i-2)^2+w(18)*ydynwer(i-2)^3+w(19)*ydynwer(i-2)^4+w(20)*ydynwer(i-2)^5  +  w(21)*udynwer(i-3)+w(22)*udynwer(i-3)^2+w(23)*udynwer(i-3)^3+w(24)*udynwer(i-3)^4+w(25)*udynwer(i-3)^5+w(26)*ydynwer(i-3)+w(27)*ydynwer(i-3)^2+w(28)*ydynwer(i-3)^3+w(29)*ydynwer(i-3)^4+w(30)*ydynwer(i-3)^5;
%     YmodOEwer(i)=w(1)*udynwer(i-1)+w(2)*udynwer(i-1)^2+w(3)*udynwer(i-1)^3+w(4)*udynwer(i-1)^4+w(5)*udynwer(i-1)^5+w(6)*YmodOEwer(i-1)+w(7)*YmodOEwer(i-1)^2+w(8)*YmodOEwer(i-1)^3+w(9)*YmodOEwer(i-1)^4+w(10)*YmodOEwer(i-1)^5  +  w(11)*udynwer(i-2)+w(12)*udynwer(i-2)^2+w(13)*udynwer(i-2)^3+w(14)*udynwer(i-2)^4+w(15)*udynwer(i-2)^5+w(16)*YmodOEwer(i-2)+w(17)*YmodOEwer(i-2)^2+w(18)*YmodOEwer(i-2)^3+w(19)*YmodOEwer(i-2)^4+w(20)*YmodOEwer(i-2)^5  +  w(21)*udynwer(i-3)+w(22)*udynwer(i-3)^2+w(23)*udynwer(i-3)^3+w(24)*udynwer(i-3)^4+w(25)*udynwer(i-3)^5+w(26)*YmodOEwer(i-3)+w(27)*YmodOEwer(i-3)^2+w(28)*YmodOEwer(i-3)^3+w(29)*YmodOEwer(i-3)^4+w(30)*YmodOEwer(i-3)^5;
% end
% for i=1:k
%     EdynuczARX=EdynuczARX+(YmodARXucz(i)-ydynucz(i))^2;
%     EdynwerARX=EdynwerARX+(YmodARXwer(i)-ydynwer(i))^2;
%     EdynuczOE=EdynuczOE+(YmodOEucz(i)-ydynucz(i))^2;
%     EdynwerOE=EdynwerOE+(YmodOEwer(i)-ydynwer(i))^2;
% end
% 
% figure
% tiledlayout(2,1)
% ax1=nexttile;
% hold on
% plot(ax1,ydynucz)
% plot(ax1,YmodARXucz)
% title("Zbiór uczący - model ARX rzędu 3, stopień wielomianu 5. E="+EdynuczARX)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% ax2=nexttile;
% hold on
% plot(ax2,ydynucz)
% plot(ax2,YmodOEucz)
% title("Zbiór uczący - model OE rzędu 3, stopień wielomianu 5. E="+EdynuczOE)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% %print('modi2_2c_wykres23.png','-dpng','-r400')
% 
% figure
% tiledlayout(2,1)
% ax1=nexttile;
% hold on
% plot(ax1,ydynwer)
% plot(ax1,YmodARXwer)
% title("Zbiór weryfikujący - model ARX rzędu 3, stopień wielomianu 5. E="+EdynwerARX)
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% ax2=nexttile;
% hold on
% plot(ax2,ydynwer)
% plot(ax2,YmodOEwer)
% title(["Zbiór weryfikujący - model OE rzędu 3,", "stopień wielomianu 5. E=inf"])
% xlabel("k")
% ylabel("y",'HorizontalAlignment','right','Rotation',0)
% hold off
% %print('modi2_2c_wykres24.png','-dpng','-r400')