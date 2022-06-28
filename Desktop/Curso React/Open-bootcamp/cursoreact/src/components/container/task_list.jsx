import React, {useState} from 'react';

import { Task } from '../../models/task.class';
import { LEVELS } from '../../models/levels.enum';
import TaskComponent from '../pure/task';

// importamos la hoja de estilos de task.scss
import '../../styles/task.scss'

/* 
  las los metodos y cambios de estados los definimos en el componente PADRE (task_list)
  que pasamos al componente HIJO(task) desde llamaremos a los metodos o eventos
*/
const TaskListComponet = () => {
   const defaultTask = new Task('Antonio', 'hacer tareas', false, LEVELS.NORMAL)
 
   const [task, setdtask] = useState(defaultTask);
   
   const completaTarea= () =>{
     
        setdtask({
           
            ...task,
            completed: !task.completed
        })
    }
  
    const cambiaNivel= () =>{
     
        setdtask({
           
            ...task,
            level: LEVELS.BLOCKING
        })
    }

    return (
        <div>
            <h1>
                Tus tareas:
            </h1>
            { 
               /* todo: APLICAR UN FOR/MAP PARA RENDERIZAR UNA LISTA */
              /*  defaultTask.map( task =>(
                    <TaskComponent key={task.name} task={task} />

               )) */
                <TaskComponent task={ task }
                completaTarea={completaTarea} 
                cambiaNivel={cambiaNivel}
                 
                 />

              
            }
           
        </div>
    );
};





export default TaskListComponet;
