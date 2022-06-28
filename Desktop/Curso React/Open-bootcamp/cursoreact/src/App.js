import logo from './logo.svg';
import './App.css';
import TaskListComponet from './components/container/task_list';
import ContactList from './components/container/contact_list';
import Ejemplo1 from './hooks/Ejemplo1';
import Ejemplo2 from './hooks/Ejemplo2';
import {MiComponenteConContexto} from './hooks/Ejemplo3'
import Ejemplo4 from './hooks/Ejemplo4';
import GreetingStyle from './components/pure/greetingStyled'
import { Ejercicio456 } from './components/pure/ejercicio456';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
      
      {/* <TaskListComponet/> */}
     {/*  <ContactList/> */}

      {/* Ejemplos de uso de HOOKS */}
     {/*  <Ejemplo1/> */}
     {/*  <Ejemplo2/> */}
     {/*  <MiComponenteConContexto/> */}

     {/*  <Ejemplo4 nombre='Martin'  > */}
        {/* todo lo que hay aqui, es tratado como props.children */}
      {/*   <div>
          <p> Contenido del props.children...</p>
          <p>  ...mas contenido props.children</p>
        </div> */}
        
    {/*   </Ejemplo4> */}
       
     {/*  <GreetingStyle name='martin'/> */}

     <Ejercicio456/>
 
      </header>
    </div>
  );
}

export default App;
