pro rh3d_remote_hmcal,name=name,email=email,status

;+
;   Name: rh3d_remote_hmcal
;
;   Purpose: 
;              Sending the job to the Remote Magnetic Helicity Caculation System to start
;              calculation,the status will return.
;         
;   Input Paramters:
;               None
;   Keyword Paramters:
;               name - the sending job name (default millinseconds of system)
;               email- if setting, will receive information while job done 
;
;   Output:
;               Status---the returned job status after submitting
;                       
;                  START_NOW: Submiting job succeed and starting calculation now
;                    RUNNING: the job with such name is runing. Maybe you use the 
;                             same name as the others, You may have a check
;           WAIT_ON_QUEUE: Waiting on the queue.
;               NO_SUCH_NAME: No such job with the given name
;                       DONE: the job is already fininshed.
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
;              IDL> rh3d_remote_upload,bx,by,bz,name=name
;                   ; uploading data 
;              IDL> rh3d_remote_hmcal,name=name,email='user@user.com',Status 
                     ;submitting the job
;
;                            
;      
;   History:
;              07-Aug-2015 - Shangbin Yang (yangshb@nao.cas.cn) 



if N_elements(email) eq 0 then email='naochsos@126.com'
;if N_elements(location) eq 0 then location='.'

hmpath=getenv('helicity_path')
if !version.os_family eq 'Windows' then begin

  spawn,hmpath+'\idl\curl.exe  -G "http://sun.bao.ac.cn/NAOCHSOS/hmcalb?name='+name+'&email='+email+'"',result
 ; print,hmpath+'\pro\curl.exe  -G "http://10.12.0.5:8080/Helicity/hmcal?name='+name+'&email='+email+'"'

endif else begin
   
  spawn,'curl -s -G "http://sun.bao.ac.cn/NAOCHSOS/hmcalb?name='+name+'&email='+email+'"',result,/sh

endelse


status=result
;status=result[1]


end
