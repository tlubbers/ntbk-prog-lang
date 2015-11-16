# Program Verification

## Formal Semantics
We want a way to prove program correctness in respect to its semantics that is precise and mathematical, not neccesarily intuitive. There is a formal system of axioms and rules for inferring valid specification to do this.

### Axioms and Rules

Below is a list of Axioms and Rules that will serve as the tools we need to prove a program is correct.

```
{ P } skip { P }
{ true } diverge { false }

/* Assignment */
{ [P](i->E) } i := E { P }

/* Grouping   */
{ P } C {Q} ⇒ { P } ( C ) { Q }

/* Sequencing */
{ P } C0 {Q} & { Q } C1 { R } ⇒ { P } C0 ; C1 { R }

/* If Statement */
{ P, B } C0 {Q} & { P, ¬B } C1 { Q }
   ⇒ { P } if B then C0 else C1 { Q }

/* While Loop */
{ P, B } C { P } ⇒ { P } while B do  C { P, ¬B }

/* Pre-Condition Strengthening */
{ P ⊃ R} & { R } C { Q } ⇒ { P } C { Q }

/* Post-Condition Weakening */
{ R ⊃ Q} & { P } C { R } ⇒ { P } C { Q }

/* Pre-Condition Disjunction (OR) */
{ P1} C { Q } & { P2} C { Q } ⇒ { P1 ∨ P2 } C { Q }

/* Post-Condition Conjuction (AND) */
{ P} C { Q1 } & { P} C { Q2 } ⇒ { P } C { Q1, Q2 }

```

### Example of Really Basic Proof Axioms

Below, we use the assignment axiom to prove a program with a single declaration (n:=n+1) is correct.
```
{ ( n+1) ≥ 0 }
n := n+1;
{ n ≥0 }
/* Were using assignment, {[P](i→E)} i := E {P}, where [P](i→E) is [n ⇾ 0](n→n+1) */
```






