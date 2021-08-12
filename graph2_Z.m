function matriz_RGB=graph2_Z(radar_data,azi,dist)

[celdas angulos]=size(radar_data)

dist_max=max(dist);

r=255;
matriz_RGB=(r*ones(1000,1000,'uint8'));
matriz_RGB(:,:,2)=r*ones(1000,1000,'uint8');
matriz_RGB(:,:,3)=r*ones(1000,1000,'uint8');

ang_factor=360/angulos
cell_factor=664/celdas
dist_factor=500/dist_max;
for i=1:angulos

theta_ini=azi(i)*pi()/180;
if i == angulos
    theta_fin=azi(1)*pi()/180;
else
    theta_fin=azi(i+1)*pi()/180;
end
delta_theta=(theta_fin-theta_ini)/5;

for j=1:celdas
    
    if (radar_data(j,i)>0)
        [R G B]=obtener_color(radar_data(j,i));
        if (j==1)
            r_ini=0;
        else
            r_ini= dist(j-1)*dist_factor;
        end
        r_fin=dist(j)*dist_factor;
        delta_r=(r_fin-r_ini)/5;
        for i_theta=theta_ini:delta_theta:theta_fin
            for i_r=r_ini:delta_r:r_fin
                ix=round(500+int16((i_r*sin(i_theta))));
                iy=round(500+int16((i_r*cos(i_theta))));
                if(ix<1)
                    ix=1;
                end
                if(iy<1)
                   iy=1;
                end
                matriz_RGB(iy,ix,1)=R;
                matriz_RGB(iy,ix,2)=G;
                matriz_RGB(iy,ix,3)=B;
            end
        end
end
end
end
image(matriz_RGB);





