import React from 'react';
import PropTypes from 'prop-types';
import { Contact } from '../../models/contact.class';



const ContactComponet = ({ contact }) => {

console.log(contact);

    return (
        <div>
           <h4> Nombre: { contact.nombre }</h4> 
           <h4> Apellido: { contact.apellido }</h4>
           <h4> Email: { contact.email }</h4>
           <p> Conectado: { contact.conectado ? ' Contacto En Línea' : ' Contacto No Disponible' }</p>
        </div>
    );
};


ContactComponet.propTypes = {
  contact: PropTypes.instanceOf(Contact)
};


export default ContactComponet;
