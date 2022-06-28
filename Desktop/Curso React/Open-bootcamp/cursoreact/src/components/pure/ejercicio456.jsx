import React, { useEffect , useState} from 'react'


    const initialState = {
            'fecha': new Date(),
            'edad': 0,
            'nombre': 'Martín',
            'apellidos':'San José'
        }
export const Ejercicio456 = () => {
   

    

        const [state, setState] = useState(initialState);

        const tick= ()=>{
            setState(() => {
               let edad = state.edad + 1;
               return {
                  ...state,
                  fecha: new Date(),
                  edad
               }
            });
         }


         useEffect(() => {
          let timerID= setInterval(() => {
              tick()
      
           }, 1000);
                 return()=> clearInterval(timerID)
         },[ state.edad] );

      
  return (
    <>
     <h1>Ejercicio sesiones 4, 5 y 6</h1>

       {
        <div>
          <h2> Hora actual:  {state.fecha.toLocaleTimeString()}</h2>
          <h3> {state.nombre} {state.apellidos}</h3>
          <h1> Edad:  {state.edad} </h1>

 
        </div>
       
      
       
       }
     
    </>
   
  )




}


