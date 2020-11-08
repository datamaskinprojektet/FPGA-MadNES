import math
import csv
from PIL import Image

pictureArray = []

for x in range(0,640):
    pictureArray.append([])
    for y in range(0,480):
        pictureArray[x].append([])
        pictureArray[x][y] = [0,0,0]

with open('vivado_project/vivado_project.sim/sim_1/behav/xsim/display_data.txt', newline='') as csvfile:
    pictureData = csv.reader(csvfile, delimiter=',')
    print(pictureData)
    for obj in pictureData:
        colorObject = [0,0,0]
        for colorIndex in range(0,3):
            if not "X" in obj[colorIndex+2]:
                colorObject[colorIndex] = int(obj[colorIndex+2])
            else:
                colorObject[colorIndex] = 255
                print("Found x at w: "+ str(int(obj[0])) +" h: "+ str(int(obj[1])) +", changing it to 255")
        pictureArray[int(obj[0])][int(obj[1])] = colorObject

img = Image.new( 'RGB', (640,480), "black") # Create a new black image
pixels = img.load() # Create the pixel map
pixelIndex = 0
for i in range(img.size[0]):    # For every pixel:
    for j in range(img.size[1]):
        pixels[i,j] = (pictureArray[i][j][0], pictureArray[i][j][1], pictureArray[i][j][2]) # Set the colour accordingly
        pixelIndex += 1
        #pixels[i,j] = (i, j, 100) # Set the colour accordingly

img.show()
