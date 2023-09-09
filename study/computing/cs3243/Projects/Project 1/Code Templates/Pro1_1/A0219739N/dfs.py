from typing import Dict, List, Tuple


def search(dct: Dict) -> List[Tuple[int, int]]:
    r, c = dct["rows"], dct["cols"]

    if not dct["goals"]:
        return []

    x0, y0 = dct["start"]
    map = [[0 for i in range(c)] for j in range(r)]

    # 0: walkable way 1: obstacles 3: goals
    for i, j in dct["goals"]:
        map[i][j] = 3

    for i, j in dct["obstacles"]:
        map[i][j] = 1

    # early goal check is used in the main loop
    # so start = goal case has to be checked here
    if map[x0][y0] == 3:
        return [(x0, y0)]

    # visited nodes stores their parent nodes in the map
    map[x0][y0] = None
    actions = [(1, 0), (0, 1), (-1, 0), (0, -1)]
    # node + next action to try
    front = [((x0, y0), 0)]

    def get_path(x: int, y: int) -> List[Tuple[int, int]]:
        path = [(x, y)]
        while map[x][y]:
            path.append(map[x][y])
            x, y = map[x][y]
        path.reverse()
        return path

    while front:
        cur, a = front.pop()
        x, y = cur[0] + actions[a][0], cur[1] + actions[a][1]
        a += 1
        if a < 4:
            front.append((cur, a))
        if x >= r or x < 0 or y >= c or y < 0:
            continue
        is_way = map[x][y] == 0
        is_goal = map[x][y] == 3
        if not is_way and not is_goal:
            continue
        map[x][y] = cur
        if is_goal:
            return get_path(x, y)
        front.append(((x, y), 0))

    return []
