getwd() ## obtener el directorio en el que trabajo
setwd("E:/Mora-Caicedo/Script")

library(ggplot2)
vr=4.47
vs=2.8
xo=1
xf=0
yo=0
n=20
h=(xf-xo)/n

#euler()
#@param xo: posicion inicial del nadador (playa este)
#@param xf: posicion final del nadador (playa oeste)
#@param yo: alejamiento de las playas
#@param n: numero de intervalos
#@param vs: velocidad del rio
#@param vr: velocidad del nadador
#@param h: ancho del intervalo
#Funci�n para resolver la ecuaci�n diferencial
euler=function(xo,xf,yo,n,vs,vr,h){
  #matriz para guardar los valores de x e y
  m=matrix(0,nrow=n,ncol = 3)
  xi=xo
  yi=yo
  c1=1
  c2=2
  c3=3
  #calculo de los intervalos y resolucion del modelo
  for (i in 1:n) {
     fxy=(vs*yi-vr*sqrt(xi^2+yi^2))/(vs*xi)
     x=xi+h
     xi=x
     y=yi+h*fxy
     yi=y
     #asignacion de valores a la matriz
     m[i,c1]=fxy
     m[i,c2]=x
     m[i,c3]=y
  }
  #retorno de la matriz
  return(m)
}
#matriz que contiene todos los intervalos
matriz=euler(xo,xf,yo,n,vs,vr,h)
#grafica de la trayectoria
#ggplot: libreria para manejar plots de forma m�s flexible
#theme: funcion para el dise�o del plot
#labs: para manipular los nombres de los ejes x e y
#ylim: rango de valores de y
ggplot(as.data.frame.matrix(matriz),aes(x=matriz[,2], y=matriz[,3]))+geom_line(col='red')+
  theme(panel.background=element_rect(fill='lightblue'))+
  labs(x='Distancia entre playas',y='Alejamiento de las playas')+
  ylim(0,4)

#Se esportan los valores de la segunda y tercera columna de la matriz a un archivo de extensi�n .txt
write.table(matriz[,2:3],file='nadadorm.txt',col.names = F,row.names = F)
