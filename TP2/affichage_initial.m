% repertoire contenant la sequence a traiter
SEQUENCE = './seq2/';
% numero de la premiere image a traiter
START = 1;

% chargement du nom des images de la sequence
filenames = dir([SEQUENCE '*.png']);
filenames = sort({filenames.name});
T = length(filenames);

% chargement la premiere image
tt = START;
im = imread([SEQUENCE filenames{tt}]);
% affichage de la premiere image
figure;
set(gcf,'DoubleBuffer','on');
imagesc(im);