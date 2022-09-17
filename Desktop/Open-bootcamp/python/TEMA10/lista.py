import tkinter
from tkinter import ttk


from tkinter import *

window = tkinter.Tk()
window.columnconfigure(0, weight=200)
window.config(width=150, padx=50)

frame = ttk.Frame(window)
frame.grid(column=0, row=0)

label = ttk.Label(frame, text='Lista seleccionable:')
label.grid(column=0, row=0)
   
lista = ['España', 'Francia', 'Alemania', 'Italia']
lista_item =tkinter.StringVar(value=lista)


conbobox = tkinter.Listbox(frame, height=10, listvariable=lista_item)

conbobox.grid(column=0, row=1, sticky=tkinter.W)






window.mainloop()