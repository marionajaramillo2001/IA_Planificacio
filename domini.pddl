(define (domain planificador)

    (:requirements :adl :strips :fluents :typing)

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
        (duracio ?t - tasca)

        (propera_hora_lliure ?p - programador)
        (hora_assignada ?t - tasca)
        (tasques_assginades)
    )

    (:action assignar_tasca_poca_habilitat
        :parameters (?t - tasca ?p -programador)
        :precondition (and
            (tasca_oberta ?t)
            (= (dificultat ?t) (+ (habilitat ?p) 1))
        )
        :effect (and
            (not (tasca_oberta ?t))
            (tasca_assignada ?t ?p)
            (assign (hora_assignada ?t) (propera_hora_lliure ?p))
            (increase (propera_hora_lliure ?p) (+ 2 (duracio ?t)))
            (increase (tasques_assginades) 1)            
        )
    )

    (:action assignar_tasca
        :parameters (?t - tasca ?p -programador)
        :precondition (and
            (tasca_oberta ?t)
            (<= (dificultat ?t) (habilitat ?p))
        )
        :effect (and
            (not (tasca_oberta ?t))
            (tasca_assignada ?t ?p)
            (assign (hora_assignada ?t) (propera_hora_lliure ?p))
            (increase (propera_hora_lliure ?p) (duracio ?t))
            (increase (tasques_assginades) 1)            
        )
    )
)
