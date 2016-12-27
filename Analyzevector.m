function Analyzevector(numOfReturnedImages, queryImageFeatureVector, dataset)
% input:
%   numOfReturnedImages : num of images returned by query
%   queryImageFeatureVector: query image in the form of a feature vector
%   dataset: the whole dataset of images transformed in a matrix of
%   features
% 
% output: 
%   plot: plot images returned by query

% extract image fname from queryImage and dataset
query_image_name = queryImageFeatureVector(:, end);
dataset_image_names = dataset(:, end);

queryImageFeatureVector(:, end) = [];
dataset(:, end) = [];

% compute manhattan distance
manhattan = zeros(size(dataset, 1), 1);
for k = 1:size(dataset, 1)
%     manhattan(k) = sum( abs(dataset(k, :) - queryImageFeatureVector) );
    % ralative manhattan distance
    manhattan(k) = sum( abs(dataset(k, :) - queryImageFeatureVector) ./ ( 1 + dataset(k, :) + queryImageFeatureVector ) );
end

% add image fnames to manhattan
manhattan = [manhattan dataset_image_names];

% sort them according to smallest distance
[sortedDist indx] = sortrows(manhattan);
sortedImgs = sortedDist(:, 2);

% clear axes
arrayfun(@cla, findall(0, 'type', 'axes'));

% display query image
str_name = int2str(query_image_name);
queryImage = imread( strcat('images\', str_name, '.png') );
queryImage=imresize(queryImage,[5000 5000]);
subplot(3, 7, 1);
imshow(queryImage, []);
title('Query Image', 'Color', [1 0 0]);

% dispaly images returned by query
for m = 1:numOfReturnedImages
    img_name = sortedImgs(m);
    img_name = int2str(img_name);
    str_name = strcat('images\', img_name, '.png');
    returnedImage = imread(str_name);
     returnedImage=imresize( returnedImage,[5000 5000]);
    subplot(3, 7, m+1);
    imshow(returnedImage, []);
    str_name1 = int2str(sortedImgs(1));
queryImage1 = imread( strcat('images\', str_name1, '.png') );
imwrite(queryImage1,'imagee1.png','png');
 str_name2 = int2str(sortedImgs(2));
queryImage2 = imread( strcat('images\', str_name2, '.png') );
imwrite(queryImage2,'imagee2.png','png');
 str_name3 = int2str(sortedImgs(3));
queryImage3 = imread( strcat('images\', str_name3, '.png') );
imwrite(queryImage3,'imagee3.png','png');
end

end