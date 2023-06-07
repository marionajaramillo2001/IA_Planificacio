(define (domain planificador)

    (:requirements :adl :strips :fluents :typing)

    (:types
        programador tasca revisio - object
    )

    (:predicates
        (tasca_oberta ?t - tasca)
        (revisio_oberta ?r - revisio ?p - programador)
        (revisio_preparada ?r - revisio)
        (tasca_assignada ?t - tasca ?p - programador)
        (revisio_assignada ?r - revisio ?p - programador)
        (revisio_tancada ?r - revisio)
        (tasca_revisio ?t - tasca ?r - revisio)
    )


    (:functions
        (habilitat ?p - programador)
        (qualitat ?p - programador)
        (dificultat ?t - tasca)
        (duracio_tasca ?t - tasca)
        (duracio_revisio ?r - revisio)
        (noves_assginacions ?p - programador)
        (propera_hora_lliure ?p - programador)
        (hora_tasca_assignada ?t - tasca)
        (hora_fi_tasca ?t - tasca)
        (hora_revisio_assignada ?r - revisio)
        (hora_fi_revisio ?r - revisio)
        (tasques_assginades)
        (suma_hores)
    )

    (:action assignar_tasca_baixa_habilitat
        :parameters (?t - tasca ?p -programador)
        :precondition (and
            (tasca_oberta ?t)
            (> (noves_assginacions ?p) 0)
            (= (dificultat ?t) (+ (habilitat ?p) 1))
        )
        :effect (and
            (not (tasca_oberta ?t))
            (tasca_assignada ?t ?p)
            (assign (hora_tasca_assignada ?t) (propera_hora_lliure ?p))

            (increase (propera_hora_lliure ?p) (+ (duracio_tasca ?t) 2))
            (increase (suma_hores) 2)
            (decrease (noves_assginacions ?p) 1)
            
            (assign (hora_fi_tasca ?t) (propera_hora_lliure ?p))
        )
    )

    (:action assignar_tasca
        :parameters (?t - tasca ?p -programador)
        :precondition (and
            (tasca_oberta ?t)
            (> (noves_assginacions ?p) 0)
            (<= (dificultat ?t) (habilitat ?p))
        )
        :effect (and
            (not (tasca_oberta ?t))
            (tasca_assignada ?t ?p)
            (assign (hora_tasca_assignada ?t) (propera_hora_lliure ?p))

            (increase (propera_hora_lliure ?p) (duracio_tasca ?t))
            (decrease (noves_assginacions ?p) 1)
            
            (assign (hora_fi_tasca ?t) (propera_hora_lliure ?p))
        )
    )

    (:action preparar_revisio
        :parameters (?r - revisio ?t - tasca ?p - programador)
        :precondition (and
            (tasca_assignada ?t ?p)
            (tasca_revisio ?t ?r)
            (not (revisio_preparada ?r))
            (not (revisio_tancada ?r))
        )
        :effect (and
            (assign (duracio_revisio ?r) (qualitat ?p))
            (revisio_oberta ?r ?p)
            (revisio_preparada ?r)
        )
    )

    (:action assignar_revisio_1_hora
        :parameters (?r - revisio ?t - tasca ?p - programador)
        :precondition (and
            (revisio_preparada ?r)
            (not (revisio_tancada ?r))
            (= (duracio_revisio ?r) 1)
            (not (revisio_oberta ?r ?p))
            (tasca_revisio ?t ?r)
            (> (noves_assginacions ?p) 0)
            (<= (dificultat ?t) (+ (habilitat ?p) 1))
            (>= (propera_hora_lliure ?p) (hora_fi_tasca ?t))
        )
        :effect (and
            (revisio_tancada ?r)
            (revisio_assignada ?r ?p)
            (assign (hora_revisio_assignada ?r) (propera_hora_lliure ?p))
            (increase (propera_hora_lliure ?p) (duracio_revisio ?r))
            (assign (hora_fi_revisio ?r) (propera_hora_lliure ?p))
            (increase (suma_hores) 1)
            (decrease (noves_assginacions ?p) 1)
            (increase (tasques_assginades) 1)
        )
    )

    (:action assignar_revisio_2_hores
        :parameters (?r - revisio ?t - tasca ?p - programador)
        :precondition (and
            (revisio_preparada ?r)
            (not (revisio_tancada ?r))
            (= (duracio_revisio ?r) 2)
            (not (revisio_oberta ?r ?p))
            (tasca_revisio ?t ?r)
            (> (noves_assginacions ?p) 0)
            (<= (dificultat ?t) (+ (habilitat ?p) 1))
            (>= (propera_hora_lliure ?p) (hora_fi_tasca ?t))
        )
        :effect (and
            (revisio_tancada ?r)
            (revisio_assignada ?r ?p)
            (assign (hora_revisio_assignada ?r) (propera_hora_lliure ?p))
            (increase (propera_hora_lliure ?p) (duracio_revisio ?r))
            (assign (hora_fi_revisio ?r) (propera_hora_lliure ?p))
            (increase (suma_hores) 2)
            (decrease (noves_assginacions ?p) 1)
            (increase (tasques_assginades) 1)
        )
    )
)
