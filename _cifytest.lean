import Mathlib.Tactic
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Complex.Exponential

open Complex

example: (1 + I)^20 = -1024
:= by
  have h1: (1 + I) = (√ 2 * (cos ((Real.pi : ℂ)/ 4) + I * sin ((Real.pi : ℂ) / 4)) : ℂ) := by


    admit

  have h2: (√ 2 * (cos ((Real.pi : ℂ)/ 4) + I * sin ((Real.pi : ℂ) / 4)) : ℂ) = √ 2 * exp (I * (Real.pi / 4)) := by

    admit

  rw[h1, h2]
  ring_nf

  have h3: √2 ^ 20 = 1024 := by
    admit


  have h4: cexp (I * ↑Real.pi * (1 / 4)) ^ 20 = cexp (20 * (I * ↑Real.pi * (1 / 4))) := by

    admit


  rw[h4]
  ring_nf

  admit

example: √ 2 * Real.cos (3 * Real.pi/4) = -1
:= by

  admit
