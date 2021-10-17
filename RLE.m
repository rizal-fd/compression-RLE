
 %Show UI Image chooser 
 image=imread('lena.jpg');
 
 height = size(image,1); 
 width = size(image,2); 
 n_channel = size(image,3);
 %variable container for compressed image 
 compressed = zeros(1,1,1);
 %start count time 
 tic 
 %RLE Algorithm 
 for channel = 1:n_channel    
     for y = 1:height         
         compressed_y = y;       
         compressed_x = 1;      
         last_pixel = image(y,1,channel);  
         match = 1;     
         for x = 2:width         
             current_pixel = image(y,x,channel);  
             if(last_pixel == current_pixel)      
                 match = match + 1;               
                 if(match == 256)                 
                     compressed(compressed_y, compressed_x, channel) = match; 
                     compressed(compressed_y, compressed_x + 1, channel) = last_pixel;  
                     compressed_x = compressed_x + 2;       
                     match = 1;                   
                     last_pixel = current_pixel;   
                 end
             else
                 compressed(compressed_y, compressed_x, channel) = match;  
                 compressed(compressed_y, compressed_x + 1, channel) = last_pixel;
                 compressed_x = compressed_x + 2;   
                 match = 1;
                 last_pixel = current_pixel;  
             end
         end
         compressed(compressed_y, compressed_x, channel) = match; 
         compressed(compressed_y, compressed_x + 1, channel) = current_pixel;
     end
 end
 %Convert compressed data to 8 bit integer
 compressed = uint8(compressed);

 figure,
 subplot(121);imshow(image);title('Original Image');
 subplot(122);imshow(compressed);title('Compressed image');
 w = waitforbuttonpress;
 imwrite(compressed,'encoded.txt')
 
 mse =  immse(compressed, image);
% Calculate PSNR (Peak Signal to Noise Ratio) from the MSE according to the formula.
PSNR = 20 * log10( 255 / sqrt(mse));