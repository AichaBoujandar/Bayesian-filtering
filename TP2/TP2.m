%Lecture de l'ensemble des images de la séquence
affichage_initial;

%Initialisation des paramètres
N = 100;
Nb = 10;
lambda = 20;
c1 = 50;
c2 = 50;
c3 = 10;

%séléction de la zone �  suivre
selection_zone;
littleim = imcrop(im,zoneAT(1:4));
[~,Cmap] = rgb2ind(littleim,Nb,'nodither');
littleim = rgb2ind(littleim,Cmap,'nodither');
histoRef = imhist(littleim,Cmap);
histoRef = histoRef/sum(histoRef);
figure;
imhist(littleim,Cmap);

%Initialisation des particule
ksi = [zoneAT(1)+zoneAT(3)/2;zoneAT(2)+zoneAT(4)/2;100]*ones(1,N);
zone_ksi=zeros(4,N);
histo=zeros(Nb,N);
histos=zeros(Nb*T,N);
while tt <= T-1
    tt=tt+1;
    im = imread([SEQUENCE filenames{tt}]);
    p=zeros(1,N);
    imagesc(im);
    hold on;
    for n=1:N
        W = mvnrnd([0;0;0],[c1,0,0;0,c2,0;0,0,c3])';
        ksi(:,n) = ksi(:,n) + W;
        zone_ksi(:,n) =[ksi(1,n)-(ksi(3,n)/100)*zoneAT(3)/2,ksi(2,n)-(ksi(3,n)/100)*zoneAT(4)/2,(ksi(3,n)/100)*zoneAT(3),(ksi(3,n)/100)*zoneAT(4)];
        impart = imcrop(im,zone_ksi(:,n));
        impart = rgb2ind(impart,Cmap,'nodither');
        histo(:,n) = imhist(impart,Cmap)/sum(imhist(impart,Cmap));
        
        %histo(:,n) = histo(:,n)./numel(histo(:,n));
        histos(Nb*(tt-1)+1:tt*Nb,n)=histo(:,n);
        p(n)= exp(-lambda*fct_D(histoRef,histo(:,n),Nb)); 
        rectangle('Position',zone_ksi(:,n),'EdgeColor','y','LineWidth',0.5);
        hold on;
    end
    p=p/sum(p);
    zone_ksi_pond = zone_ksi*p';
    %for i=1:N
    %    zone_ksi_pond(i)=p(i)*zone_ksi(:,i);
    %end
    rectangle('Position',zone_ksi_pond,'EdgeColor','r','LineWidth',3);
    ksi=fct_multi(ksi,p,N); 
    pause;
end