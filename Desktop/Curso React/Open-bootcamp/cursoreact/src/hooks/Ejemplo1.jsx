/* Ejemplo de uso del Hook useState 

 Crear un componente de tipo funcion y acceder a su estado privado a través de un hook y, además, poder modificarlo

*/

import React, { useState } from 'react';

const Ejemplo1 = () => {

    const valorInicial= 0

    //Valor iniicial para una persona
    const personaInicial ={
        nombre: 'Martin',
        email: 'martin@gmail.com'
    }

    /* Queremos que el VALORINICIAL y PERSONAINICIAL sean
    parte del estado del componente para asi poder gesionar su cambio y que éste se vea reflejado en la vista del componente */

    const [contador, setContador] = useState( valorInicial)
    const [persona, setPersona] = useState( personaInicial )

    function incrementarContador() {
        // funcionParaCambiar(nuevoValor)
        setContador( contador + 1 )
        
    }

    /* Funcion para actualizar el estado de persona en el componente */
    function actualizarPersona () {
        setPersona( 
         {
            nombre: 'Pepe',
            email: 'pepe@gmail.com'
         }
        )
    }

    return (
        <div>
            <h1> *** Ejemplo de useState ***</h1>
            <h2>CONTADOR: {contador}</h2>
            <h2>DATOS PERSONA:</h2>
            <h3>NOMBRE: {persona.nombre}</h3>
            <h3>EMAIL: {persona.email}</h3>
            {/* Bloque de botones para actualizar estado componentes */}
         <div>
            <button onClick={incrementarContador}> INCREMETA CONTADOR </button>
            <button onClick={actualizarPersona}> ACTUALIZAR PERSONA </button>
         </div>
            
        </div>
    );
}

export default Ejemplo1;
