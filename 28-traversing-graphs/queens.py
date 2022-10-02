from dataclasses import dataclass

def build_board(n, func=lambda x, y: False):
    ret = []
    for i in range(n):
        cols = []
        for j in range(n):
            cols.append(func(i, j))
        ret.append(cols)
    return ret

def board_dim(a_board):
    return len(a_board[0])

def board_ref(a_board, i, j):
    return a_board[i][j]

@dataclass
class Posn:
    x: int
    y: int

def threatened(pos1, pos2):
    if pos1.x == pos2.x:        # row
        return True
    if pos1.y == pos2.y:        # collumn
        return True
    if abs(pos1.x - pos2.x) == abs(pos1.y - pos2.y):  # diagonal
        return True
    return False

def add_queen(board, posn):
    """Add a queen to the board at p and also flip all threatened
    positions to true.
    """
    return build_board(
        board_dim(board),
        lambda x, y: True if board_ref(board, x, y) or \
        threatened(Posn(x, y), posn) else False
    )

def find_open_spots(board):
    """Find the unoccupied positions in the board.
    """
    return [
        Posn(i, j) for i in range(board_dim(board))
        for j in range(board_dim(board))
        if board_ref(board, i, j) is False
    ]

class NQueens:
    def __init__(self, n=4):
        self.n = n
        self.result = []

    def placement(self, a_board, n):
        """Places n queens on a-board. if possible, returns
        the board. otherwise, returns false.
        """
        if n == 0:
            # no more queens, return the board
            return a_board
        else:
            possible_places = find_open_spots(a_board)
            return self.placement_list(possible_places, a_board, n)
     
    def placement_list(self, possibles, a_board, n):
        """Tries to place n queens in all of the boards. As soon as
        one of them works out, it returns that one. If none
        work out, returns false.
        """
        if not possibles:
            # no more possible places, return false
            return False
     
        first_possible, rest_possibles = possibles[0], possibles[1:]
     
        # try to add a queen to the first possible place
        # and place {n-1} queens on the new board
        new_board = add_queen(a_board, first_possible)
        # print(f'|{(self.n-n) * "--"}' + f'try {first_possible} .. free spots: {find_open_spots(new_board)}')

        c = self.placement(new_board, n - 1)
        if c is False:  # first possible does not work out, try rest possibles
            # print(f'|{(self.n-n) * "--"}' + f'{first_possible} does not works out, backtracking..')
            return self.placement_list(rest_possibles, a_board, n)
        else:  # first possible works out, return the board
            # print(f'|{(self.n-n) * "--"}' + f'{first_possible} works out')
            self.result.append(first_possible)
            return c

# TEST ----------------------------------------
from pprint import pprint
bd4 = build_board(4)
print('== empty board4 ==')
pprint(bd4)

bd5 = build_board(
    5, lambda x, y: True if x % 2 == 0 and y % 2 == 0 else False
)
assert board_ref(bd5, 0, 1) is False
assert board_ref(bd5, 0, 2) is True

assert Posn(0, 0) == Posn(0, 0)
assert Posn(0, 0).x == 0

assert threatened(Posn(0, 0), Posn(0, 1)) is True
assert threatened(Posn(1, 0), Posn(1, 1)) is True
assert threatened(Posn(1, 1), Posn(2, 0)) is True
assert threatened(Posn(1, 1), Posn(3, 0)) is False

bd4_0x0 = add_queen(bd4, Posn(0, 0))  # board4 with queen on (0, 0)
print('== board4 with queen on (0, 0) ==')
pprint(bd4_0x0)
assert board_ref(bd4_0x0, 0, 0) is True
assert board_ref(bd4_0x0, 0, 1) is True
assert board_ref(bd4_0x0, 1, 0) is True
assert board_ref(bd4_0x0, 1, 1) is True
assert board_ref(bd4_0x0, 1, 1) is True
assert board_ref(bd4_0x0, 2, 1) is False

print('== board4 with queen on (0, 0) and (1, 2) ==')
bd4_0x0_1x2 = add_queen(bd4_0x0, Posn(1, 2))
pprint(bd4_0x0_1x2)
assert board_ref(bd4_0x0_1x2, 0, 0) is True
assert board_ref(bd4_0x0_1x2, 2, 1) is True

assert find_open_spots(bd4_0x0) == [
    Posn(x=1, y=2), Posn(x=1, y=3), Posn(x=2, y=1), Posn(x=2, y=3),
    Posn(x=3, y=1), Posn(x=3, y=2)
]

print('== board4 after placing 4 queens ==')
Q4 = NQueens(4)
bd4_4 = Q4.placement(bd4, 4)
pprint(bd4_4)
for row in bd4_4:
    for e in row:
        assert e is True
print(f'4-queens result: {Q4.result}')

for n in [5, 6, 7, 8]:
    QN = NQueens(n)
    QN.placement(build_board(n), n)
    print(f'{n}-queens result: {QN.result}')
