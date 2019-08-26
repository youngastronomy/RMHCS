pro rh3d_remote_status,name=name,Hm,Error,status

;+
;   Name: rh3d_remote_status
;
;   Purpose: 
;              Check the job status submit to the Remote Magnetic Helicity Caculation System to start
;              calculation,the relative magnetic helicity and errors estimation
;              will be returned.
;         
;   Input Paramters:
;               None
;   Keyword Paramters:
;               name - the sending job name (default millinseconds of system)
;               email- if setting, will receive information while job done 
;
;   Output:
;               Hm     ---relative magnetic helicity
;               Error  --- estimation errors
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
;              rh3d_remote_status,name='1438958507',Hm,ERROR;
;                            
;      
;   History:
;              07-Aug-2015 - Shangbin Yang (yangshb@nao.cas.cn) 




hmpath=getenv('helicity_path')
if !version.os_family eq 'Windows' then begin
 spawn,hmpath+'\idl\curl.exe  -G http://sun.bao.ac.cn/NAOCHSOS/checkstatusb?name='+name,result
endif else begin
 spawn,'curl -s -G http://sun.bao.ac.cn/NAOCHSOS/checkstatusb?name='+name,result,/sh
endelse

;help,result

status=''
if strlen(result) LE 13 then begin
 status=result[0]&print,'job name='+name+' is '+status
endif
if strlen(result) GT 13 then begin
status='DONE'&print,'The job name='+name+'  is '+status
output=result[0]
output=strsplit(output,' ',/EXTRACT)
Hm=float(output[2])
Error=float(output[7])

endif
;status=result[1]


end
