import random


class Aleatorio:
    def __init__(self, initial):
        self.solution = []
        self.initial = initial
        self.get_solution()

    def get_solution(self):
        vacuum = self.find_vacuum(self.initial)
        new_state = list(self.initial)
        while not self.goal_test(tuple(new_state)):
            if new_state[vacuum] == (1, 1):
                new_state[vacuum] = (0, 1)
                self.solution.append("SUCK")
            else:
                action = self.random_action()
                self.solution.append(action)
                if not (
                    (vacuum % 3 == 0 and action == "LEFT")
                    or (vacuum < 3 and action == "UP")
                    or (vacuum % 3 == 2 and action == "RIGHT")
                    or (vacuum > 5 and action == "DOWN")
                ):
                    delta = {"UP": -3, "DOWN": 3, "LEFT": -1, "RIGHT": 1}
                    position = vacuum + delta[action]
                    new_state[position] = (new_state[position][0], 1)
                    new_state[vacuum] = (new_state[vacuum][0], 0)
            vacuum = self.find_vacuum(new_state)
        return self.solution

    def find_vacuum(self, state):
        if (0, 1) in state:
            return state.index((0, 1))
        else:
            return state.index((1, 1))

    def random_action(self):
        possible_actions = [
            "UP",
            "DOWN",
            "LEFT",
            "RIGHT",
        ]
        return possible_actions[random.randint(0, 3)]

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

    def goal_test(self, state):
        new_state = list(state)
        test = all(map(lambda x: x[0] == 0, new_state))
        return test
