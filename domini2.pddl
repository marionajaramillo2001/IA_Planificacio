(define (domain planificador2)

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
        (dificultat ?t - tasca)
        (duracio_tasca ?t - tasca)
        (duracio_revisio ?t - tasca)
        (tasques_assignades)
        (suma_hores)
    )

    (:action assignar_tasca
        :parameters (?t - tasca ?p -programador)
        :precondition (and
            (tasca_oberta ?t)
            (<= (dificultat ?t) (+ (habilitat ?p) 1))
        )
        :effect (and
            (not (tasca_oberta ?t))
            (tasca_assignada ?t ?p)
            (revisio_oberta ?t)

            (when (= (dificultat ?t) (+ (habilitat ?p) 1))
                (increase (suma_hores) 2)
            )

            (assign (duracio_revisio ?t) (qualitat ?p))
        )
    )

    (:action assignar_revisio
        :parameters (?t - tasca ?p - programador)
        :precondition (and
            (revisio_oberta ?t)
            (not (tasca_assignada ?t ?p))
            (<= (dificultat ?t) (+ (habilitat ?p) 1))
        )
        :effect (and
            (not (revisio_oberta ?t))
            (revisio_assignada ?t ?p)

            (when (= (duracio_revisio ?t) 2)
                (increase (suma_hores) 1)
            )

            (increase (suma_hores) 1)
            (increase (tasques_assignades) 1)
        )
    )
)
