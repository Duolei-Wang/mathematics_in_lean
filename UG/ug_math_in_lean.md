# ug_math_in_lean

# 0. Preliminaries

I suppose that the readers are familiar with the fundamental documents on the Lean4 official website. This draft document intends to introduce the construction of the undergraduate-level math in Lean4.

The keyword with **bold** in markdown means the keyword in Lean4.

**bold**

Generally, I use the bold-style word to represent the keyword in Lean4 or Type Theory and the _italic-style_ word with the first alphabet in the upper to represent the concept in Math.



# 1. Necessary Type Theory and Set Theory

I have no time and ability to write a self-contained document for learning type theory, or Lean4, or programming language theory right now, as I'm also a beginner. So, I write a framework for the possible future note/book. If there are any readers, please learn by yourself.



## The First Cause: where does the first type come from?

We always build new things from existing ones; the process of building is infinite. If we already have a floor 0, we can try to build a floor 1.

The following parts may not be so explicit, and I just use them to review some important ideas. The ones who feel they are ambiguous should try to find more materials.

**Primitive Type**

Programming languages need some existing things; the Type Theory is the same. If one is skeptical about where the first thing comes from, I have no answer.

**Nat: Type**

The code "Nat: Type" means the "Nat" is a "Type", or "Nat" is just a **Name** (String) primitive Type, or "Nat" has the **Sort 0** level. If one has read some books about untyped Lambda Calculus, it's clear that we have an existing Variable Name set. But,

- Where do the initial strings in the Variable Set come from?

  I don't know how to answer this question; I think there always needs some constructors to make it. You may accept them as axioms, I think.

- Where do the primitive types come from?

  The question is similar to "Where does the initial type 'int' in C programming language come from?". Usually, a programming language can create a new "class" or "structure".



In short, I hope that up to here, one can accept we human beings also just consider something as an axiom and then accept it. Maybe those axioms come from intuition; I have no solution.

Right now, I hope those who are always curious about the first thing can accept that there could be some axioms or declared types. Besides, we can also build some primitive level types from existing through the following methods.

The core idea of type theory contains formalism, so the implementation is also influenced by it. As a result, we can see some "axioms" and the computation on them.



## Build new types from primitive type

- Product

  We can claim a new type as a combination of existing types.

- Sum

  We can claim a new type as one of the existing types.

- Inductive types

  We can use the inductive way to build a new type.



## Maps as the Arrow Type

**f: A -> B**

We can consider the Type of maps as a **Type Constructor** or **Arrow Type**. It receives a parameter in the domain and then returns a value in the codomain.



**Currying** of multi-variable maps

For those multi-variable maps like $f: \R \times \R \to \R, (x, y) \mapsto x + y $, we can consider its type as $\R \to (\R \to \R)$, which is sequential. The correspondence here is very clear, as the sequential list (the vector) and the right-hand side type both reserve the "order."



As a result, the **product** type can be built from the currying.



## Implication as Arrow Type

It's very interesting that the **implication** of **propositional logic** can be considered as a map. The implication "P -> Q" means "if there is any P, we can derive Q," which is the same as the map "f: N -> N," meaning "give me a number in N, I can get a new number (through f)."









## Quantifier Logic, Product Type, Sum Type

One should read some Type Theory book to find that the idea of defining quantifier $\exist$ and $\forall$. Usually, if we want to prove some propositions in the quantifier $\exist x : A, B$, we need at least an element and a proof based on the element. As a result, it's similar to using $a, a \to B$ to construct the structure. The existence quantifier is just a structure.

But for the quantifier $\forall x : A, B$, which describes the ability to build a proof from the left type to the right type. So, it's similar to the feeling of a map $A \to B$.

> The description here may not be so explicit; I just want to share the idea.
>
> One will see the **tactic "use"** in the documents of Lean4; it is just a version of **refine**, which is useful for filling some positions of those constructive proofs.
>
> I mean, $\exist x : \N, x > 1$ is corresponding to a structure built from an existing $x'$ and a proof from the $x'$. If we provide the element $x'$, combined with a proof on it, we can call the constructor of the **Existence** structure in Lean4. It's slightly different from the feeling of the quantifier $\forall$, which can be proved provided a path.
>
> One can check the information of the following two code blocks after the "refine" and the "use" to feel it:
>
> ```lean
> example:
> ∃ n : ℕ, n >= 2
> := by
>   refine ⟨3, ?_⟩
>   trivial
> ```
>
> ```lean
> example:
> ∃ n : ℕ, n >= 2
> := by
>   use 3
>   trivial
> ```





## Type Level: Type u, Type*

**Type u**

The keyword **Type** combined with a **Name** creates a fresh new type named Name. The keyword **Type** can be considered a constructor from String to the **Term** in Lean.

> **Type abc** means a type named "abc".

Different types have different **Level**s; the **Prop** is the type that has the **Sort 0** level.



## 1.4











## 2. Simple Set Theory

**Set**

The keyword **Set** in Lean4 has the **Type**:

```lean
Set: a -> Prop
```

where the $a$ is a **Type** with level Type u.

As **Prop** is also a **Type**, the keyword **Set** is just a **type constructor** receiving a type to build a new type. The definition means the keyword **Set** in Lean4 is different from the concept _Set_ in Math.

The concept _Set_ in Math has the form (write in Lean4):

```lean
S_1 := {n : N | n <= 4}
```

where the left half part indicates the type $\alpha$ of our **Set**, the right half part indicates the predicate that all the elements in the _Set_ satisfy our **Predicate**.



**Fintype**

The **Fintype $\alpha$ ** means the **Type** $\alpha$ has only finite **values**, i.e. finite different elements.

To build a **Fintype** $\alpha$ , we need to





**Fin**













> Set builder syntax. This can be elaborated to either a `Set` or a `Finset` depending on context.
>
> The elaborators for this syntax are located in:
>
> - `Data.Set.Defs` for the `Set` builder notation elaborator for syntax of the form `{x | p x}`, `{x : α | p x}`, `{binder x | p x}`.
> - `Data.Finset.Basic` for the `Finset` builder notation elaborator for syntax of the form `{x ∈ s | p x}`.
> - `Data.Fintype.Basic` for the `Finset` builder notation elaborator for syntax of the form `{x | p x}`, `{x : α | p x}`, `{x ∉ s | p x}`, `{x ≠ a | p x}`.
> - `Order.LocallyFinite.Basic` for the `Finset` builder notation elaborator for syntax of the form `{x ≤ a | p x}`, `{x ≥ a | p x}`, `{x < a | p x}`, `{x > a | p x}`.

**Finset, **





The notation "{}" here calls the constructor of **Set**. For example, we can always build an empty set over any given type.

```lean
def S_2 : Set a := ∅
def S_3 : Set a := {}
```

Also, we can build a _Finite Set_ by filling its elements. The "," symbol combined with "{}" is also a declared macro for calling the constructor methods.

```
def S_3 : Finset ℕ := {1, 2, 3}
```

> One can find it in the file Core.lean that it calls the "insert e set" method like the





**List**

The **List** is isomorphic to a sequence-like vector.


**Multiset**

The **Multiset** is unordered and allows its elements to be same.


**Finset**

The **Finset** is unordered, which can be considered as the no duplicates version of **Multiset**.
