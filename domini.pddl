(define (domain planificador)

    (:requirements :adl :strips :fluents :typing :conditional-effects)

    (:types
        programador tasca revisio - object
    )

    (:predicates
        (tasca_oberta ?t - tasca)
        (revisio_oberta ?r - revisio ?p - programador)
        (tasca_assignada ?t - tasca ?p - programador)
        (revisio_assignada ?r - revisio ?p - programador)
        (tasca_revisio ?t - tasca ?r - revisio)
    )


    (:functions
        (habilitat ?p - programador)
        (qualitat ?p - programador)
        (dificultat ?t - tasca)
        (duracio_tasca ?t - tasca)
        (duracio_revisio ?r - revisio)

        (propera_hora_lliure ?p - programador)
        (hora_tasca_assignada ?t - tasca)
        (hora_fi_tasca ?t - tasca)
        (hora_revisio_assignada ?r - revisio)
        (hora_fi_revisio ?r - revisio)
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
            (assign (hora_tasca_assignada ?t) (propera_hora_lliure ?p))

            (when (= (dificultat ?t) (+ (habilitat ?p) 1))
                (increase (propera_hora_lliure ?p) (+ 2 (duracio_tasca ?t)))
            )
            (when (<= (dificultat ?t) (habilitat ?p))
                (increase (propera_hora_lliure ?p) (duracio_tasca ?t))
            )
            (assign (hora_fi_tasca ?t) (propera_hora_lliure ?p))
        )
    )

    (:action preparar_revisio
        :parameters (?r - revisio ?t - tasca ?p - programador)
        :precondition (and 
            (tasca_assignada ?t ?p)
            (tasca_revisio ?t ?r)
        )
        :effect (and
            (assign (duracio_revisio ?r) (qualitat ?p))
            (revisio_oberta ?r ?p)
        )
    )

    (:action assignar_revisio
        :parameters (?r - revisio ?t - tasca ?p - programador ?p1 - programador)
        :precondition (and 
            (revisio_oberta ?r ?p1)
            (tasca_revisio ?t ?r)
            (!= ?p ?p1)
            (<= (dificultat ?t) (+ (habilitat ?p) 1))
            (>= (propera_hora_lliure ?p) (hora_fi_tasca ?t))
        )
        :effect (and
            (not (revisio_oberta ?r ?p1))
            (revisio_assignada ?r ?p)
            (assign (hora_revisio_assignada ?r) (propera_hora_lliure ?p))
            (increase (propera_hora_lliure ?p) (duracio_revisio ?r))
            (assign (hora_fi_revisio ?r) (propera_hora_lliure ?p))
            (increase (tasques_assginades) 1)
        )
    )
)
