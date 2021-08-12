function values_conv = analisis_var(filename,var)


%%%%%%%%%%%%
x = netcdf.open(filename);

[varname, xtype, varDimIDs, varAtts] = netcdf.inqVar(x,7);% -
varid = netcdf.inqVarID(x,varname);% SE OBTINE EL NUMERO DE LA VARIABLE
azimuth=netcdf.getVar(x,varid);


varid = netcdf.inqVarID(x,var);% SE OBTINE EL NUMERO DE LA VARIABLE
VALUES=netcdf.getVar(x,varid);

 attname = netcdf.inqAttName(x,varid,0)%Nombre del atributo
 att_val = netcdf.getAtt(x,varid,attname) %Valor del atributo
  attname = netcdf.inqAttName(x,varid,2)%Nombre del atributo
 VALFillVal = netcdf.getAtt(x,varid,attname) %Valor del atributo
 attname = netcdf.inqAttName(x,varid,3)%Nombre del atributo
 VALScale = double(netcdf.getAtt(x,varid,attname)) %Valor del atributo
 attname = netcdf.inqAttName(x,varid,4)%Nombre del atributo
 VALoff = double(netcdf.getAtt(x,varid,attname)) %Valor del atributo
 
 [F C]=size(VALUES);
 values_conv=int16(zeros(F,C));
 count_prec=0;
 
 for     ff=1:F
     for cc=1:C
     if(VALUES(ff,cc)==VALFillVal)
         values_conv(ff,cc)= VALUES(ff,cc);
     else
         values_conv(ff,cc)=(VALUES(ff,cc)*VALScale)+VALoff;
         count_prec=count_prec+1;
     end
     end
 end



end

%%%%%%%%%%%%%%

