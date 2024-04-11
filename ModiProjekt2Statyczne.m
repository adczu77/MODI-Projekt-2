%Uporządkowanie danych:
clear;
filename = 'danestat41.txt';
delimiterIn = ' ';
headerlinesIn = 0;
DaneStat = importdata(filename,delimiterIn,headerlinesIn);

A = DaneStat(:,1);
B = DaneStat(:,2);
[A,idx]=sort(A,'descend');
B=B(idx);
DaneStat(:,1) = A;
DaneStat(:,2) = B;

DaneStatUcz = [];
DaneStatWer = [];

ustat = DaneStat(:,1);
ystat = DaneStat(:,2);

% Wykresy dla zbioru uczącego i weryfikującego:

figure
plot(ustat,ystat,'.b');
xlabel('u_{stat}');
ylabel('y_{stat}','Rotation',0,'HorizontalAlignment','right');
title('Dane statyczne:');
legend('Pojedyńcza próbka danych.')
print('modi2_1a_wykres1.png','-dpng','-r400')

DaneStatWer(:,1)=ustat(2:2:end);
DaneStatWer(:,2)=ystat(2:2:end);
DaneStatUcz(:,1)=(ustat(1:2:end));
DaneStatUcz(:,2)=(ystat(1:2:end));

ustatucz = DaneStatUcz(:,1);
ystatucz = DaneStatUcz(:,2);
ustatwer = DaneStatWer(:,1);
ystatwer = DaneStatWer(:,2);
Y = ystatucz;
U = ustatucz;

figure
plot(ustatucz, ystatucz,'.b');
xlabel('u_{stat}');
ylabel('y_{stat}','Rotation',0,'HorizontalAlignment','right');
title('Dane statyczne (zbiór uczący):');
legend('Pojedyńcza próbka danych.')
print('modi2_1a_wykres2.png','-dpng','-r400')

figure
plot(ustatwer,ystatwer,'.b');
xlabel('u_{stat}');
ylabel('y_{stat}','Rotation',0,'HorizontalAlignment','right');
title('Dane statyczne (zbiór weryfikujący):');
legend('Pojedyńcza próbka danych.')
print('modi2_1a_wykres3.png','-dpng','-r400')

Ymod = zeros(size(ustat,1),1);

%MODEL STATYCZNY N=1:

M = ones(size(ustatucz,1),size(ustatucz,2));
M(:,2) = U;
w = M\Y;


for i=1:size(ystat)
    Ymod(i)=w(1)+w(2)*ustat(i);
end

figure
plot(ustat,Ymod)
xlabel('u_{stat}');
ylabel('y_{mod stat}','Rotation',0,'HorizontalAlignment','right');
ylim([-1 5])
title('Statyczny model liniowy:');
legend('y=a_0+a_1u')
print('modi2_1b_wykres1.png','-dpng','-r400')

Estatucz=0;
Estatwer=0;

for i = 1:size(ystat)
    if(mod(i,2)==0)
        Estatwer=Estatwer+(Ymod(i)-ystat(i))^2;
    else
        Estatucz=Estatucz+(Ymod(i)-ystat(i))^2;
    end
end


figure
hold on
plot(ustatucz,ystatucz,'.b')
plot(ustat,Ymod)
xlabel('u_{stat ucz}');
ylabel({'y_{stat ucz}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title("Statyczny model liniowy na tle zbioru uczącego E="+Estatucz+":")
legend('Zbiór uczący.', 'Wyjście modelu.')
print('modi2_1b_wykres2.png','-dpng','-r400')
hold off

figure
hold on
plot(ustatwer,ystatwer,'.b')
plot(ustat,Ymod)
xlabel('u_{stat wer}');
ylabel({'y_{stat wer}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title("Statyczny model liniowy na tle zbioru weryfikującego E="+Estatwer+":")
legend('Zbiór weryfikujący.', 'Wyjście modelu.')
print('modi2_1b_wykres3.png','-dpng','-r400')
hold off

%MODEL STATYCZNY N=2:

M(:,3) = U.^2;
w = M\Y;

for i=1:size(ystat)
    Ymod(i)=w(1)+w(2)*ustat(i)+w(3)*ustat(i)^2;
end


Estatucz=0;
Estatwer=0;

for i = 1:size(ystat)
    if(mod(i,2)==0)
        Estatwer=Estatwer+(Ymod(i)-ystat(i))^2;
    else
        Estatucz=Estatucz+(Ymod(i)-ystat(i))^2;
    end
end

figure
plot(ustat,Ymod)
xlabel('u_{stat}');
ylabel('y_{mod stat}','Rotation',0,'HorizontalAlignment','right');
ylim([-1 5])
title('Statyczny model nieliniowy (wielomian stonia N=2):');
legend('y=a_0+a_1u+a_2u^2')
print('modi2_1c_wykres1.png','-dpng','-r400')

figure
hold on
plot(ustatucz,ystatucz,'.b')
plot(ustat,Ymod)
xlabel('u_{stat ucz}');
ylabel({'y_{stat ucz}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=2) na tle", "zbioru uczącego E="+Estatucz+":"})
legend('Zbiór uczący.', 'Wyjście modelu.')
print('modi2_1c_wykres2.png','-dpng','-r400')
hold off

figure
hold on
plot(ustatwer,ystatwer,'.b')
plot(ustat,Ymod)
xlabel('u_{stat wer}');
ylabel({'y_{stat wer}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=2) na tle", "zbioru weryfikującego E="+Estatwer+":"})
legend('Zbiór weryfikujący.', 'Wyjście modelu.')
print('modi2_1c_wykres3.png','-dpng','-r400')
hold off

%MODEL STATYCZNY N=3:

M(:,4) = U.^3;
w = M\Y;

for i=1:size(ystat)
    Ymod(i)=w(1)+w(2)*ustat(i)+w(3)*ustat(i)^2+w(4)*ustat(i)^3;
end

Estatucz=0;
Estatwer=0;

for i = 1:size(ystat)
    if(mod(i,2)==0)
        Estatwer=Estatwer+(Ymod(i)-ystat(i))^2;
    else
        Estatucz=Estatucz+(Ymod(i)-ystat(i))^2;
    end
end

figure
plot(ustat,Ymod)
xlabel('u_{stat}');
ylabel('y_{mod stat}','Rotation',0,'HorizontalAlignment','right');
ylim([-1 5])
title('Statyczny model nieliniowy (wielomian stonia N=3):');
legend('y=a_0+a_1u+a_2u^2+a_3u^3')
print('modi2_1c_wykres4.png','-dpng','-r400')

figure
hold on
plot(ustatucz,ystatucz,'.b')
plot(ustat,Ymod)
xlabel('u_{stat ucz}');
ylabel({'y_{stat ucz}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=3) na tle", "zbioru uczącego E="+Estatucz+":"})
legend('Zbiór uczący.', 'Wyjście modelu.')
print('modi2_1c_wykres5.png','-dpng','-r400')
hold off

figure
hold on
plot(ustatwer,ystatwer,'.b')
plot(ustat,Ymod)
xlabel('u_{stat wer}');
ylabel({'y_{stat wer}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=3) na tle", "zbioru weryfikującego E="+Estatwer+":"})
legend('Zbiór weryfikujący.', 'Wyjście modelu.')
print('modi2_1c_wykres6.png','-dpng','-r400')
hold off

%MODEL STATYCZNY N=4:

M(:,5) = U.^4;
w = M\Y;

for i=1:size(ystat)
    Ymod(i)=w(1)+w(2)*ustat(i)+w(3)*ustat(i)^2+w(4)*ustat(i)^3+w(5)*ustat(i)^4;
end

Estatucz=0;
Estatwer=0;

for i = 1:size(ystat)
    if(mod(i,2)==0)
        Estatwer=Estatwer+(Ymod(i)-ystat(i))^2;
    else
        Estatucz=Estatucz+(Ymod(i)-ystat(i))^2;
    end
end

figure
plot(ustat,Ymod)
xlabel('u_{stat}');
ylabel('y_{mod stat}','Rotation',0,'HorizontalAlignment','right');
ylim([-1 5])
title('Statyczny model nieliniowy (wielomian stonia N=4):');
legend('y=a_0+a_1u+a_2u^2+a_3u^3+a_4u^4')
print('modi2_1c_wykres7.png','-dpng','-r400')

figure
hold on
plot(ustatucz,ystatucz,'.b')
plot(ustat,Ymod)
xlabel('u_{stat ucz}');
ylabel({'y_{stat ucz}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=4) na tle", "zbioru uczącego E="+Estatucz+":"})
legend('Zbiór uczący.', 'Wyjście modelu.')
print('modi2_1c_wykres8.png','-dpng','-r400')
hold off

figure
hold on
plot(ustatwer,ystatwer,'.b')
plot(ustat,Ymod)
xlabel('u_{stat wer}');
ylabel({'y_{stat wer}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=4) na tle", "zbioru weryfikującego E="+Estatwer+":"})
legend('Zbiór weryfikujący.', 'Wyjście modelu.')
print('modi2_1c_wykres9.png','-dpng','-r400')
hold off

%MODEL STATYCZNY N=5:

M(:,6) = U.^5;
w = M\Y;

for i=1:size(ystat)
    Ymod(i)=w(1)+w(2)*ustat(i)+w(3)*ustat(i)^2+w(4)*ustat(i)^3+w(5)*ustat(i)^4+w(6)*ustat(i)^5;
end

Estatucz=0;
Estatwer=0;

for i = 1:size(ystat)
    if(mod(i,2)==0)
        Estatwer=Estatwer+(Ymod(i)-ystat(i))^2;
    else
        Estatucz=Estatucz+(Ymod(i)-ystat(i))^2;
    end
end

figure
plot(ustat,Ymod)
xlabel('u_{stat}');
ylabel('y_{mod stat}','Rotation',0,'HorizontalAlignment','right');
ylim([-1 5])
title('Statyczny model nieliniowy (wielomian stonia N=5):');
legend('y=a_0+a_1u+a_2u^2+a_3u^3+a_4u^4+a_5u^5')
print('modi2_1c_wykres10.png','-dpng','-r400')

figure
hold on
plot(ustatucz,ystatucz,'.b')
plot(ustat,Ymod)
xlabel('u_{stat ucz}');
ylabel({'y_{stat ucz}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=5) na tle", "zbioru uczącego E="+Estatucz+":"})
legend('Zbiór uczący.', 'Wyjście modelu.')
print('modi2_1c_wykres11.png','-dpng','-r400')
hold off

figure
hold on
plot(ustatwer,ystatwer,'.b')
plot(ustat,Ymod)
xlabel('u_{stat wer}');
ylabel({'y_{stat wer}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=5) na tle", "zbioru weryfikującego E="+Estatwer+":"})
legend('Zbiór weryfikujący.', 'Wyjście modelu.')
print('modi2_1c_wykres12.png','-dpng','-r400')
hold off

%MODEL STATYCZNY N=6:

M(:,7) = U.^6;
w = M\Y;

for i=1:size(ystat)
    Ymod(i)=w(1)+w(2)*ustat(i)+w(3)*ustat(i)^2+w(4)*ustat(i)^3+w(5)*ustat(i)^4+w(6)*ustat(i)^5+w(7)*ustat(i)^6;
end

Estatucz=0;
Estatwer=0;

for i = 1:size(ystat)
    if(mod(i,2)==0)
        Estatwer=Estatwer+(Ymod(i)-ystat(i))^2;
    else
        Estatucz=Estatucz+(Ymod(i)-ystat(i))^2;
    end
end

figure
plot(ustat,Ymod)
xlabel('u_{stat}');
ylabel('y_{mod stat}','Rotation',0,'HorizontalAlignment','right');
ylim([-1 5])
title('Statyczny model nieliniowy (wielomian stonia N=6):');
legend('y=a_0+a_1u+a_2u^2+a_3u^3+a_4u^4+a_5u^5+a_6u^6')
print('modi2_1c_wykres13.png','-dpng','-r400')

figure
hold on
plot(ustatucz,ystatucz,'.b')
plot(ustat,Ymod)
xlabel('u_{stat ucz}');
ylabel({'y_{stat ucz}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=6) na tle", "zbioru uczącego E="+Estatucz+":"})
legend('Zbiór uczący.', 'Wyjście modelu.')
print('modi2_1c_wykres14.png','-dpng','-r400')
hold off

figure
hold on
plot(ustatwer,ystatwer,'.b')
plot(ustat,Ymod)
xlabel('u_{stat wer}');
ylabel({'y_{stat wer}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=6) na tle", "zbioru weryfikującego E="+Estatwer+":"})
legend('Zbiór weryfikujący.', 'Wyjście modelu.')
print('modi2_1c_wykres15.png','-dpng','-r400')
hold off

%MODEL STATYCZNY N=7:

M(:,8) = U.^7;
w = M\Y;

for i=1:size(ystat)
    Ymod(i)=w(1)+w(2)*ustat(i)+w(3)*ustat(i)^2+w(4)*ustat(i)^3+w(5)*ustat(i)^4+w(6)*ustat(i)^5+w(7)*ustat(i)^6+w(8)*ustat(i)^7;
end

Estatucz=0;
Estatwer=0;

for i = 1:size(ystat)
    if(mod(i,2)==0)
        Estatwer=Estatwer+(Ymod(i)-ystat(i))^2;
    else
        Estatucz=Estatucz+(Ymod(i)-ystat(i))^2;
    end
end

figure
plot(ustat,Ymod)
xlabel('u_{stat}');
ylabel('y_{mod stat}','Rotation',0,'HorizontalAlignment','right');
ylim([-1 5])
title('Statyczny model nieliniowy (wielomian stonia N=7):');
legend('y=a_0+a_1u+a_2u^2+a_3u^3+a_4u^4+a_5u^5+a_6u^6+a_7u^7')
print('modi2_1c_wykres16.png','-dpng','-r400')

figure
hold on
plot(ustatucz,ystatucz,'.b')
plot(ustat,Ymod)
xlabel('u_{stat ucz}');
ylabel({'y_{stat ucz}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=7) na tle", "zbioru uczącego E="+Estatucz+":"})
legend('Zbiór uczący.', 'Wyjście modelu.')
print('modi2_1c_wykres17.png','-dpng','-r400')
hold off

figure
hold on
plot(ustatwer,ystatwer,'.b')
plot(ustat,Ymod)
xlabel('u_{stat wer}');
ylabel({'y_{stat wer}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=7) na tle", "zbioru weryfikującego E="+Estatwer+":"})
legend('Zbiór weryfikujący.', 'Wyjście modelu.')
print('modi2_1c_wykres18.png','-dpng','-r400')
hold off

%MODEL STATYCZNY N=8:

M(:,9) = U.^8;
w = M\Y;

for i=1:size(ystat)
    Ymod(i)=w(1)+w(2)*ustat(i)+w(3)*ustat(i)^2+w(4)*ustat(i)^3+w(5)*ustat(i)^4+w(6)*ustat(i)^5+w(7)*ustat(i)^6+w(8)*ustat(i)^7+w(9)*ustat(i)^8;
end

Estatucz=0;
Estatwer=0;

for i = 1:size(ystat)
    if(mod(i,2)==0)
        Estatwer=Estatwer+(Ymod(i)-ystat(i))^2;
    else
        Estatucz=Estatucz+(Ymod(i)-ystat(i))^2;
    end
end

figure
plot(ustat,Ymod)
xlabel('u_{stat}');
ylabel('y_{mod stat}','Rotation',0,'HorizontalAlignment','right');
ylim([-1 5])
title('Statyczny model nieliniowy (wielomian stonia N=8):');
legend('y=a_0+a_1u+a_2u^2+a_3u^3+a_4u^4+a_5u^5+a_6u^6+a_7u^7+a_8u^8')
print('modi2_1c_wykres19.png','-dpng','-r400')

figure
hold on
plot(ustatucz,ystatucz,'.b')
plot(ustat,Ymod)
xlabel('u_{stat ucz}');
ylabel({'y_{stat ucz}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=8) na tle", "zbioru uczącego E="+Estatucz+":"})
legend('Zbiór uczący.', 'Wyjście modelu.')
print('modi2_1c_wykres20.png','-dpng','-r400')
hold off

figure
hold on
plot(ustatwer,ystatwer,'.b')
plot(ustat,Ymod)
xlabel('u_{stat wer}');
ylabel({'y_{stat wer}','y_{mod stat}'},'Rotation',0,'HorizontalAlignment','right');
title({"Statyczny model nieliniowy (wielomian N=8) na tle", "zbioru weryfikującego E="+Estatwer+":"})
legend('Zbiór weryfikujący.', 'Wyjście modelu.')
print('modi2_1c_wykres21.png','-dpng','-r400')
hold off