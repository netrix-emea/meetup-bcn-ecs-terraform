# BCN Tech Talks Meetup Demo webserver

This demo application starts a webserver at port 8080.
It records the ClientIP and ServerIP and update the counter in a dynamoDB
The result is a webpage with a table for all clientip/serverip combinations with their count

## Changed required before use

1. repository url  
Copy the output from terraform variable  
Replace REGISTRY in `build-push.sh` and `deploy.sh `
`xxxxxxx.dkr.ecr.${AWS_REGION}.amazonaws.com` where xxx = accountid

2. Region  
ECS/ECR are region specific update the following scripts with the right region
```
build-push.sh
deploy.sh
server.js
```



# Build & Deploy to ECS

## manual
```
./build-push.sh
./deploy.sh
```

## Using Drone

Change the registry/image urls with the correct one
Change the aws-region

Build the job
