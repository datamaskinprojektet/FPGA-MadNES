from PIL import Image
import math 
import csv

pictureArray = []

with open('vivado_project/vivado_project.sim/sim_1/behav/xsim/display_data.txt', newline='') as csvfile:
    pictureData = csv.reader(csvfile, delimiter=',')
    index = 0
    print(pictureData)
    for obj in pictureData:
        colorIndex = 0
        if index > 640*480:
            break
        colorObject = [0,0,0]
        for color in obj:
            if not "x" in color:
                colorObject[colorIndex] = int(color)
            else:
                colorObject[colorIndex] = 255
                print("Found x at w: "+ str(index - (640*math.floor(index/640))) +" h: "+ str(math.floor(index/640)) +", changing it to 255")
            colorIndex+=1
        pictureArray.append(colorObject)
        index+=1

img = Image.new( 'RGB', (640,480), "black") # Create a new black image
pixels = img.load() # Create the pixel map
pixelIndex = 0
for i in range(img.size[0]):    # For every pixel:
    for j in range(img.size[1]):
        pixels[i,j] = (pictureArray[pixelIndex][0], pictureArray[pixelIndex][1], pictureArray[pixelIndex][2]) # Set the colour accordingly
        pixelIndex += 1
        #pixels[i,j] = (i, j, 100) # Set the colour accordingly

img.show()