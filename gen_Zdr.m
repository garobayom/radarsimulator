function Z_radar_data = gen_Zdr(random_image,Zmax,Parea,cells,ang_resolution,im_centerx,im_centery)
%GEN_ZDR Funciòn para generar datos de radar (Zdr) a partir de un conjunto
%de datos aleatorio. 
%   Aunque la semilla de los datos es un conjunto de datos aleatorio,
%   ciertos paràmetros del usuario caracterizan el set de datos a generar.
%   Zmax:  Valor máximo de Zdr que el set de datos tendrá
%   Parea: Area ocupada con precipitación (Z > 0)
%   Cells: cantidad de celdas del radar (cantidad de datos generados para
%   cubrir la distancia máxima o rango del radar)
%   ang_resolution: resoluciòn angular, indica cada cuantos grados el
%   radar emitirá un haz y tomará una medición.
%   im_centerx / im_centery: usados para "desplazar" el evento
%   meteorológico y asi poder generar varios eventos secuenciales.
% 

 Parea=Parea*0.75;              
 Zmin=Zmax*(1-100/Parea);           %A partir del àrea y Z max se calcula el Zmin


 %% Bloque de código de preparacion de datos 
 maxGS=max(max(random_image));
 minGS=min(min(random_image));
 mZ=(Zmax-Zmin)/(maxGS-minGS);
 MaxGSmatrix=maxGS*ones(size(random_image));
 MinGSMatrix=minGS*ones(size(random_image));
 Zmaxmatrix=Zmax*ones(size(random_image));
 Zminmatrix=Zmin*ones(size(random_image));
 Zmatrix=uint8(Zminmatrix+mZ*(random_image-MinGSMatrix));
 
 datos_generados=Zmatrix(500,450)
 datos_generados=Zmatrix(678,499)

im_tam=size(Zmatrix)/2  ;
%im_centerx=im_tam(1)/2;
%im_centery=im_tam(2)/2;

angs=round(360/ang_resolution);


radar_data_Z=zeros(cells,angs);
count_cell= zeros(cells,angs);
cell_ratio=(im_tam(2)/2)/(cells);

x=0;
y=0;

xlast=0;
ylast=0;


radar_data_Z=uint8(zeros(cells,angs));
count_cell= zeros(cells,angs);
%%Bloque de código para conversión de datos de coordenadas cartesianas(X,Y)
%%a polares (ang, celd).
for (ang=1:1:angs)
    angulo=(ang*ang_resolution);
    
    for(celd=1:1:cells)
        x=round(im_centerx+cell_ratio*(celd-1)*sin((angulo-ang_resolution)*pi()/180));
        y=round(im_centery+cell_ratio*(celd-1)*cos((angulo-ang_resolution)*pi()/180));
        Z_radar_data(celd,ang)=(Zmatrix(y,x));
    end
end

end

