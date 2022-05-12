from search import *


class VacuumCleaner(Problem):
    def __init__(
        self,
        initial,
    ):
        super().__init__(initial)

    def find_vacuum(self, state):
        if (0, 1) in state:
            return state.index((0, 1))
        else:
            return state.index((1, 1))

    def actions(self, state):
        possible_actions = [
            "UP",
            "DOWN",
            "LEFT",
            "RIGHT",
            "SUCK",
        ]

        return possible_actions

    def result(self, state, action):
        vacuum = self.find_vacuum(state)
        new_state = list(state)

        # | X_ | X_ | X_ |
        # | __ | _O | __ |
        # | __ | __ | __ |

        if action == "SUCK":
            new_state[vacuum] = (0, 1)
        else:
            if (
                (vacuum % 3 == 0 and action == "LEFT")
                or (vacuum < 3 and action == "UP")
                or (vacuum % 3 == 2 and action == "RIGHT")
                or (vacuum > 5 and action == "DOWN")
            ):
                new_state = list(state)
            else:
                delta = {"UP": -3, "DOWN": 3, "LEFT": -1, "RIGHT": 1}
                position = vacuum + delta[action]
                new_state[position] = (new_state[position][0], 1)
                new_state[vacuum] = (new_state[vacuum][0], 0)

        return tuple(new_state)

    def goal_test(self, state):
        new_state = list(state)
        test = all(map(lambda x: x[0] == 0, new_state))
        return test

