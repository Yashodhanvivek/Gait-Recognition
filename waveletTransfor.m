function waveletMoments = waveletTransfor(image)
% input: image to process and extract wavelet coefficients from
% output: 1x20 feature vector containing the first 2 moments of wavelet
% coefficients

imgGray = double(rgb2gray(image))/255;
imgGray = imresize(imgGray, [256 256]);
A=empi(imgGray);
imf=A(:,:,1);
imf1=A(:,:,2);
imf2=A(:,:,3);
res=A(:,:,4);
meanCoeff = mean(imf2);
stdCoeff = std(imf2);

waveletMoments = [meanCoeff stdCoeff];

end