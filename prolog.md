# Prolog

Prolog is a logical language, meaning the core of prolog is the interpretation of logical statements. Prolog is also _declaritive_, which means the program logic is expressed in terms of _relations_, represented as _facts_ and _rules._ A computation is made by prolog by running a _query_ over these relations. This is a bit weird; not very many popular programming languages are declaritive. So yay.

## Terms

Everything in Prolog is built from terms:
- Prolog programs
- The data manipulated by Prolog programs

Three kinds of terms:
- **Constants**: integers, real numbers, atoms
- **Variables**
- **Compound terms** (predicates)

## Facts, Rules and Queries

## Facts

There are three constructs in prolog; queries, facts, and rules.

Facts are used to state things that are unconditionally true of some situation of interest. For example, we can state that Mia, Jody, and Yolanda are women, that Jody plays air guitar, and that a party is taking place, using the following five facts:

```prolog
woman(mia).
woman(jody).
woman(yolanda).
playsAirGuitar(jody).
party.
```

### Queries

The above collection of facts is actually a prolog program. Simple maybe, but still a program. To use the program, we ask questions, or we "query".

```prolog
?-  woman(mia).
?-  playsAirGuitar(jody).
?-  party.
?-  rockConcert.
```

The above queries end up giving the results yes, yes, yes, no.  Notice the last one wasn't defined at all in the original collection of facts. Therefore prolog answers that query with a no, as it should. Also, that collection of facts is referred to as a **knowledge base**. This particular knowledge base has 4 **clauses**. Rules, which are seen in the next section, also count as clauses.

### Rules

Here is another knowledge base. This one contains facts as well, but the last three are  rules.

```prolog
happy(yolanda).
listens2Music(mia).
listens2Music(yolanda):-  happy(yolanda).
playsAirGuitar(mia):-  listens2Music(mia).
playsAirGuitar(yolanda):-  listens2Music(yolanda).
```
Rules state information that is conditionally true of the situation of interest. For example, the first rule says that Yolanda listens to music if she is happy, and the last rule says that Yolanda plays air guitar if she listens to music. More generally, the :- should be read as “if”, or “is implied by”. The part on the left hand side of the :- is called the **head** of the rule, the part on the right hand side is called the **body**. So in general rules say: if the body of the rule is true, then the head of the rule is true too.

### The Keypoint is
**If a knowledge base contains a rule head  :-  body, and Prolog knows that body follows from the information in the knowledge base, then Prolog can infer head.** This is called modus ponens.

The following example illustrates this point in action.

The query `?-  playsAirGuitar(mia).` returns yes, evem though no explicit `playsAirGuitar(mia).` fact is present in the knowledge base. Since `listensToMusic(mia).` is explicitly declared and a rule exists that states `playsAirGuitar(mia):-  listens2Music(mia).`, prolog can infer that mia plays air guitar.


<!--
### Rules

The following is a predicate rule declaration.
```prolog
greatgrandparent(GGP,GGC) :-
    parent(GGP,GP),
    parent(GP,P)
    parent(P,GGC).
```

Some terminology for the above rule: `greatgrandparent` above is the **head** or predicate. The symbol `:-` is the _if_ and the list of `parent` facts are the _conditions._

A rule says how to prove something to prove the head, roe the conditions.

#### Programs with a Rule

A program consists of a list of clauses. A clause is either a fact or a rule and ends with a period.

Internally there are intermediate _goals_:
- The first goal is the initial query.
- The next goal is what remains to be proved after transforming the first goal using one of the clauses(in this case, the `greatgrandparent` rule)


#### Recursive Rule

X is an ancestor of Y if:
- Base case: X is a parent of Y.
- Recursive case: there is some Z such that, Z is a parent of Y, and X is an ancestor of Z.

```prolog
ancestor(X,Y) :- parent(X,Y).

ancestor(X,Y) :-
  parent(Z,Y), ancestor(X,Z).

```

## The Overall Syntax

Prolog is a very simple language. Syntactically, it is!

```prolog
<clause> ::=  <fact> | <rule>
<fact> ::=  <term> .
<rule> ::=  <term> :- <termlist> .
<termlist> ::=  <term> | <term> , <termlist>

<term> ::= <constant> | <variable> | <compound-term>
<constant> ::= <integer> | <real number> | <atom>
<compound-term> ::= <atom> ( <termlist> )
<termlist> ::= <term> | <term> , <termlist>

```

## Procedural and Declaritive Aspects of Prolog

There are two faces to Prolog. It is partially procedural and partially declaritive.

### Procedural

```prolog
greatgrandparent(GGP,GGC) :-
  parent(GGP,GP), parent(GP,P), parent(P,GGC).

```

A rule says how to prove something, i.e., specifies proof procedures for queries

To prove `greatgrandparent(GGP,GGC):`
- find some GP and P
- prove `parent(GGP,GP)`
- prove `parent(GP,P)`
- prove `parent(P,GGC)`

### Delcaritive

A rule is a logical assertion:
- For all bindings of GGP, GP, P, and GGC, if `parent(GGP,GP)` and `parent(GP,P)` and `parent(P,GGC)`, then `greatgrandparent(GGP,GGC)`
- It just makes an assertion:

#### A Declaritve Language

- Each piece of the program corresponds to a simple mathematical abstraction
    - Prolog clauses – formulas in first-order logic
    - ML fun definitions – functions
- Many people use declarative as the opposite of imperative, including both logic languages and functional languages

##### Advantadges to Declaritive Languages
- Imperative languages are doomed to subtle side-effects and interdependencies

- Simpler declarative semantics makes it easier to develop and maintain correct programs

- Higher-level, more like automatic programming: we describe the problem and let the computer solve the program

## Operators
- Prolog has some predefined operators (and the ability to define new ones)

- An operator is just a predicate for which a special abbreviated syntax is supported

### The = predicate
The goal =(X,Y) succeeds if and only if X and Y can be unified:

```prolog
?- =(parent(adam,seth),parent(adam,X)).

X = seth

Yes
```

Since  =  is an operator, we can :
```prolog
?- parent(adam,seth)=parent(adam,X).

X = seth

Yes
```

### Arithmetic
Predicates +, -, * and / are operators too, with the usual precedence and associativity

```prolog
?- X = +(1,*(2,3)).

X = 1+2*3

Yes
?- X = 1+2*3.

X = 1+2*3

Yes

```
Prolog lets you use operator notation, and prints it out that way, but the underlying term is still +(1,*(2,3))

**Will not be evaluated!!**

#### Not Evaluated?
```prolog
?- +(X,Y) = 1+2*3.

X = 1
Y = 2*3

Yes
?- 7 = 1+2*3.

No

```
- The term is still +(1,*(2,3))
- It is not evaluated
- There is a way to make Prolog evaluate such terms, but we won’t need it yet

## Lists
A bit like ML lists
- The atom [] represents the empty list
- A predicate . corresponds to ML’s :: operator

```
ML expression   |   Prolog term

[]              |   []
1::[]           |   .(1,[])
1::2::3::[]     |   .(1,.(2,.(3,[])))
No equivalent.  |   .(1,.(parent(X,Y),[]))

[]              |   []
[1]             |   .(1,[])
[1,2,3]         |   .(1,.(2,.(3,[])))
[1,parent(X,Y)] |   .(1,.(parent(X,Y),[]))

With Tails
[1|X]           |   .(1,X)
[1,2|X]         |   .(1,.(2,X)))
[1,2|[3,4]]     |   same as [1,2,3,4]


```
Prolog tries rules in the order of their definitions, so put base-case rules and facts first

### The `append` Predicate

```prolog
?- append([1,2],[3,4],Z).

Z = [1, 2, 3, 4]

Yes
```

Predefined append(X,Y,Z) succeeds if and only if Z is the result of appending the list Y onto the end of the list X

```prolog
?- append(X,Y,[1,2,3]).

X = []
Y = [1, 2, 3] ;

X = [1]
Y = [2, 3] ;

X = [1, 2]
Y = [3] ;

X = [1, 2, 3]
Y = [] ;

No
```

```prolog
%base case
append([], B, B).
%recursion
append([Head|TailA], B, [Head|TailC]) :-
  append(TailA, B, TailC).

```

### Other Predicates

`member(X,Y)`
`select(X,Y,Z)`
`nth0(X,Y,Z)`
`length(X,Y)`

- All flexible, like append
- Queries can contain variables anywhere


## Example Prolog Problems


```prolog
% 1.01 (*) Find the last element of a list.
mylast(E, [E]).
mylast(E, [_|T]) :- mylast(E, T).

% 1.02 (*) Find the last but one element of a list.
mypenult(E, [E,_]).
mypenult(E, [_|T]) :- mypenult(E, T).

% 1.03 (*) Find the Kth element of a list.
myindex(H, [H|_], 1).
myindex(E, [_|T], X) :-
  X > 1,
  Xn is X - 1,
  myindex(E, T, Xn).

% 1.04 (*) Find the number of elements of a list.
count(0, []).
count(C, [_|T]) :- count(X, T), C is X + 1.

% 1.05 (*) Reverse a list.
myreverse([], []).
myreverse(R, [H|T]) :- myreverse(SubR, T), append(SubR, [H], R).

% 1.06 (*) Find out whether a list is a palindrome.
palindrome(L) :- myreverse(L, L).

% 1.07 (**) Flatten a nested list structure.
is_list([]).
is_list([_|T]) :- is_list(T).
my_flatten([], []).
my_flatten([H|T], F) :- my_flatten(T, SubF), is_list(H), !, append(H, SubF, F).
my_flatten([H|T], F) :- my_flatten(T, SubF), append([H], SubF, F).
% FIXME only works one level down

% 1.08 (**) Eliminate consecutive duplicates of list elements.
squash([], []).
squash([E], [E]).
squash([H|[TH|TT]], S) :- H = TH, squash(TT, SubS), append([H], SubS, S).
squash([H|[TH|TT]], S) :- H \= TH, squash([TH|TT], SubS), append([H], SubS, S).
% FIXME halves the runs, does not completely squash

% 1.09 (**) Pack consecutive duplicates of list elements into sublists.

% 1.10 (*) Run-length encoding of a list.

% 1.11 (*) Modified run-length encoding.

% 1.12 (**) Decode a run-length encoded list.

% 1.13 (**) Run-length encoding of a list (direct solution).

% 1.14 (*) Duplicate the elements of a list.
dupel([], []).
dupel([E], [E, E]).
dupel([H|T], D) :- dupel(T, Dn), dupel([H], Hn), append(Hn, Dn, D).

% 1.15 (**) Duplicate the elements of a list a given number of times.
dupeln([], _, []).
dupeln(_, 0, []).
dupeln([E], 1, [E]).
dupeln([E], N, D) :-
  N > 1,
  Nn is N - 1,
  dupeln([E], Nn, Dn),
  append([E], Dn, D).
dupeln([H|T], N, D) :-
  dupeln(T, N, Dn),
  dupeln([H], N, Hn),
  append(Hn, Dn, D).

% 1.16 (**) Drop every Nth element from a list.

% 1.17 (*) Split a list into two parts; the length of the first part is given.
mysplit(L, [], L, 0).
mysplit([H|T], FP, R, L) :-
  Ln is L - 1,
  append([H], SubFP, FP),
  mysplit(T, SubFP, R, Ln).
% FIXME do without append/3

% 1.18 (**) Extract a slice from a list.
myslice(L, I, J, R) :-
  mysplit(L, SubR, _, J),
  In is I - 1,
  mysplit(SubR, _, R, In).

% 1.19 (**) Rotate a list N places to the left.
myrotate(L, R, N) :-
  count(C, L),
  Nn is N mod C,
  mysplit(L, F, S, Nn),
  append(S, F, R).

% 1.20 (*) Remove the Kth element from a list.
remove_at(L, R, X, N) :-
  Nn is N - 1,
  mysplit(L, F, S, Nn),
  [X|T] = S,
  append(F, T, R).

% 1.21 (*) Insert an element at a given position into a list.
insert_at(L, R, E, N) :-
  Nn is N - 1,
  mysplit(L, F, S, Nn),
  append(F, [E], SubR),
  append(SubR, S, R).

% 1.22 (*) Create a list containing all integers within a given range.
myrange(E, E, [E]).
myrange(S, E, L) :-
  S =< E,
  Sn is S + 1,
  myrange(Sn, E, SubL),
  append([S], SubL, L).

% 1.23 (**) Extract a given number of randomly selected elements from a list.
random_elements(_, 0, []).
random_elements(L, N, R) :-
  Nn is N - 1,
  count(C, L),
  Cn is C + 1,
  random(1, Cn, I),
  remove_at(L, SubL, E, I),
  random_elements(SubL, Nn, SubR),
  append(SubR, [E], R).

% 1.24 (*) Lotto: Draw N different random numbers from the set 1..M.
lotto(_, 0, []).
lotto(M, N, R) :-
  N > 0,
  Nn is N - 1,
  lotto(M, Nn, SubR),
  random(1, M, I),
  append(SubR, [I], R),
  fd_all_different(R).
% FIXME local stack overflow
% N goes negative when fd_all_different fails
% lotto(_, 0, []) does not match
% it says to combine the answers for 1.22 and 1.23, but eh

% 1.25 (*) Generate a random permutation of the elements of a list.
permute(L, R) :- count(C, L), random_elements(L, C, R).

% 1.26 (**) Generate the combinations of K distinct objects chosen from the N elements of a list

% 1.27 (**) Group the elements of a set into disjoint subsets

% 1.28 (**) Sorting a list of lists according to length of sublists
```
-->