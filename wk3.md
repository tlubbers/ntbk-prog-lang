# Week 3

## Left recursion

Recursive Descent Parsers cannot handle left recursion. We identify left recursions in the grammar just by looking at it. See following photo.

![Identifying Left Recursion](./img/wk3_idleftrec.png)

### Removing left recursion

The following diagrams show the process of eliminating left recursion to allow for recursive descent parsing.

![Removing Left Recursion](./img/wk3_rmleftrec.png)

![Removing Left Recursion](./img/wk3_rmleftrec2.png)

### Indirect left-recursions

The following diagram shows an example of indirect left recursion.

![Identifying Indirect Left Recursion](./img/wk3_idindirectrec.png)

### Removing indirect left recursions

The following algorithm will remove indirect left recursion.

![Removing Indirect Left Recursion](wk3-rmindirectrec.png)
