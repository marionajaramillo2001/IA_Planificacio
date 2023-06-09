(define (domain planificador0)

    (:requirements :adl :strips :fluents :typing :conditional-effects)

    (:types
        programador tasca - object
    )

    (:predicates
        (tasca_oberta ?t - tasca)
        (tasca_assignada ?t - tasca ?p - programador)
    )

    (:functions
        (habilitat ?p - programador)
        (qualitat ?p - programador)
        (dificultat ?t - tasca)
        (duracio_tasca ?t - tasca)
        (tasques_assginades)
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
            (increase (tasques_assginades) 1)
        )
    )
)
