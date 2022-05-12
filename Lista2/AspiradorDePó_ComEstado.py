def reflex_vacuum_agent(location,status,before):
    if(status == "dirty"):
        return "suck"
    elif(location == "a" and before==0):
        return "right"
    elif(location == "b" and before==0):
        return "left"
    else:
        return "stay"


##local atual, valor local a, valor local b
scenes = [
    ["a", "dirty", "dirty"],
    ["a", "dirty", "clean"],
    ["a", "clean", "dirty"],
    ["a", "clean", "clean"],
    ["b", "dirty", "dirty"],
    ["b", "dirty", "clean"],
    ["b", "clean", "dirty"],
    ["b", "clean", "clean"],
]

total = 0
for i in range(8):
    pontos = 0
    print(str(i + 1) + "a Configuracao")
    if(scenes[i][0]=="a"):
        current = 1
    elif(scenes[i][0]=="b"):
        current = 2
    anterior = 0
    for j in range(5):
        print(scenes[i])
        result = reflex_vacuum_agent(scenes[i][0],scenes[i][current],anterior)
        if result == "suck":
            scenes[i][current] = "clean"
            pontos+=2
        elif result == "right":
            scenes[i][0] = "b"
            current = 2
            anterior = 1
            pontos-=1
        elif result == "left":
            scenes[i][0] = "a"
            current = 1
            anterior = 2
            pontos-=1
        else:
            break
    total += pontos
    print(pontos)

print("total de pontos: ", total)