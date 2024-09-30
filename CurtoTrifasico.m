
format shortEng

%Circuito: sistema equivalente
%trafo elevador, 3 linhas em malha,

%%
% Dados de entrada
Sb = 100*1e6; %100 MVA
Vb1 = 138000; %kV
Vb2 = 13800;
%sistema equivalente

X1seq = 6.6i; %reatancia do sistema equivalente 
X0seq = 5.7i;
Vat = 138000*1.02; %tensão de operação 1.02 pu 

%% trafo 1 - ligação delta-y aterrado
V1tn1 = 138000; %Tensão nominal - conexão com o sistema equivalente
V2tn1 = 13800; %conexão com a linha
V1t1 = Vat; 
%abaixo ja adciono a defasagem de -30 devido a conexão delta estrela
V2t1 = Vat*V2tn1/V1tn1*exp(-30i*pi/180); %tensão de operação no secundario
xt1 = 0.05i; %reatancia de curto circuito do transformador em pu na base do trafo
St1 = 10*1e6; % potencia nominal do transformador 10MVA

%% Linhas 
%linha 1020
L1020 = 8;
X10201 = 0.4388i;
X10200 = 0.6053i;

% Linhas 2030
L2030 = 8;
X20301 = 0.4388i;
X20300 = 0.6053i;

%linha 2040
L2040 = 5;
X20401 = 0.4388i;
X20400 = 0.6053i;

% Linha 3040
L3040 = 6;
X30401 = 0.4388i;
X30400 = 0.6053i;

%% 
% Calculo dos valores em pu 
% Base no primario 
Zb1 = V1tn1^2/Sb;
Ib1 = (Sb/3)/(V1tn1/sqrt(3));

% Bases no secundário
Zb2 = V2tn1^2/Sb;
Ib2 = (Sb/3)/(V2tn1/sqrt(3));

%Linhas
x10201 = X10201*L1020/Zb2;
x10200 = X10200*L1020/Zb2;

x20301 = X20301*L2030/Zb2;
x20300 = X20300*L2030/Zb2;

x20401 = X20401*L2040/Zb2;
x20400 = X20400*L2040/Zb2;

x30401  = X30401*L3040/Zb2;
x30400 = X30400*L3040/Zb2;

% Trafos 
xt1pu = xt1*Sb/St1; %Mudança de Base pra obter a reatancia do transformador nas bases do sistema

%Sistema 
x1seq  = X1seq/Zb1;
x0seq = X0seq/Zb1;

%% 
%C Condição de falta trifasica
%Seq positiva
%Paralelo linhas

x11 = (x20301+x30401)*x20401/((x20301+x30401) + x20401); 
zth1 = x11 + x10201 + xt1pu + x1seq; %trecho 2030//3040 + 1020 
vth1 = V2t1/Vb2; %usando a tensão no secundario
vmagnitude  = abs(vth1);
vphase = angle(vth1) * 180/pi;
vth1ma = [vmagnitude, vphase];


%corrente de falta
if3f = vth1/zth1; 
imagnitude = abs(if3f);
iphase = angle(if3f) * 180/pi;
if3fma = [imagnitude, iphase];
disp('em amperes:');

disp([abs(if3f*Ib2), phase(if3f*Ib2)*180/pi]);















