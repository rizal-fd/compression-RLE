import cv2 as cv
import numpy as np
import sys

# read image as grayscale image
img = cv.imread('lena.jpg',0)

def img2RLE (src):
    x,y = src.shape
    encoded = []
    pointer = src[0,0]
    counter = 0
    print(pointer)
    for j in range(0,y):
        rows = []
        for i in range(0,x):
            if pointer != src[i,j] :
                rows.append([pointer,counter])
                pointer = src[i,j]
                counter = 1
            counter += 1
        encoded.append(rows)
    return np.array(encoded)
        


            

print(img.flatten())
# cv.imshow('Original',img)
# cv.waitKey(0)
# print(img)
# np.set_printoptions(threshold=sys.maxsize)
# print(img)

