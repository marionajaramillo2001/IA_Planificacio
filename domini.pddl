(define (domain planificador)

    (:requirements :adl :strips :fluents :typing :conditional-effects)

    (:types
        programador tasca - object
    )

    (:predicates
        (tasca_oberta ?t - tasca)
        (tasca_assignada ?t - tasca ?p - programador)
        (revisio_oberta ?t)
        (revisio_assignada ?t - tasca ?p - programador)
    )

    (:functions
        (habilitat ?p - programador)
        (qualitat ?p - programador)
        (noves_assginacions ?p - programador)
        (propera_hora_lliure ?p - programador)
        (dificultat ?t - tasca)
        (duracio_tasca ?t - tasca)
        (duracio_revisio ?t - tasca)
        (hora_tasca_assignada ?t - tasca)
        (hora_fi_tasca ?t - tasca)
        (hora_revisio_assignada ?t - tasca)
        (hora_fi_revisio ?t - tasca)
        (tasques_assginades)
        (suma_hores)
    )

    (:action assignar_tasca
        :parameters (?t - tasca ?p -programador)
        :precondition (and
            (tasca_oberta ?t)
            (> (noves_assginacions ?p) 0)
            (<= (dificultat ?t) (+ (habilitat ?p) 1))
        )
        :effect (and
            (not (tasca_oberta ?t))
            (tasca_assignada ?t ?p)
            (revisio_oberta ?t)

            (assign (hora_tasca_assignada ?t) (propera_hora_lliure ?p))

            (when (= (dificultat ?t) (+ (habilitat ?p) 1)) (and
                (increase (propera_hora_lliure ?p) 2)
                (increase (suma_hores) 2)
            ))

            (increase (propera_hora_lliure ?p) (duracio_tasca ?t))
            (decrease (noves_assginacions ?p) 1)
            (assign (hora_fi_tasca ?t) (propera_hora_lliure ?p))
            (assign (duracio_revisio ?t) (qualitat ?p))
        )
    )

    (:action assignar_revisio
        :parameters (?t - tasca ?p - programador)
        :precondition (and
            (revisio_oberta ?t)
            (not (tasca_assignada ?t ?p))
            (> (noves_assginacions ?p) 0)
            (<= (dificultat ?t) (+ (habilitat ?p) 1))
            (>= (propera_hora_lliure ?p) (hora_fi_tasca ?t))
        )
        :effect (and
            (not (revisio_oberta ?t))
            (revisio_assignada ?t ?p)
            (assign (hora_revisio_assignada ?t) (propera_hora_lliure ?p))
            (increase (propera_hora_lliure ?p) (duracio_revisio ?t))
            (assign (hora_fi_revisio ?t) (propera_hora_lliure ?p))

            (when (= (duracio_revisio ?t) 2)
                (increase (suma_hores) 1)
            )

            (increase (suma_hores) 1)
            (decrease (noves_assginacions ?p) 1)
            (increase (tasques_assginades) 1)
        )
    )
)
