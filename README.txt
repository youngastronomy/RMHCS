		How to install Remote Magnetic Helicity Calculation System (RMHCS) in the SSW


0. Please install java and curl in your operating system.

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


1. copy ssw into the path of ssw

2. modify the ssw.setup_env in the $SSW/gen/setup. You only need add text "packages/helicity" 
into the setting of SSW_PACKAGES_INSTR. See the sample setup_ssw_env (Helicity Setting).pdf. 
Please NOTE Red color text


3. If you don't want to install it to SSW. You can set helicity_path in the own system.
For windows： set helicity_path="PathToInstallCode"
For linux:    export(setenv) helicity_path="PathToInstallCode"
