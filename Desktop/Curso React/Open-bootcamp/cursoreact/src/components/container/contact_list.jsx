import React from 'react';
import { Contact } from '../../models/contact.class';
import ContactComponet from '../pure/contact';

const ContactList = () => {
 

    const defaultContact = new Contact(
     'Juan',
     'Lugo',
     'email@gmail.com',
     false
     )
  


    return (
        <div>
            <h1> Contactos </h1>
            <ContactComponet contact={ defaultContact }/>

        </div>
    );
} 

export default ContactList;
 