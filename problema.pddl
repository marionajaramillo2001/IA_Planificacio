(define (problem exemple) (:domain planificador)
    (:objects 
        p1 p2 - programador
        t1 t2 - tasca
    )

    (:init
        (= (tasques_assginades) 0)
        (= (suma_hores) 0)
        (= (programadors) 0)

        ; programadors
        (= (habilitat p1) 1)
        (= (habilitat p2) 2)
        (= (qualitat p1) 2)
        (= (qualitat p2) 1)

        (= (noves_assginacions p1) 2)
        (= (noves_assginacions p2) 2)

        ; tasques
        (= (dificultat t1) 2)
        (= (dificultat t2) 2)
        (= (duracio_tasca t1) 2)
        (= (duracio_tasca t2) 4)

        (tasca_oberta t1)
        (tasca_oberta t2)
    )

    (:goal
        (= (tasques_assginades) 2)
    )

    ; Mètrica: programadors_totals * suma_hores + suma_hores_tasques * programadors
    (:metric minimize (+ (* 2 (suma_hores)) (* 6 (programadors))))
)
