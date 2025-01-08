#import "@preview/commute:0.2.0": node, arr, commutative-diagram



#show heading: h => {
  if(h.level == 1){
    set text(size: 18pt)
  }else if(h.level == 2){
    set text(size: 16pt)
  }
  h
  v(0.5em)
}

#set text(font: "Times New Roman")
#set par(
  leading: 1.2em,
  first-line-indent: 2em)

#let indent = h(2em)

= An interestring idea and thinking for the quesiton

Author: Duolei Wang

== 1. Core idea

=== 1. Initial question
#indent
Firstly, we need to understand our question of the "Level 5 / 7 : Rewriting".

$
&"Objects"&&\
&quad "P Q R S: Prop"&\
&"Assumptions"&\
&quad "h1": R ↔ S&\
&quad "h2": ¬((P → Q ∨ ¬S) ∧ (S ∨ P → ¬Q) → S → Q) ↔ P ∧ Q ∧ ¬S&\
&"Goal":\
&quad ¬((P → Q ∨ ¬R) ∧ (R ∨ P → ¬Q) → R → Q) ↔ P ∧ Q ∧ ¬R&\
$

=== 2. The transformation of equivalent form
#indent
Denote the h2 as "hypothesis":
$
  "hypothesis": ¬((P → Q ∨ ¬S) ∧ (S ∨ P → ¬Q) → S → Q) ↔ P ∧ Q ∧ ¬S\
$
#indent
For short, we use "LHS, RHS" to see it's structure
$
  "hypothesis": "LHS(P, Q, S)" &<-> "RHS(P, Q, S)"\
  "LHS(S)" &<-> "RHS(S)"\
$
#indent
What we want is to prove
$
  "equation": "LHS(R)" &<-> "RHS(R)"\
$
Use the above notation, we have
$
&"Objects"&&\
&quad "P Q R S: Prop"&\
&"Assumptions"&\
&quad "equivalence": R ↔ S&\
&quad "hypothesis": "LHS(S)" <-> "RHS(S)"&\
&"Goal":\
&quad "equation": "LHS(R)" <-> "RHS(R)"&\
$


=== 3. What we can do?
#indent
We can use the "apply" tactic to change our target, i.e.
$
  &"|target": B\
  &|h: A-> B\
  "apply F"=>&"|target*": A
$

#indent
As a result, if we can prove the existence of some "F" in Lambda Term, such that
$
  F:"hypothesis" -> "euqation", \
  ("LHS(S)" <-> "RHS(S)") |-> ("LHS(R)" <-> "RHS(R)")
$
#indent
then, we can use "apply F" to get our new target $"LHS(S)" <-> "RHS(S)"$, who is just the hypothesis we have. As a result, we can use "assumption" to kill it.

= 2. Build the "F" in L-term

#indent
I want to build and prove a theorem that for any Propositional Logic structure, we can substitute any term S with logical equivalent term R. But I found I can't use the *pattern match* in the question. So, maybe it's nearly impossible to prove the "substitution theorem" for general logic equation (At least I can't make it at the moment). So, we can try to make it partially. I mean, after the "apply Iff.intro", what we need is just one side of "F". We denote the start with "\*", it looks like


#align(center)[#commutative-diagram(
  node((0, 0), "target:"),
  node((0, 1), "LHS(R)"),
  node((0, 2), "RHS(R)"),
  node((1, 0), "Hypothesis:"),
  node((1, 1), "LHS(S)"),
  node((1, 2), "RHS(S)"),
  arr("LHS(R)", "RHS(R)", ""),
  arr("LHS(S)", "LHS(R)", $F_"left"$, "dashed", label-pos: right, curve: -30deg),
  arr("LHS(S)", "RHS(S)", ""),
  arr("RHS(S)", "RHS(R)", $F_"right"$, label-pos: right, "dashed", curve: -30deg),
  // arr("LHS(R)*", "RHS(S)", "after 'apply'", "dashed"),
  arr("LHS(R)", "LHS(S)", $F^(-1)_"left"$, "dashed", label-pos: right, curve: -30deg),
  arr("LHS(S)", "RHS(S)", ""),
  arr("RHS(R)", "RHS(S)", $F^(-1)_"right"$, label-pos: right, "dashed", curve: -30deg),
)]

After the tactic "apply F_right", our new target will be $"LHS(R)" -> "RHS(S)"$:

#align(center)[#commutative-diagram(
  node((0, 0), ""),
  node((0, 1), "LHS(R)"),
  node((0, 2), "RHS(R)"),
  node((1, 0), "Hypothesis:"),
  node((1, 1), "LHS(S)"),
  node((1, 2), "RHS(S)"),
  // arr("LHS(R)*", "RHS(R)", ""),
  // arr("RHS(R)", "LHS(R)", ""),
  arr("LHS(S)", "RHS(S)", ""),
  // arr("RHS(S)", "LHS(S)", ""),
  arr("RHS(S)", "RHS(R)", "F_right", label-pos: right, "dashed"),
  arr("LHS(R)", "RHS(S)", "targer after 'apply'", label-pos: right, curve: 30deg),
)]


As we can use lambda term with type annotation like $"fun x :  P ∧ Q ∧ ¬S " => ...$, I give a construction for the "F_right":

#align(center)[
```lean
// apply F_right:  P ∧ Q ∧ ¬S =>  P ∧ Q ∧ ¬R
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
```
]
#indent
The key is to catch a term with type annotation, then use deconstructor to cut, rearrange the pieces. The next step is using "apply Hypothesis"; then we need to prove:

$
  "target: LHS(R)" -> "LHS(S)"
$

which the "inverse" of part of "F" in previous graph:

#align(center)[#commutative-diagram(
  node((0, 0), "target:"),
  node((0, 1), "LHS(R)"),
  node((0, 2), "RHS(R)"),
  node((1, 0), "Hypothesis:"),
  node((1, 1), "LHS(S)"),
  node((1, 2), "RHS(S)"),
  arr("LHS(R)", "RHS(R)", ""),
  arr("LHS(S)", "LHS(R)", $F_"left"$, "dashed", label-pos: right, curve: -30deg),
  arr("LHS(S)", "RHS(S)", ""),
  arr("RHS(S)", "RHS(R)", $F_"right"$, label-pos: right, "dashed", curve: -30deg),
  // arr("LHS(R)*", "RHS(S)", "after 'apply'", "dashed"),
  arr("LHS(R)", "LHS(S)", $F^(-1)_"left"$, "dashed", label-pos: right, curve: -30deg),
  arr("LHS(S)", "RHS(S)", ""),
  arr("RHS(R)", "RHS(S)", $F^(-1)_"right"$, label-pos: right, "dashed", curve: -30deg),
)]

And here, I believe it's a little bit difficult to but such $F^(-1)_"left"$ only in L-term. So I just write this document for fun.