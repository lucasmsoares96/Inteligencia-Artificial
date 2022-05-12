import search

canibais_missionarios_map = search.UndirectedGraph(
    {
        "m3c3d": {"m2c2e": 1, "m3c1e": 1, "m3c2e": 1},
        "m2c2e": {"m3c2d": 1},
        "m3c1e": {"m3c2d": 1},
        "m3c2d": {"m3c0e": 1},
        "m3c0e": {"m3c1d": 1},
        "m3c1d": {"m1c1e": 1},
        "m1c1e": {"m2c2d": 1},
        "m2c2d": {"m0c2e": 1},
        "m0c2e": {"m0m3d": 1},
        "m0m3d": {"m0c1e": 1},
        "m0c1e": {"m1c1d": 1, "m0c2d": 1},
        "m1c1d": {"m0c0e": 1},
        "m0c2d": {"m0c0e": 1},
    },
)

canibais_problem = search.GraphProblem("m3c3d", "m0c0e", canibais_missionarios_map)
print(search.breadth_first_tree_search(canibais_problem).solution())
