# MIL for me

# Ch0. Basis of Lean

## construction as proof

### Essential philosophy of proof theory.

### sorry/admit as the placeholder

Toughly speaking, the assistant theorem prover Lean will give you some information on the last sentence; we need a placeholder to kill the **unsolved goal** error in the last line, which is the tactics **sorry** or **admit**.

Use **sorry**, we killed the **unsolved goal** of and move the position of checking to the sentences we're writing.

### essentials

- equality


- computation


- change the equation through congrArg
  a = b -> f a = f b



### constructor and eliminator

**define with pattern matching**

- FP style (**lambda abstraction with match**)
- guarder style (**|**)


### the principle of naming in Lean

**Descriptions of theorem**

- add_comm
- add_assoc
- mul_comm
- mul_assoc
- inv_mul_cancel
- right_mul_invariant_imp_one
- le_refl
- le_trans
-

**Descriptions of action-like**

- one_mul
- one_add_one_eq_two


**A is equivalent to B**

- sub_eq_add_neg



**structure_action_position**

- min_le_left

## Fundamentals of Tactics and Theorem Use



### calc



### rw

A = b

- forward (->)
- backward (<-)


### exact



### apply

Sometimes, if our target is a result from some existing theorem (the rhs of implication), we can use the **apply** to retract the target into the parameters of the theorem we want use.



**apply with holes**

**the dot symbol**

### match with and induction with

Sometimes, the parameters of our target is constructor, we need to eliminate it to different cases.

> For example: k is a natural number, then 2 * k + 1 is odd.
> As it's a standard number theory problem, if we want to prove it, we need to split the input "x" by even the even case and odd case; then, glue them together. In this situation, we can use tactic-like style through some theorem like "natural_is_even_or_odd" to build a single problem to an equivalent proof pipeline but more specified.



#### Eliminate a theorem

Some theorems claim on structure defined with different cases. For the finite construct, we can use the keyword **match**; for those inductive structure, we need the keyword **induction ... with ...**


Also, one can just use the constructor to give the whole proof of the theorem (construction of the structure).
```lean
theorem h: 1 = 1 ∧ 2 = 2 := by
  have lhs: 1 = 1 := by trivial
  have rhs: 2 = 2 := by trivial
  exact ⟨lhs, rhs⟩
```

**match a finite structure**


**induction**




### refine

### ring

### linarith


### Search By apply?


# Ch1. Fundamentals of Mathematical Structure

## Order

### min

- min_le_left
- min_le_right
-



## Set

## Functions

## Number Theory

## Basic Algebra

## Topological Space

## Filiter and Limitation

## Linear Algebra

## Measure Theory

## Differential Calculus
