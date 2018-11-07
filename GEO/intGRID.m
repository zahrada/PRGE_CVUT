function N = intGRID(B,L)
% N = intGRID(B,L)
% Vrati interpolovanou hodnotu odlehlosti kvazigeoidu modelu CR2005 od
% elipsoidu GRS80 pro souradnice B,L
%
% Vstup: B,L [°]
% Vystup: N [m]


%% Predspracovani 
% CR2005_v1005   % upraveny soubor pro model kvazigeoidu
%
% BK = KVAZIGEOID(:,1);
% LK = KVAZIGEOID(:,2); 
% NK = KVAZIGEOID(:,3);
% 
% Bmin = min(BK);
% Bmax = max(BK);
% Lmin = min(LK);
% Lmax = max(LK);
% B2 = Bmin:0.01667:Bmax;
% L2 = Lmin:0.025:Lmax;
% [Bgrid Lgrid] = meshgrid(B2,L2);
% Ngrid = griddata(BK,LK,NK,Bgrid,Lgrid);
% save('CR2005GRID.mat','Bgrid','Lgrid','Ngrid')


%% Interpolace
load('CR2005GRID.mat')

% urci ctverec, kde lezi bod
OB = zeros(2); OL = OB; ON = OB;
for i=1:size(Ngrid,2)-1
    for j=1:size(Ngrid,1)-1
        if B > Bgrid(1,i) && B < Bgrid(1,i+1) 
            if L > Lgrid(j,1) && L < Lgrid(j+1,1)
                OB = Bgrid(j:j+1,i:i+1);
                OL = Lgrid(j:j+1,i:i+1);
                ON = Ngrid(j:j+1,i:i+1);
            end
        end
    end
end

% interpolace - linearni
Bint = [];
SCALB = max(OB(1,:)); SCALL = max(OL(:,1));
OB = OB./SCALB; OL = OL./SCALL;
for i=1:2
    KB = polyfit(OB(i,:),ON(i,:),1);
    Bint = [Bint; polyval(KB,B/SCALB)];
end
KL = polyfit(OL(:,1),Bint,1);
N = polyval(KL,L/SCALL);

end