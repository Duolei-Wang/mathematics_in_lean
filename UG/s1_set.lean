import Mathlib.Data.Fin.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.card
import Mathlib.Data.Fintype.Basic
import Mathlib.Logic.Basic
import Mathlib.Tactic.Basic
-- import Mathlib.Data.Order.LocallyFinite.Basic

open Fin Finset Order Fintype


#check Fintype
#check fintype
#check Prop
#check Type
#check Set


#check Set.empty_subset
example:
{x : ℕ | x < 0} = ∅
:= by
simp


example:
∃ n : ℕ, n >= 2
:= by
  use 3
  trivial

example (P Q R S : Prop) (equiv: R ↔ S)
(equation: ¬((P → Q ∨ ¬S) ∧ (S ∨ P → ¬Q) → S → Q) ↔ P ∧ Q ∧ ¬S)
: ¬((P → Q ∨ ¬R) ∧ (R ∨ P → ¬Q) → R → Q) ↔ P ∧ Q ∧ ¬R
:= by
  constructor

  have F: (¬((P → Q ∨ ¬S) ∧ (S ∨ P → ¬Q) → S → Q) <-> P ∧ Q ∧ ¬S)
  -> ¬((P → Q ∨ ¬R) ∧ (R ∨ P → ¬Q) → R → Q) → P ∧ Q ∧ ¬R
    := by

    admit
  apply F
  assumption



  have FR: P ∧ Q ∧ ¬S -> P ∧ Q ∧ ¬R
    := by

    admit




  admit

example (P : Prop) (h : Q <-> P) (p : P)
: Q
:= by
rw[h]

admit

example (P Q R S : Prop) (equiv: R ↔ S)
(h: ¬((P → Q ∨ ¬S) ∧ (S ∨ P → ¬Q) → S → Q) ↔ P ∧ Q ∧ ¬S)
: ¬((P → Q ∨ ¬R) ∧ (R ∨ P → ¬Q) → R → Q) ↔ P ∧ Q ∧ ¬R
:= by
  apply False.elim
  have ⟨mp, mpr⟩ := h

  apply h
  rw[equiv]
  trivial




example (P Q R S : Prop) (equiv: R ↔ S)
(equation: ¬((P → Q ∨ ¬S) ∧ (S ∨ P → ¬Q) → S → Q) ↔ P ∧ Q ∧ ¬S)
: ¬((P → Q ∨ ¬R) ∧ (R ∨ P → ¬Q) → R → Q) ↔ P ∧ Q ∧ ¬R
:= by
  induction' equiv with mp mpr

  apply Iff.intro
  intro HlR

  have FR : P ∧ Q ∧ ¬S -> P ∧ Q ∧ ¬R
    := fun Right_S =>
      And.intro
        (And.left Right_S)
        (And.intro
          (And.left $ And.right Right_S)
          (
            (fun hrs => fun hns => fun a => hns (mp a)) mp (And.right $ And.right Right_S)
          )
        )
  -- apply FR

  apply (fun Right_S : P ∧ Q ∧ ¬S =>
      And.intro
        (And.left Right_S)
        (And.intro
          (And.left $ And.right Right_S)
          (
            (fun hrs
            => fun hns
            => fun a
            => hns (mp a)) mp (And.right $ And.right Right_S)
          )
        )
      )


  have hh(A B : Prop) : (B -> A )-> (¬A -> ¬B)
    := by
    exact fun a a_1 a_2 => a_1 (a a_2)

  have FL:
      ¬((P → Q ∨ ¬R) ∧ (R ∨ P → ¬Q) → R → Q)
    -> ¬((P → Q ∨ ¬S) ∧ (S ∨ P → ¬Q) → S → Q)
    := by
    apply hh

    -- (P → Q ∨ ¬R) ∧ (R ∨ P → ¬Q) → (R → Q)
    exact (
      fun (lhs : (P → Q ∨ ¬S) ∧ (S ∨ P → ¬Q) → S → Q)
      => (fun eq : (P → Q ∨ ¬R) ∧ (R ∨ P → ¬Q)
      => (fun r => (

      )
      )
      )
    )












  admit

#check Nat
def Sx : Finset ℕ := {1, 2, 3}
def Sy := {n : ℕ | n <= 4}
#print Sx


#check Set

#check EmptyCollection
