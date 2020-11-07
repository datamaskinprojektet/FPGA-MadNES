

#OAM: 2 16-bit addresses 
#    8 bit spriteref
#    10 bit x pos
#    10 bit y pos
#    1 bit x-flip
#    1 bit y-flip
#    1 bit priority
#    1 bit enable

OAM = [
    {
        "spriteref":1,
        "x_pos":1,
        "y_pos":2,
        "x_flip":0,
        "y_flip":0,
        "priority":1,
        "enable":1
    },
    {
        "spriteref":0,
        "x_pos":0,
        "y_pos":0,
        "x_flip":0,
        "y_flip":0,
        "priority":0,
        "enable":1
    }
]

SPRITE = [
    [
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,
        5,5,5,5,5,5,5,5,


    ]
]

PALLET = [
    {
        "r":255,
        "g":255,
        "b":255
    },
    {
        "r":255,
        "g":255,
        "b":255
    },
    {
        "r":255,
        "g":255,
        "b":255
    },
    {
        "r":133,
        "g":133,
        "b":133
    },
    {
        "r":50,
        "g":50,
        "b":50
    },
    {
        "r":200,
        "g":200,
        "b":200
    }
]

def wait_clock_cycles(times, clockCycles):
    waitTime = times*clockCycles
    print("#"+str(waitTime)+";")

# EBI_ALE, EBI_WE active low
# EBI_AD "active high"
# EBI_ALE = Adresse
# EBI_WE = Data
# after a address data burst wait 2 clock cycles.

clockCycle = 39.68  # 25,2 MHz
print("// Generating OAM")
print("")
wait_clock_cycles(2, clockCycle)
index = 0
print("bank_select = 0;")
for oam_obj in OAM:
    oam_obj["spriteref"]= ([str(x) for x in '{:08b}'.format(oam_obj["spriteref"])])
    oam_obj["x_pos"]    = ([str(x) for x in '{:010b}'.format(oam_obj["x_pos"])]) 
    oam_obj["y_pos"]    = ([str(x) for x in '{:010b}'.format(oam_obj["y_pos"])])  
    oam_obj["x_flip"]   = ([str(x) for x in '{:01b}'.format(oam_obj["x_flip"])])
    oam_obj["y_flip"]   = ([str(x) for x in '{:01b}'.format(oam_obj["y_flip"])])
    oam_obj["priority"] = ([str(x) for x in '{:01b}'.format(oam_obj["priority"])])
    oam_obj["enable"]   = ([str(x) for x in '{:01b}'.format(oam_obj["enable"])])
    dataobject1 =  "".join(oam_obj["x_pos"][2:11]) + "".join(oam_obj["spriteref"])
    dataobject2 = "".join(oam_obj["enable"]) + "".join(oam_obj["priority"]) + "".join(oam_obj["y_flip"]) + "".join(oam_obj["x_flip"]) + "".join(oam_obj["y_pos"])  + "".join(oam_obj["x_pos"][:2])
    
    print("EBI_AD = "+str(index)+";")
    print("#1;")
    print("EBI_ALE = 0;")
    print("#1;")
    print("EBI_ALE = 1;")
    print("#1;")
    print("EBI_AD = 16'b"+dataobject1+";")
    print("#1;")
    print("EBI_WE = 0;")
    print("#1;")
    print("EBI_WE = 1;")
    print("#1;")
    wait_clock_cycles(2, clockCycle)
    print("EBI_AD = "+str(index+1)+";")
    print("#1;")
    print("EBI_ALE = 0;")
    print("#1;")
    print("EBI_ALE = 1;")
    print("#1;")
    print("EBI_AD = 16'b"+dataobject2+";")
    print("#1;")
    print("EBI_WE = 0;")
    print("#1;")
    print("EBI_WE = 1;")
    print("#1;")
    print("")
    wait_clock_cycles(2, clockCycle)
    index += 2  
    
print("")
print("// Generating VRAM SPRITE")
print("")
wait_clock_cycles(2, clockCycle)
index = 0
print("bank_select = 1;")
for sprite_obj in SPRITE:
    for offset in range(0,128):
        sprite_obj[offset]= ([str(x) for x in '{:016b}'.format(sprite_obj[offset])])
        print("EBI_AD = "+str(offset+index)+";")
        print("#1;")
        print("EBI_ALE = 0;")
        print("#1;")
        print("EBI_ALE = 1;")
        print("#1;")
        print("EBI_AD = 16'b"+"".join(sprite_obj[offset])+";")
        print("#1;")
        print("EBI_WE = 0;")
        print("#1;")
        print("EBI_WE = 1;")
        print("#1;")
        wait_clock_cycles(2, clockCycle)
    index += 128


print("")
print("// Generating Pallet")
print("")
wait_clock_cycles(2, clockCycle)
index = 0
print("bank_select = 3;")
for pallet_obj in PALLET:
    pallet_obj["r"]= ([str(x) for x in '{:08b}'.format(pallet_obj["r"])])
    pallet_obj["g"]= ([str(x) for x in '{:08b}'.format(pallet_obj["g"])])
    pallet_obj["b"]= ([str(x) for x in '{:08b}'.format(pallet_obj["b"])])
    print("EBI_AD = "+str(index)+";")
    print("#1;")
    print("EBI_ALE = 0;")
    print("#1;")
    print("EBI_ALE = 1;")
    print("#1;")
    print("EBI_AD = 16'b"+ "".join(pallet_obj["g"]) +"".join(pallet_obj["r"])+";")
    print("#1;")
    print("EBI_WE = 0;")
    print("#1;")
    print("EBI_WE = 1;")
    print("#1;")
    wait_clock_cycles(2, clockCycle)
    print("EBI_AD = "+str(index+1)+";")
    print("#1;")
    print("EBI_ALE = 0;")
    print("#1;")
    print("EBI_ALE = 1;")
    print("#1;")
    print("EBI_AD = 16'b"+ "00000000" +"".join(pallet_obj["b"])+";")
    print("#1;")
    print("EBI_WE = 0;")
    print("#1;")
    print("EBI_WE = 1;")
    print("#1;")
    wait_clock_cycles(2, clockCycle)
    index += 2