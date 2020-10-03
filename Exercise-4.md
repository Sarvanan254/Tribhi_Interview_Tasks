


	
Step1: Validated whether the Application pool for the website is started or not.
While checking, that was in Stopped status.

 

**********************************************************************************

Step2: So tried to start that application pool. But again that Application pool moved to stopped status. 
 
**********************************************************************************

Step3: So tried to analyse the events in our IIS server. As per Event log details, username and password was shown like invalid. Also because of this Application disabled.

 
**********************************************************************************
Step4: So tried to set new “identity” for our application pool. After that moved to the Application pool setting. And started the Default Application Pool. This approach fixed this issue.
After this I could access the below URL Successfully.
http://localhost:80

 
