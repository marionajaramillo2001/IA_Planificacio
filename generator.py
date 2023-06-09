import argparse
import random

class Error(Exception):
    def __init__(self, message):
        self.message = message

def get_objects(programadors, tasques):
    objects = '(:objects\n'
    # Add programadors
    objects += '    '
    for i in range(programadors):
        objects += 'p'+str(i) + ' '
    objects += '- programador\n'
    # Add tasques
    objects += '    '
    for i in range(tasques):
        objects += 't'+str(i) + ' '
    objects += '- tasca\n'

    objects += ')\n'
    return objects

def get_init(programadors, tasques):
    init = '(:init\n' +\
            '    (= (tasques_assginades) 0)\n' +\
            '    (= (suma_hores) 0)\n' +\
            '    (= (programadors) 0)\n'
    # Add habilitats
    for i in range(programadors):
        init += '    (= (habilitat p' + str(i) + ') ' + str(random.randint(1, 2)) + ')\n'
    
    # Add qualitat
    for i in range(programadors):
        init += '    (= (qualitat p' + str(i) + ') ' + str(random.randint(1, 3)) + ')\n'
    
    # Add noves_assginacions
    for i in range(programadors):
        init += '    (= (noves_assginacions p' + str(i) + ') 2)\n'
        
    # Add dificultats
    for i in range(tasques):
        init += '    (= (dificultat t' + str(i) + ') ' + str(random.randint(1, 3)) + ')\n'
    
    # Add duracions
    suma_hores = 0
    for i in range(tasques):
        durada_i = random.randint(1, 8)
        suma_hores += durada_i
        init += '    (= (duracio_tasca t' + str(i) + ') ' + str(durada_i) + ')\n'
        
    # Add tasques obertes
    for i in range(tasques):
        init += '    (tasca_oberta t' + str(i) + ')\n'

    init += ')\n'
    return init, suma_hores

def write_file(programadors, tasques, problem):

    header = '(define (problem ' + problem + ') (:domain planificador)\n'
    objects = get_objects(programadors, tasques)
    init, suma_hores = get_init(programadors, tasques)
    goal = '(:goal\n    (= (tasques_assginades) ' + str(tasques) + ')\n)\n'
    metric = '(:metric minimize (+ (* ' + str(programadors) + ' (suma_hores)) (* ' + str(suma_hores) + ' (programadors))))\n'
    f = open(problem + ".pddl", "w")
    f.write(header + objects + init + goal + metric + ')')
    f.close()


def main():
    parser = argparse.ArgumentParser()
    # Add an argument to the number of rovers
    parser.add_argument('--programadors', type=int, 
        help='Number of programadors', required=True)
    # Add an argument to the number of petitions
    parser.add_argument('--tasques', type=int, 
        help='Number of tasques', required=True)
    # Add an argument to the seed for random generator
    parser.add_argument('--seed', type=int, 
        help='Seed of the random generator', default=1234)
    # Add an argument to the name of the problem
    parser.add_argument('--problem', type=str, 
        help='Name of the problem', required=True)

    # Parse the command-line arguments
    args = parser.parse_args()

    # Access the values of the arguments
    programadors = args.programadors
    tasques = args.tasques
    seed = args.seed
    problem = args.problem
    
    # Set the seed for random cases
    random.seed(seed)

    if (programadors < 1):
        raise Error('The number of programmers must be greater than 0')
    if (tasques < 1):
        raise Error('The number of tasks must be greater than 0')

    write_file(programadors, tasques, problem)

if __name__ == '__main__':
    main()
