pro rh3d_remote,bx,by,bz,name=name,email=email

;+
;   Name: rh3d_remote
;
;   Purpose: 
;              Calculate the relative magnetic helicity of the 
;              3D magnetic field data in the rectangular cartesian coordinate 
;              by using the Remote Magnetic Helicity Caculation System (RMHCS).
;              http://sun.bao.ac.cn/NAOCHSOS/rmhcs.htm
;                    
;   Input Paramters:
;               bx,by,bz :  x,y,z direction of magnetic field data
;
;   Keyword Paramters:
;               name - the sending job name (default millinseconds of system)
;               email- if setting, will receive information while job done 
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
;              IDL> rh3d_remote,bx,by,bz,name=name,email='user@user.com'
;                    ;submit job, define your self email address
;              IDL> rh3d_remote_status,name=name,Hm,ERROR 
;                    ;check the status of job
;              IDL>print,'RMH=',Hm,'ERROR=',ERROR
;                    ;print result
;                            
;      
;   History:
;              07-Aug-2015 - Shangbin Yang (yangshb@nao.cas.cn) 


if N_elements(name) eq 0 then name=String(SYSTIME(/SECONDS),'(I10)')
if N_elements(email) eq 0 then email='naochsos@126.com'
rh3d_remote_upload,bx,by,bz,name=name
rh3d_remote_hmcal,name=name,email=email,status
print,'job name='+ name+' is '+status
rh3d_remote_status,name=name,Hm,ERROR,status
print,'you can use the statment to check status later:'
print,'rh3d_remote_status,name='+"'"+name+"'"+',Hm,ERROR'
print,'check you email if setting'
end
