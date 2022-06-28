import React from 'react';
import PropTypes from 'prop-types';

import { Task } from '../../models/task.class';

//Importadmos la hoja d estilos de task.scss
import '../../styles/task.scss'

const TaskComponent = (props) => {

  
    return (
        <div >
            <h2 className='task-name' >
               Nombre: { props.task.name }
            </h2>
            <h3>
                Descripción: { props.task.description }
            </h3>
            <h4>
                Nivel: { props.task.level }
            </h4>
            <h5>
                Esta tarea está:  
                { 
                    props.task.completed ? ' completada' : ' pendiente'
                }
            </h5>

            <button onClick={ props.completaTarea }> 
              {props.task.completed? 'Poner en pendiente': 'Completar tarea'}
            </button>
            <button style={{margin:2}} onClick={ props.cambiaNivel }> 
              nivel blocking
            </button>
        </div>
    );
};


TaskComponent.propTypes = {

    props: PropTypes.instanceOf(Task),
   
};


export default TaskComponent;
