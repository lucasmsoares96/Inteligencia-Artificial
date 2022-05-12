from aplicacao_busca import *


class Agente:
    def __init__(self, initial):
        self.problem = VacuumCleaner(initial)
        self.result = breadth_first_graph_search(self.problem)
        self.solution = self.result.solution()

    def action(self):
        if len(self.solution) > 0:
            return self.solution.pop(0)
        else:
            return "END"

    def path_cost(self):
        desempenho = 0
        custo = 0
        acao = self.action()
        while acao != "END":
            if acao == "SUCK":
                desempenho = desempenho + 10
            else:
                custo = custo + 1
            acao = self.action()
        print("Custo do Caminho: ", custo)
        print("Desempenho:       ", desempenho - custo)
