from agente_aleatorio import *
from agente_busca import *


def random_state():
    state = []
    i = 0
    while i < 9:
        if random.randint(0, 4) == 2:
            state.append((1, 0))
        else:
            state.append((0, 0))
        i = i + 1
    index = random.randint(0, 8)
    if state[index] == (1, 0):
        state[index] = (1, 1)
    else:
        state[index] = (0, 1)
    return tuple(state)


estado = random_state()


print()
print(">>> Algoritmo de Busca")
print()

initial = ((1, 0), (1, 0), (1, 0), (0, 0), (0, 1), (0, 0), (0, 0), (0, 0), (0, 0))

print(initial)
problem = VacuumCleaner(initial)
result = breadth_first_graph_search(problem)
print(result.solution())
print("Custo da Busca:   ", result.path_cost)


print()
print(">>> Agente de Busca")
print(estado)
print()

agente = Agente(estado)
print(agente.solution)
print("Custo da Busca:   ", agente.result.path_cost)
agente.path_cost()

print()
print(">>> Agente de Aleatorio")
print()

aleatorio = Aleatorio(estado)
print(aleatorio.solution)
aleatorio.path_cost()


teste = (
    ((0, 0), (0, 0), (0, 0)),
    ((1, 0), (1, 0), (1, 0)),
    ((0, 0), (1, 0), (0, 1)),
)
