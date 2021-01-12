M = imread('original_image.jpg'); 
J = rgb2gray(M);

n = 0:255;

imshow(J);
title('Original image');

figure 
bar(n, ImageHistogram(J)); 
title('Histogram of original image');
xlim([0 255]);

figure
imshow(HistogramEqualization(uint8(J)));
title('Processed image');

figure
bar(n, ImageHistogram(HistogramEqualization(uint8(J))));
title('Histogram of processed image');
xlim([0 255]);

function frequency = ImageHistogram(img)

    [r, c] = size(img);  
    frequency = zeros(256,1);   
    count = 0;    

    for i = 1:256 
        for j = 1:r 
            for k = 1:c 
                if img(j,k) == i - 1 
                    count = count + 1; 
                end
            end
        end 
    
    frequency(i) = count; 
    count = 0;
    
    end

end

function finalOutput = HistogramEqualization(img)

    [r,c] = size(img);
    finalOutput = uint8(zeros(r,c));
    pixels = r*c;
    frequency = zeros(256,1);
    pdf = zeros(256,1);
    cdf = zeros(256,1);
    cumulative = zeros(256,1);
    output = zeros(256,1);

    for i = 1:r
        for j = 1:c
            val = img(i,j);
            frequency(val+1) = frequency(val+1) + 1;
            pdf(val+1) = frequency(val+1)/pixels;
        end
    end

    sum = 0;
    intensityLevel = 255;

    for i = 1:size(pdf)
        sum = sum + frequency(i);
        cumulative(i) = sum;
        cdf(i) = cumulative(i)/pixels;
        output(i) = round(cdf(i) * intensityLevel);
    end

    for i = 1:r
        for j = 1:c
            finalOutput(i,j) = output(img(i,j) + 1);
        end
    end

end