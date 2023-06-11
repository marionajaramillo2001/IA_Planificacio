(define (problem jocProva1) (:domain planificador1)
(:objects
    p0 p1 - programador
    t0 t1 - tasca
)
(:init
    (= (tasques_assignades) 0)
    (= (habilitat p0) 1)
    (= (habilitat p1) 2)
    (= (qualitat p0) 2)
    (= (qualitat p1) 1)
    (= (dificultat t0) 2)
    (= (dificultat t1) 2)
    (= (duracio_tasca t0) 2)
    (= (duracio_tasca t1) 2)
    (tasca_oberta t0)
    (tasca_oberta t1)
)
(:goal
    (= (tasques_assignades) 2)
)
)