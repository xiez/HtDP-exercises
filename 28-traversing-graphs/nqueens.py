def build_board(n):
    return [[False for j in range(n)] for i in range(n)]

def NQueens(n):
    board = build_board(n)
    result = []

    def solve(n, board):
        if n == 0:
            return board

        positions = find_safe_positions(board)
        for a_posn in positions:
            new_board = placement(board, a_posn)
            ret = solve(n - 1, new_board)
            if ret is False:
                continue
            else:
                # print(f'place at position {a_posn}')
                result.append(a_posn)
                return ret
        return False

    solve(n, board)

    return result

def find_safe_positions(board):
    posns = []
    for i, row in enumerate(board):
        for j, val in enumerate(row):
            if val is False:
                posns.append((i, j))
    return posns

def placement(board, a_posn):
    new_board = []
    for i, row in enumerate(board):
        new_row = []
        for j, val in enumerate(row):
            if attack((i, j), a_posn):
                new_row.append(True)
            else:
                new_row.append(val)
        new_board.append(new_row)
    return new_board

def attack(posn1, posn2):
    x1, y1 = posn1
    x2, y2 = posn2
    if x1 == x2:
        return True
    if y1 == y2:
        return True
    if abs(x1 - x2) == abs(y1 - y2):
        return True
    return False

print(NQueens(4))
print(NQueens(5))
print(NQueens(8))
