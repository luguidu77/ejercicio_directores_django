from django.shortcuts import render

from .models import Director, Peliculas


def index(request):
    directores = Director.objects.all()
    peliculas = Peliculas.objects.all()
    d1 = directores[0]
    p1 = peliculas[0]
    d2 = directores[1]
    p2 = peliculas[1]
    return render(
        request,
        'index.html',
        context={
            'peliculas': peliculas,
            'p1':p1,
            'd1':d1,
            'p2':p2,
            'd2':d2,
        }
    )
