graph = (
    ('A', ('B', 'E')),
    ('B', ('E', 'F')),
    ('C', ('D', )),
    ('D', ()),
    ('E', ('C', 'F')),
    ('F', ('D', 'G')),
    ('G', ()),
)

def neighbors(node, graph):
    for a_node in graph:
        if node == a_node[0]:
            return a_node[1]
    return []

def find_route(origination, destination, G):
    if (origination == destination):
        return [destination]
    else:
        possible_route = find_route_list(neighbors(origination, G), destination, G)
        if possible_route is False:
            return False
        else:
            return [origination, possible_route]

def find_route_list(lo_Os, D, G):
    if not lo_Os:
        return False
    else:
        possible_route = find_route(lo_Os[0], D, G)
        if possible_route is False:
            return find_route_list(lo_Os[1:], D, G)
        else:
            return possible_route

# print(
#     find_route('A', 'G', graph)
# )


# test all nodes

all_nodes = [e[0] for e in graph]
for e in [(e, i) for e in all_nodes for i in all_nodes]:
    origination, destination = e[0], e[1]
    print("%s -> %s" % (origination, destination),
          find_route(origination, destination, graph))
