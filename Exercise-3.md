STEP 1: Entered below command to start my redis-server

redis-server
*********************************************************************************************************************************************************************
STEP 2: Opened another terminal and connected my redis-server by using below command.

redis-cli
*********************************************************************************************************************************************************************
STEP 3: To check the status of redis-server, below command enetered in terminal. Shown "failed status" with some error code, as mentioned below.

Command: systemctl status redis-server

Error msg from Output:

  Process: 5605 ExecStop=/bin/kill -s TERM $MAINPID (code=exited, status=0/SUCCESS)
  Process: 5769 ExecStart=/usr/bin/redis-server /etc/redis/redis.conf (code=exited, status=1/FAILURE)
 Main PID: 5420 (code=exited, status=0/SUCCESS)

redis-server.service: Failed with result 'exit-code'.
Failed to start Advanced key-value store.
*********************************************************************************************************************************************************************
STEP 4: Validated the above error systemd logs. As checked, there is no correct log path mentioned in "redis.conf" file. So corrected this log path as below. And tried to star the redis-server. This time, I have successfully connected to the redis-server.

Incorrect Path for logfile in file redis.conf: logfile /var/log/redis-server.log

Correct Path: logfile /var/log/redis/redis-server.log

*********************************************************************************************************************************************************************
