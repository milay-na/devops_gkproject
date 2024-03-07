# devops_gkproject
Welcome to the gk-project
This repository allows you to deploy our deployement solutions on your computer (ubuntu OS only)

Our goal is to provide a load-balancing solution for your maven project !

## Docker 
This is a solution using docker containers
to deploy this solution 
run the following command :

```bash
./docker.sh
```

You will need admin rights and git. This will run a script installing everything you need to get three running containers with nginx servers, one master 2 webworkers, and having a loadbalancing between the two workers.