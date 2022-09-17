
import tkinter
from tkinter import ttk


from tkinter import *

window = tkinter.Tk()
window.columnconfigure(0, weight=200)
window.config(width=150, padx=50)

frame = ttk.Frame(window)
frame.grid(column=0, row=0)



label = ttk.Label(frame, text='Selecciona una opción :')
label.grid(column=0, row=0)


def imprimeSeleccion(texto):
    global sel
    global label
    sel = texto
    label.destroy()

    label = ttk.Label(frame, text='Has selecionado: ' + sel)
    label.grid(column=0, row=0)

    print('selecionado: ' + texto)


def limpiar():
    print('limpiado')
    global seleccionado
    global label
    seleccionado.set(0)
    label.destroy()
    label = ttk.Label(frame, text='Selecciona una opción : ')
    label.grid(column=0, row=0)


seleccionado = tkinter.StringVar()

r1 = ttk.Radiobutton(frame, text='Si', value='1',
                     variable=seleccionado, command=lambda: imprimeSeleccion('SI'))
r2 = ttk.Radiobutton(frame, text='No', value='2',
                     variable=seleccionado, command=lambda: imprimeSeleccion('NO'))
r3 = ttk.Radiobutton(frame, text='otro', value='3',
                     variable=seleccionado, command=lambda: imprimeSeleccion('otro'))

r1.grid(column=0, row=2, padx=5, pady=5)
r2.grid(column=0, row=3, padx=5, pady=5)
r3.grid(column=0, row=4, padx=5, pady=5)


boton = ttk.Button(window, text='reset', command=lambda: limpiar())
boton.grid(column=1, row=4, padx=5, pady=5)


window.mainloop()
