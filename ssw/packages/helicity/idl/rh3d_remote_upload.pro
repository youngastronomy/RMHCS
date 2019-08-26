pro rh3d_remote_upload,bx,by,bz,name=name,noup=noup
;+
;   Name: rh3d_remote_upload
;
;   Purpose: 
;              Uploading the data neede by the Remote Magnetic Helicity Caculation System 
;              based on the given magnetic field data
;              
;              
;   Input Paramters:
;               bx,by,bz :  x,y,z direction of magnetic field data
;
;   Keyword Paramters:
;               name - the sending job name (default millinseconds of system)
;               noup - only create the uploading data but not start to upload 
;                      if setting
;   Output:
;               NONE
;
;   Note:
;              The maximul size of data is  256x256x256. If too large, 
;              the sending job will be cancelled after 3 hours. If the condition
;              of divergence free is good enough, the data can be resize to 
;              small volume to obtain the similar results. 
;     
;              The failed with unknown reason data will be deleted from server 
;              after 7 days. 
;      
;              java 6+ needed:http://www.java.com
;              
;              curl is needed: http://curl.haxx.se/ 
;              On windows, it has been included.
;              On linux or Mac OSX, it is usually installed, otherwise you need 
;              install them by yourself.
;                 
;   Calling Example:
;              IDL>name=String(SYSTIME(/SECONDS),'(I10)')
;                   ;millinseconds of system as the job name
;              IDL> restore,getenv('helicity_path')+'/idl/test.sav' 
;                   ;restore Lou&Low model
;              IDL> rh3d_remote_upload,bx,by,bz,name=
;                   ; uploading data
;
;                            
;      
;   History:
;              07-Aug-2015 - Shangbin Yang (yangshb@nao.cas.cn) 


if N_elements(name) eq 0 then name=String(SYSTIME(/SECONDS),'(I10)')
if N_elements(noup) eq 0 then noup=0

hmpath=getenv('helicity_path')
;print,hmpath
sw=size(bz)

nx=sw(1)
ny=sw(2)
nz=sw(3)

bx=float(bx)
by=float(by)
bz=float(bz)


openw,lun,name+'input',/get_lun,/F77_UNFORMATTED
writeu,lun,nx,ny,nz,bx,by,bz
free_lun,lun

;file_info(name+'input').size GE 555L

if (file_info(name+'input')).size GE 209715200L and !version.os_family eq 'Windows' then begin
print,'File is larger than 256x256x256,Exit upload'
goto,jump
;
endif


openw,lun,name+'para.txt',/get_lun
printf,lun,' ',strcompress(string(nx),/remove_all),'          nx'
printf,lun,' ',strcompress(string(ny),/remove_all),'          ny'
printf,lun,' ',strcompress(string(nz),/remove_all),'          nz'
free_lun,lun

if noup eq 0 then begin

openw,lun,name+'inputOK',/get_lun
;printf,lun,fltarr(128,128)
free_lun,lun

openw,lun,name+'para.txtOK',/get_lun
;printf,lun,fltarr(128,128)
free_lun,lun

print,'job name='+name+' data is uploading now'
if !version.os_family eq 'Windows' then begin
    spawn,'java -jar '+hmpath+'\idl\sFtptest.jar '+name+'input',/hide
    spawn,'java -jar '+hmpath+'\idl\sFtptest.jar '+name+'para.txt',/hide
 
	spawn,'del '+name+'input' 
    spawn,'del '+name+'para.txt'   
	spawn,'del '+name+'inputOK' 
    spawn,'del '+name+'para.txtOK' 
endif else begin
    spawn,'java -jar '+hmpath+'/idl/sFtptest.jar  '+name+'input'
    spawn,'java -jar '+hmpath+'/idl/sFtptest.jar  '+name+'para.txt'
	
	spawn,'rm ./'+name+'input' 
    spawn,'rm ./'+name+'para.txt'   
	spawn,'rm ./'+name+'inputOK' 
    spawn,'rm ./'+name+'para.txtOK' 
endelse

endif

print,'job name='+name+' data uploading finished'


          

jump:

end
