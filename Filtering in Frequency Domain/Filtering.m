M = imread('original_image.jpg');
I = rgb2gray(M);
figure
imshow(I);

[M N] = size(I);

P = M;
Q = N;
I(P,Q) = 0;

for x=1:P
    for y=1:Q
        I(x,y) = ((-1)^(x+y)) * I(x,y);
    end
end

F = fft2(I);

for u=1:P
    for v=1:Q
        D(u,v) = sqrt((u - P/2)^2 + (v - Q/2)^2);
    end
end
Dnot = 30;

H_g = exp(-D.^2/(2*Dnot^2));
H_b = 1./((1+D./Dnot).^2);
for u=1:P
    for v=1:Q
        if D(u,v) < Dnot
            H_i(u,v) = 1;
        else
            H_i(u,v) = 0;
        end
    end
end

figure
subplot(1,3,1);
imshow(H_g);
title("Gaussian filter");
subplot(1,3,2);
imshow(H_b);
title("Butterworth filter");
subplot(1,3,3);
imshow(H_i);
title("Ideal low pass filter");

G_g = H_g.*F;
G_b = H_b.*F;
G_i = H_i.*F;

output_g = real(ifft2(G_g));
output_b = real(ifft2(G_b));
output_i = real(ifft2(G_i));

for x=1:P
    for y=1:Q
        output_g(x,y) = ((-1)^(x+y)) * output_g(x,y);
        output_b(x,y) = ((-1)^(x+y)) * output_b(x,y);
        output_i(x,y) = ((-1)^(x+y)) * output_i(x,y);
    end
end

figure
subplot(1,3,1);
imshow(uint8(output_g(1:M,1:N)));
title("Gaussian filtered image");
subplot(1,3,2);
imshow(uint8(output_b(1:M,1:N)));
title("Butterworth filtered image");
subplot(1,3,3);
imshow(uint8(output_i(1:M,1:N)));
title("Ideal low pass filtered image");