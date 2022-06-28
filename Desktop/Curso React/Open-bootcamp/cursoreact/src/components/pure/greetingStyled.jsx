import React, {useState} from 'react'

// definiendo estilos en constantes

//?Estilo para usuario logeado
const loggedStyle = {
    color:'white'
}

//?Estilo para usuario NO logeado
const unloggedStyle = {
    color:'tomato',
    fontWeight: 'bold'
}


export default function GreetingStyle(props) {

  // generamos un estado para el componente y asi controlar si el 
  // usuario esta logeado

 const [logged, setLogged] = useState(false);

 const greetingUser= ()=>( <p> Hola, {props.name} </p> )
 const pleaseLogin = ()=> ( <p> Logeate </p>)

  return (
    <div style={ logged ? loggedStyle: unloggedStyle }>

        { logged ?
            greetingUser()
          : pleaseLogin()
        }
     
      <button onClick={() => {
        console.log('boton pulsado');
        setLogged(!logged)
      }}>
         { logged? 'Logout' : 'Login' }
      </button>
    </div>
  )
}
