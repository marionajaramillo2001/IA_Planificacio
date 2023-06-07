(define (problem exemple) (:domain planificador)
    (:objects 
        p1 p2 - programador
        t1 t2 - tasca
        r1 r2 - revisio
    )

    (:init
        (= (tasques_assginades) 0)
        (= (suma_hores) 0)

        ; programadors
        (= (habilitat p1) 1)
        (= (habilitat p2) 2)
        (= (qualitat p1) 2)
        (= (qualitat p2) 1)
        (= (propera_hora_lliure p1) 0)
        (= (propera_hora_lliure p2) 0)
        (= (noves_assginacions p1) 2)
        (= (noves_assginacions p2) 2)

        ; tasques
        (= (dificultat t1) 2)
        (= (dificultat t2) 2)
        (= (duracio_tasca t1) 2)
        (= (duracio_tasca t2) 4)

        (tasca_revisio t1 r1)
        (tasca_revisio t2 r2)

        (tasca_oberta t1)
        (tasca_oberta t2)
    )

    (:goal
        (= (tasques_assginades) 2)
    )

    (:metric minimize (suma_hores))
)
