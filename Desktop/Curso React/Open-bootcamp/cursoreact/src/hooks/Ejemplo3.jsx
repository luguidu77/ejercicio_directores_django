import React, {useState, useContext} from 'react';

/* *
* Ejemplo HOOKS:
* - useState()
* -useContext()
*
 */


const miContexto = React.createContext(null)

// componente 1 dispone de un contexto que va a tener un valor
// que recibe del padre
const Componente1 = () => {

    // iniciamos un esTado vacio que va a rellenarse con los datos del contexto 
    // del padre
     const state = useContext(miContexto)

    return (
        <div>
          
            <h1>
                El Token es: { state.token }
            </h1>
            {/* pintamos el componente 2 */}
            <Componente2/>
            
        </div>
    );
}



const Componente2 = () => {

    const state = useContext( miContexto )

    return (
        <div>
            <h2>
                La sesion es: { state.sesion }
            </h2>
        </div>
    );
}



export const MiComponenteConContexto = () => {

    const estadoInicial = {
        token: '1234567',
        sesion: 1
    }

    //Creamos el estado de este componente

    const [sessionData, setsessionData] = useState(estadoInicial)

    function actualizarSesion() {
        setsessionData(
            {
                token: 'jgdkdkd131346',
                sesion: sessionData.sesion + 1
            }
        )
    }


    return (
        <miContexto.Provider value={sessionData}>
            {/* TODO: todo lo que esta aqui dentro puede leer los datos de sessionData */}
            {/* Ademas, si se actualiza, los componentes de aqui, tambien lo actualizan */}
            <h1> *** Ejemplo de useState(), useContext()</h1>
        <Componente1/>
        <button onClick={actualizarSesion}>Actualizar Sesion</button>
        </miContexto.Provider>
    );
}



