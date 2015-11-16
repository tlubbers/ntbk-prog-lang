
# Standard ML

## What's Standard ML?

- Meta Language
- One of the most popular functional languages
- Edinburgh, 1974, Robin Milner’s group
- There are a number of dialects
- We are using Standard ML (SML) but we will just call it ML from the time being

### Professor Li's ML Analogy

- **Type** is the backbone of ML
- **Recursion** is the blood of ML
- **Function** is the flesh of ML
- **Higher order** is the soul of ML

## ML Basics

The building blocks for a basic understanding of SML are...

- Constants
- Operators
- Defining Variables
- Tuples and Lists
- Defining Functions
- ML Types and Type Annotations

### Constants

#### Integers
```sml
- 1234;
val it = 1234 : int
```

#### Reals
```sml
- 123.4;
val it = 123.4 : real
```

#### Booleans
```sml
- true;
val it = true : bool
- false;
val it = false : bool
```

#### Strings
```sml
- "fred";
val it = "fred" : string
- "H";
val it = "H" : string
```

Strings can use the standard style escapes like \n.

#### Characters
```sml
- #"H"
val it = #"H" : char
```
**Notice that a character is not a character unless it is preceded by #. Without the # it is a string.**

### Operators

#### Basic mathematical operations.
The standard operators for **integers** are...
```sml
- ~ 1 + 2 - 3 * 4 div 5 mod 6;
val it = ~1 : int
```
Notice the ~ is the notation for unary negation.

The standard operators for **reals** are...
```sml
- ~ 1.0 + 2.0 - 3.0 * 4.0 / 5.0;
val it = ~1.4 : real
```
All are identical to integer operators EXCEPT **div is replaced with /.**

#### Order of Operations
SML is **Left associative**. So, precedence then is {+,-} < {*,/,div, mod} < {~}.

#### String Concatenation
```sml
"bibity" ^ "bobity" ^ "boo";
val it = "bibitybobityboo" : string
```

#### Logical Ordering
The less-than, greater-than category of operators always return booleans, band can be applied to ints, reals, strings, and chars.

```sml
 2 < 3;
val it = true : bool
 1.0 <= 1.0;
val it = true : bool
 #"d" > #"c";
val it = true : bool
 "abce" >= "abd";
val it = false : bool
```
Order on strings and characters is lexicographic

#### Equality
We use `=` and `<>` as "equals" and "not equal to", respectively. However, some types will cause an error. Such as the real type, because **reals are not equality types**.

```sml
- 1 = 2;
val it = false : bool
- true <> false;
val it = true : bool
- 1.3 = 1.3;
```

#### Boolean Operators
```sml
- 1 < 2 orelse 3 > 4;
val it = true : bool
- 1 < 2 andalso not (3 < 4);
val it = false : bool
```
These are short-circuiting, so if left hand side evaluates true, then the right hand side is never looked at.

#### Conditionals
If->then->else is the main conditional, and must contain the else. There is no if->then.

```sml
-if 1 < 2 then #"x" else #"y“;
val it = #"x" : char
-if 1 > 2 then 34 else 56;
val it = 56 : int
(if 1 < 2 then 34 else 56) + 1;
val it = 35 : int
 ```

#### Built-In Conversion Functions

```sml
real  (fn: int  real)
floor   (fn: real  int)
ceil   (fn: real  int)
round  (fn: real  int)
trunc  (fn: real  int)
ord  (fn: char  int)
chr  (fn: int  char)
str  (fn: char  string)
```

#### Function Associativity
Function application is left-associative, so f a b means (f a) b, which means:

- first apply f to the single argument a;
- then take the value f returns, which should be another function;
- then apply that function to b

This is important, as you can tell from the following example.

```sml
- square 2+1;
val it = 5 : int
- square (2+1);
val it = 9 : int
```

### Defining Variables
The key word `val` is used to bind a value to a variable.
```sml
- val x = 1+2*3;
val x = 7 : int
- x;
val it = 7 : int
- val y = if x = 7 then 1.0 else 2.0;
val y = 1.0 : real
```

Sml allows you to redefine variables, using the **same name**. Ya gotta watch this, it can cause issues. Problems arise because any part of the program that was using the first definition of of a variable, still is after the second definition is made.

```sml
- val fred = 23;
val fred = 23 : int
- fred;
val it = 23 : int
- val fred = true;
val fred = true : bool
- fred;
val it = true : bool
```

### Tuples and Lists
The two most important types in ML are...

- **Tuples**: `(1,2,3)`, which are like structs.
- **Lists**: `[1, 2, 3]`,  which are like arrays

#### Tuples
Tuples are like structs with no names for the variables they contain. There is no limitations on type between the elements in a tuple, a tuple can even contain a tuple.

We define them with parenthesis, and can access the ith element of some tuple by using `#i x`.
```sml
- val barney = (1+2, 3.0*4.0, "brown");
val barney = (3,12.0,"brown") : int * real * string
- val point1 = ("red", (300,200));
val point1 = ("red",(300,200)) : string * (int * int)
- #2 barney;
val it = 12.0 : real
- #1 (#2 point1);
val it = 300 : int
```

Notice the types of a tuple are given as type * type * (type * type)...etc. The parenthesis are significant. Also,  when you're wondering what type something is **remember (1) is not a tuple of 1**
```sml
- (1, 2);
val it = (1,2) : int * int
- (1);
val it = 1 : int
- #1 (1, 2);
val it = 1 : int
- #1 (1);
Error: operator and operand don't agree [literal]
  operator domain: {1:'Y; 'Z}
  operand:         int
  in expression:
    (fn {1=1,...} => 1) 1
```

#### Lists
The big differences between lists and tuples are...

- We use brackets (not parenthesis) to construct them.
- Everything in the list must be the same type

```sml
- [1,2,3];
val it = [1,2,3] : int list
- [1.0,2.0];
val it = [1.0,2.0] : real list
- [true];
val it = [true] : bool list
- [(1,2),(1,3)];
val it = [(1,2),(1,3)] : (int * int) list
- [[1,2,3],[1,2]];
val it = [[1,2,3],[1,2]] : int list list
```

##### The Empty List and the `'a` Type.
```sml
- [];
val it = [] : 'a list
- nil;
val it = [] : 'a list
```

We see in the above code block that...

- Empty list is `[]` or `nil`
- The unknown type of the empty list is `: 'a list`
- Any variable name beginning with an apostrophe is a type variable; it stands for a type that is unknown
- `'a list` means the type is a list of elements with unknown type

Testing whether a list is empty can be done by an equality check but the preferred method is to use a predefined function, `null x`, like in the following example.

```sml
- null [];
val it = true : bool
- null [1,2,3];
val it = false : bool
```

##### The `@` operator
In SML, the `@` operator is used to concatenate lists.
```sml
 - [1,2,3]@[4,5,6];
val it = [1,2,3,4,5,6] : int list
 ```

Note: `[1]@[2,3,4]` is equivalent to `1::[2,3,4]`, and that `1@[2,3,4]` is **invalid**.

##### The `::` operator
In SML, the `::` operator is used as a way of including and or accessing single elements at the head of a list. h
```sml
- val x = #"c"::[];
val x = [#"c"] : char list
- val y = #"b"::x;
val y = [#"b",#"c"] : char list
- val z = #"a"::y;
val z = [#"a",#"b",#"c"] : char list
```

The `::` operator is **Right Associative**.
```sml
- val z = 1::2::3::[];
val z = [1,2,3] : int list
```

The `hd` and `tl` functions return the head or tail from a list respectively. The tail is the entire list besides the head of the list.
```sml
- val z = 1::2::3::[];
val z = [1,2,3] : int list
- hd z;
val it = 1 : int
- tl z;
val it = [2,3] : int list
- tl(tl z);
val it = [3] : int list
- tl(tl(tl z));
val it = [] : int list
```

##### `explode` and `implode`
We use `explode x` to turn a string into a list of char, and we use `implode x` to turn a list of char into a string.

```sml
- explode "hello";
val it = [#"h",#"e",#"l",#"l",#"o"] : char list
- implode [#"h",#"i"];
val it = "hi" : string
```

### Defining Functions
The constructor `fun` defines a new function and binds it to a variable. Functions are types, so `fun` is actually a type constructor. The following example defines a function called `firstChar`, which is meant to return the first character of  a string, and then calls `firstChar` on the string `"abc"`.

````sml
- fun firstChar s = hd (explode s);
val firstChar = fn : string -> char
- firstChar "abc";
val it = #"a" : char
```

#### The Grammar for an ML Function Definition

```
{fun-def} ::=
fun {function-name} {parameter} = {expression} ;
```

Where...

- {function-name} can be any legal ML name
- The simplest {parameter} is just a single variable name: the formal parameter of the function
- The {expression} is any ML expression; its value is the value the function returns
- This is a subset of ML function definition syntax

#### Fun as the Type Constructor.
The type constructor for functions shows the domain on the left side and the co-domain (or range) on the right side.
So `int -> real` is the type of a function that takes an int parameter (the domain) and produces a real result (the range/co-domain type).

#### Function Parameters
ML functions can only take one parameter. In order to pass multiple parameters, you must use a tuple.
```sml
- fun quot(a,b) = a div b;
val quot = fn : int * int -> int
- quot (6,2);
val it = 3 : int
- val pair = (6,2);
val pair = (6,2) : int * int
- quot pair;
val it = 3 : int
```

#### Recursive Functions

The classic recursive example is the factorial function, and the sml version is in the following code block.
```sml
- fun fact n =
=   if n = 0 then 1
=   else n * fact(n-1);
val fact = fn : int -> int
```

In the following recursive function, which adds up the elements of an integer list, a common recursive strategy is used. The base case checks for nil, and the recursive case recalls the function.
```sml
- fun listsum x =
=   if null x then 0
=   else hd x + listsum(tl x);
val listsum = fn : int list -> int
```

Here is another recursive function that reverses a list.
```sml
- fun reverse L =
=   if null L then nil
=   else reverse(tl L) @ [hd L];
val reverse = fn : 'a list -> 'a list
- reverse [1,2,3];
val it = [3,2,1] : int list
```

### More on ML Types and Type Innotations

Recall that ML type annotations will have the primitive types `bool`, `int`, `real`, `string`, and `char`.  Along with the primitives we know there are some type constructors included in the type annotations. There is `*` for tuples. `list` for lists, and `->` for functions.

#### Construction Precedence
When combining constructors, the precedence is `list` >>  `*` >> `->`. See the following.

```sml
 int * bool list
 (* Same as *)
 int * (bool list)

 int * bool list -> real
 (* Same as *)
 (int * (bool list)) -> real
 ```

#### Type Annotations
ML is more often than not, capable of inferring types based on the operations or functions being called. There are some defaults that can cause issues.

```sml
- fun prod(a,b) = a * b;
val prod = fn : int * int -> int
```

The above function shows that `int` is the type inferred by default when the the `*` operator is being used. This is also true of the `+` an `-` operator. To handle the situation where defaults are note preferred, we can use the `:` symbol to annotate types in declarations.

```sml
- fun prod(a:real,b:real):real = a*b;
val prod = fn : real * real -> real
```

## Further Reference

[The SML User Guide](http://www.smlnj.org/doc/FAQ/index.html)

[Extensive Notes on SML](http://www.cs.cornell.edu/riccardo/prog-smlnj/notes-011001.pdf)

[A Crash Course on ML, Written in ML](./ml.ml)

## Exam Stuff
- Prolog Definitions
- ML Programs Higher Order Programs, such as myMap, myFoldL
- Cheat Sheet
- Multiple Choice