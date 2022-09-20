import sqlite3


def main():
    conn = sqlite3.connect('alumnos.db',isolation_level=None)
    cursor = conn.cursor()
    
    delete = "DELETE FROM alumn"
    rows = cursor.execute(delete)

   
    cursor.close()
    conn.close()
    agregar_alumnos()
   
   

def agregar_alumnos():
    alumno1 = (1, 'juan','duran')
    alumno2 = (2, 'lucas','perez')
    alumno3 = (2, 'pepe','martin')
    alumno4 = (4, 'antonio','soriano')
    alumno5 = (5, 'alfredo','rivas')
    alumno6 = (6, 'jose','antunez')
    alumno7 = (7, 'manuel','suarez')
    alumno8 = (8, 'david','peña')

    alumnos = [alumno1, alumno2, alumno3, alumno4,alumno5, alumno5,alumno6,alumno7,alumno8]

    conn = sqlite3.connect('alumnos.db', isolation_level=None)
    cursor = conn.cursor()

    query =  '''INSERT INTO alumn(id , nombre, apellidos) VALUES(?,?,?)'''
    for i in range(8):
 
        cursor.execute(query, (i, alumnos[i][1],alumnos[i][2]))
  
    cursor.close()
    conn.close()

    nombre = input('Introduce nombre de alumno a buscar: ')

    resultado = consultar_alumno(nombre)

    if resultado!= None:
        print(f'Alumno encontrado: {resultado}')
    else:
        print(f'No existe ningun alumno llamado {nombre.capitalize()}')



def consultar_alumno(nombre):
      
    conn = sqlite3.connect('alumnos.db',isolation_level=None)
    cursor = conn.cursor()
    
    query = f"SELECT * FROM alumn WHERE nombre='{nombre}'"
    rows = cursor.execute(query)

    if rows.rowcount == -1:

        for i in rows:
        
            res = f'{i[1].capitalize()} {i[2].capitalize()}'
            return res 
    
    cursor.close()
    conn.close()   

    
    


if __name__ == '__main__':
    main()


