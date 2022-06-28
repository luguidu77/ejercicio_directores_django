import React, {useState, useRef, useEffect} from 'react';

const Ejemplo2 = () => {


   const [contador1, setcontador1] = useState(0)
   const [contador2, setcontador2] = useState(0)

  

   const miRef = useRef()
  
   
  
    const [texto, setTexto] = useState('textoinicio')

   function incrementar1() {
    setcontador1(contador1 +1 )
    setTexto('has pulsado contador 1')

    
   }

   function incrementar2() {
    setcontador2(contador2 +1 )
    setTexto('has pulsado contador 2')
    
   }


   /**  
   * ? Caso 1: Ejecutar SIEMPRE un snippet de codico
   *cada vez que haya un cambio en el estado del componente se 
   *ejecuta aquillo que esté dentro del useEffect() */


  /*  useEffect(() => {
     console.log(' CAMBIO EN EL ESTADO DLE COMPONENTE')
     console.log('Mostrando Referencia a elemento del DOM:');
     console.log(miRef);
   })
    */

   /** 
    * ? Caso 2: Ejecutar SOLO CUANDO CAMBIE CONTADOR1
    */

   useEffect(() => {
    console.log(' CAMBIO EN EL ESTADO DEL CONTADOR1')
    console.log('Mostrando Referencia a elemento del DOM:');
    console.log(miRef.current);
    
   },[contador1])
  

    return (
        <div>
            <h1> *** Ejemplo de useState(), useEffect(), useRef()</h1>
            <h2>CONTADOR 1: {contador1}</h2>
            <h2>CONTADOR 2: {contador2}</h2>
            {/* ELEMENTO REFERENCIADO */}
             <h4 ref={miRef}>
               TEXTO miREF: {texto}
             </h4>   
             <div>
                <button onClick={incrementar1}> Incrementar contador 1 </button>
                <button onClick={incrementar2}> Incrementar contador 2 </button>
             </div>   
      </div>
    );
}

export default Ejemplo2;
