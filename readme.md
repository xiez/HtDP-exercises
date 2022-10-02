## Online book (first edition)

https://htdp.org/2003-09-26/Book/curriculum-Z-H-1.html#node_toc_start



## Structural vs Generative recursion

https://htdp.org/2003-09-26/Book/curriculum-Z-H-33.html#node_sec_26.2

> All self-applications of a structurally recursive function always receive an immediate component of the current input for further processing. For example, for a constructed list, the immediate components are the first item and the rest of the list. Hence, if a function consumes a plain list and its recursive use does not consume the rest of the list, its definition is not structural but generative.

### pros & cons

> Experience shows that most functions in a program employ structural recursion; only a few exploit generative recursion. When we encounter a situation where a design could use either the recipe for structural or generative recursion, the best approach is often to start with a structural version. If it turns out to be too slow, the alternative design using generative recursion should be explored. If it is chosen, it is important to document the problem generation with good examples and to give a good termination argument.





