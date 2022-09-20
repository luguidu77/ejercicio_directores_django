from django.urls import reverse
from django.db import models


class Director(models.Model):
    nombre = models.CharField(
        max_length=30, help_text="Nombre del director de cine")

    def __str__(self):
        return self.nombre
    
    def get_absolute_url(self):
        return reverse('directores', arg=[str(self.id)])


class Peliculas(models.Model):
    titulo = models.CharField(max_length=64, help_text='Titulo del libro')
    director = models.ForeignKey('Director', on_delete=models.SET_NULL, null=True)

    def __str__(self):
        return self.titulo

    def get_absolute_url(self):
        return reverse('peliculas', arg=[str(self.id)])