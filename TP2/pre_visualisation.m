% repertoire contenant la sequence a traiter
SEQUENCE = './seq2/';
% numero de la premiere image a traiter
START = 1;

% chargement du nom des images de la sequence
filenames = dir([SEQUENCE '*.png']);
filenames = sort({filenames.name});
T = length(filenames);

figure;
set(gcf,'DoubleBuffer','on');

% chargement de la premiere image
tt = START;
im = imread([SEQUENCE filenames{tt}]);
% affichage de la premiere image
imagesc(im);
text(10,10,strcat(num2str(tt),'/',num2str(T)),'Color','r');
disp('pause apres chaque image (taper sur une touche pour continuer)');
disp(['---------- ' filenames{tt} ' ---------------' ]);
pause;

while tt <= T-1
% chargement de l'image suivante
   tt = tt+1;
   im = imread([SEQUENCE filenames{tt}]);
   if isempty(im)
      break;
   end
% affichage de l'image et de son numero dans la sequence
   imagesc(im);
   text(10,10,strcat(num2str(tt),'/',num2str(T)),'Color','r');
   disp(['---------- ' filenames{tt} ' ---------------' ]);
   pause;
end

% disp('fin de la pre-visualisation (taper sur une touche pour quitter)');
% pause
% close
disp('fin de la pre-visualisation');