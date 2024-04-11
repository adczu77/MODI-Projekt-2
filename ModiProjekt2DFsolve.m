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

u=(-1:0.001:1);
y=[];
for i=1:length(u)
    x0=0;
    y(i) = fsolve(Fun(u(i),w),x0);
end

plot(u,y);
title("Statyczny model nieliniowy y(u) wybranego wielomianu:")
xlabel("u");
ylabel("y",'HorizontalAlignment','right','Rotation',0)
legend('y(u)')
print('modi2_2d_wykres1.png','-dpng','-r400')

function F = Fun(u,w)
    F = @(y) w(1)*u+w(2)*u^2+w(3)*y+w(4)*y^2+w(5)*u+w(6)*u^2+w(7)*y+w(8)*y^2+w(9)*u+w(10)*u^2+w(11)*y+w(12)*y^2-y;
end