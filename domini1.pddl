(define (domain planificador1)

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
            (increase (tasques_assignades) 1)
        )
    )
)
