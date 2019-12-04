clear;
clc;

xlim=[0,1];
ylim=[0,1];
axis equal;


x = (0:1/255:1);
ib = x+0.4;

ib(ib>1) = 1;
ib(ib<0) = 0;

plot(x,ib)
xlabel('Pierwotna wartość piksela');
ylabel('Nowa wartość piksela');
title('Wykres przekształcenia dla zmiany jasności');
saveas(gcf,sprintf('wykres_przeksztalcenia_jasnosci.png',i));

ic = x * 1.85;
ic(ic>1) = 1;
ic(ic<0) = 0;
plot(x,ic);
xlabel('Pierwotna wartość piksela');
ylabel('Nowa wartość piksela');
title('Wykres przekształcenia dla zmiany kontrastu');
saveas(gcf,sprintf('wykres_przeksztalcenia_kontrastu.png',i));

ig = x .^ 2.2;
ig(ig>1) = 1;
ig(ig<0) = 0;
plot(x,ig);
xlabel('Pierwotna wartość piksela');
ylabel('Nowa wartość piksela');
title('Wykres przekształcenia dla zmiany gammy');
saveas(gcf,sprintf('wykres_przeksztalcenia_gamma.png',i));



