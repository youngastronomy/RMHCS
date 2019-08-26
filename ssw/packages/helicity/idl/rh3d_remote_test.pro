pro rh3d_remote_test

;+
;   Name: rh3d_remote_test
;
;   Purpose: 
;              An example to use the procedure rh3d_remote_hmcal.pro
;              
;   Input Paramters:
;              None
;   Keyword Paramters:
;              None
;   Output:
;              None
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
;              IDL> rh3d_remote_test
                 
;      
;   History:
;              07-Aug-2015 - Shangbin Yang (yangshb@nao.cas.cn) 


restore,getenv('helicity_path')+'/idl/test.sav'
rh3d_remote,bx,by,bz,name=name
end
