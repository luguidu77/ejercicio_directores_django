import  { FC } from 'react';

import Head from 'next/head'
import { Navbar } from '../Navbar'
import styles from './MainLayout.module.css'

interface Props{
  children?: React.ReactNode
}

export const MainLayout: FC<Props> = ({ children }) => {
  return (
   
    <div className={styles.container}>
      <Head>
        <title>Contact - Juan</title>
        <meta name="description" content="Contact Page" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <Navbar/>
     
      <main className={styles.main}>

       { children }

       
      </main>

      
    </div>
  
  )
}
