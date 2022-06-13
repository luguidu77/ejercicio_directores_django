import React, {useState} from 'react';
import { useEffect } from 'react';
import { LEVELS } from '../../models/levels.enum';
import { Task } from '../../models/task.class';
import TaskComponent from '../pure/task';



const TaskListComponet = () => {
   
  const defaultTask = new Task('Example',' Default desciption', false, LEVELS.NORMAL)

   const [defaultT, setdefaultT] = useState(defaultTask);

  
 
   const changeState= (  ) =>{
    const newTask = defaultTask
    newTask.completed = true
    console.log(newTask);
      setdefaultT( newTask )
          
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
                <TaskComponent  task={ defaultT } />

              
            }
             <button onClick={ changeState }> cambiar tarea</button>
        </div>
    );
};





export default TaskListComponet;
