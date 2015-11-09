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