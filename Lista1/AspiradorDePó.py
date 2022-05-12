def reflex_vacuum_agent(location, status):
    if status == "dirty":
        return "suck"
    elif location == "a":
        return "right"
    elif location == "b":
        return "left"
    return "fail"


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

pontos = 0
for i in range(8):
    print(str(i + 1) + "a Configuracao")
    if scenes[i][0] == "a":
        current = 1
    elif scenes[i][0] == "b":
        current = 2
    for j in range(5):
        print(scenes[i])
        result = reflex_vacuum_agent(scenes[i][0], scenes[i][current])
        if result == "suck":
            scenes[i][current] = "clean"
        elif result == "right":
            current = 2
        elif result == "left":
            current = 1
    print(scenes[i])
    if scenes[i][1] == "clean" and scenes[i][2] == "clean":
        print("+1 ponto")
        pontos = +pontos + 1

print("total de pontos: ", pontos)
