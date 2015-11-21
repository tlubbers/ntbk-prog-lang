
# Types

A type is a **SET** of values, and for programming languages they provide low level representations and include a collection of operations specific to them.

## Topics in Types
- Type annotations  (how to declare?)
- Type inference (how to determine?)
- Type checking (when to check?)
- Type equivalence issues (what is it?)

## Primitive Types VS Constructed Types

- **Primitive Types** cannot be constructed or defined, only used.
- **Constructed Types** can be defined and used within the context of a program.

## SML Functions and Types

```sml
- fun f x y = (hd x) (tl y);
val f = fn : ('a list -> 'b) list -> 'a list -> 'b
- fun f x = (hd x) (length x);
val f = fn : (int -> 'a) list -> 'a
- fun f x y z = z (x,y);
val f = fn : 'a -> 'b -> ('a * 'b -> 'c) -> 'c
- fun f x y = x y y;
val f = fn : ('a -> 'a -> 'b) -> 'a -> 'b
- fun f x y = y x;
val f = fn : 'a -> ('a -> 'b) -> 'b
- fun f x y = y x x;
val f = fn : 'a -> ('a -> 'a -> 'b) -> 'b
- fun f x y = x (y,y);
val f = fn : ('a * 'a -> 'b) -> 'a -> 'b
- fun f x y z = y x z;
val f = fn : 'a -> ('a -> 'b -> 'c) -> 'b -> 'c


```