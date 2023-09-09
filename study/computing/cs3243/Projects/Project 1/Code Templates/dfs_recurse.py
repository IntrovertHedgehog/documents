from typing import Dict, List, Tuple


def search(dct: Dict) -> List[Tuple[int, int]]:
    """
    Solve the maze using depth-first search.

    Write your implementation below
    """
    r, c = dct["rows"], dct["cols"]
    if r * c <= 0:
        return []
    if not dct["goals"]:
        return []
    if dct["start"] in dct["goals"]:
        return [tuple(dct["start"])]
    v = set()
    ob = set(tuple(o) for o in dct["obstacles"])
    g = set(tuple(go) for go in dct["goals"])
    actions = [(1, 0), (0, 1), (0, -1), (-1, 0)]
    path = []

    def dfs(pos: Tuple[int, int]) -> bool:
        v.add(pos)
        if pos in g:
            path.append(pos)
            return True
        for i, j in actions:
            xn, yn = next = (pos[0] + i, pos[1] + j)
            if (
                (xn < r and xn > -1 and yn < c and yn > -1)
                and (next not in v)
                and (next not in ob)
            ):
                if dfs(next):
                    path.insert(0, pos)
                    return True
        return False

    dfs(tuple(dct["start"]))
    return path
