I = imread('original_image.jpg'); 
figure
imshow(I);
title("Original image");

P = imhist(I)/numel(I);
mg = 0;

for i = 1:256
	mg = mg + (i-1)*P(i);
end

for t = 1:256
    
	P1 = 0;
    P2 = 0;
    
	for i = 1:t
		P1 = P1+P(i);
    end
    
	for i = (t+1):256
		P2 = P2+P(i);
    end
    
	m1 = 0;
	m2 = 0;
    
	for i = 1:t
		m1 = m1 + (i-1)*P(i)/P1;
    end
    
	for i = (t+1):256
		m2 = m2 + (i-1)*P(i)/P2;
    end
    
	sigmabsq(t) = P1*(m1-mg)*(m1-mg) + P2*(m2-mg)*(m2-mg);
    
end

figure
plot(0:255,sigmabsq)
xlim([0 255]);
xlabel("Threshold");
ylabel("Between class variance");

[maxs maxt] = max(sigmabsq);
threshold = maxt

[r c] = size(I);

for i = 1:r
    for j = 1:c
        if(I(i,j) < maxt)
            I(i,j) = 0;
        else
            I(i,j) = 255;
        end
    end
end

figure
imshow(I);