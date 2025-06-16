function MontagePlot(xTest,tTest,encode,decode,number)%add itteration perhaps
    if nargin <=4
        number=-1;
    end
    images = xTest;
    imagesPredicted = decode.predict(encode.predict(images));
    numbers = double(tTest)-1;
    imageSet = {};
    if number == -1
        for i=1:2:20
            iNum = find(numbers==(i-1)/2);
            iNum = randsample(iNum,1);
            img1 = reshape(images(:,iNum),[28,28]);
            img2 = reshape(imagesPredicted(:,iNum),[28,28]);
            imageSet = [imageSet,img1,img2];
        end
    else 
       for i=1:2:20
            iNum = find(numbers==number);
            iNum = randsample(iNum,1);
            img1 = reshape(images(:,iNum),[28,28]);
            img2 = reshape(imagesPredicted(:,iNum),[28,28]);
            imageSet = [imageSet,img1,img2];
       end
    end
    figure;
    montage(imageSet,'Size',[5,4]);

end