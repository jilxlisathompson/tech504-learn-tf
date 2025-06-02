#  Setting Up a Jenkins Server on AWS EC2

This guide walks you through setting up a Jenkins server on an AWS EC2 instance using Ubuntu.

---
Refer to the [Jenkins Documentation](https://www.jenkins.io/doc/) for advanced setup and plugin usage.

##  Step 1: Launch an EC2 Instance
### Configuration:
- **AMI**: Ubuntu Server 22.04 LTS 
- **Instance Type**: `t3.micro` (Free Tier eligible)
- **Key Pair**: used an existing key-pair
- **Security Group**:
  - Allow **SSH (port 22)** from my IP
  - Allow **HTTP (port 80)** and **Jenkins (port 8080)** from my IP address

---

##  Step 2: Connect to the EC2 Instance

Open terminal and connect using SSH:

```bash
ssh -i "shakara-aws-sparta.pem" ubuntu@ec2-34-252-77-146.eu-west-1.compute.amazonaws.com
```
## Step 3: Install Java
Jenkins requires Java (Java 11 or higher recommended):
```bash
sudo apt update
sudo apt install -y openjdk-17-jdk
java -version
```

## Step 4: Install Jenkins

``` bash
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install -y jenkins
```
## Step 5: Start Jenkins
```bash
sudo systemctl enable jenkins
sudo systemctl start jenkins
```
Check the service status of the Jenkins server by going to the following URL:
``` bash
http://your-ec2-public-ip:8080
```
It will ask for an admin password

```
http://3.253.13.198:8080
```

![Jenkins_login](images_screenshots/jenkins_enter_password.png)


## Step 7: Retrieve the Initial Admin Password
``` bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
Copy the output and paste it into the Jenkins setup page.

![Jenkins_loggedin](images_screenshots/jenkins_server.png) 

## Step 8: Sign in to Jenkins GUI
- create an account, I used admin 
- Jenkins GUI
![Jenkins_gui](images_screenshots/jenkins_gui.png)   

# Setting up Jenkins CICD pipeline 
## Structure of the CICD Pipeline 
## Logging in to Jenkins 
- Log in to Jenkins with the appropriate credentials. 
## Create GitHub App repo
## Generating SSH key 
## Adding public key to GitHub Repo
## Creating Job 1 on Jenkins
- Name: `<name>-job1-ci-test`
- Click on `Freestyle Project`
![freestyle project](images_screenshots/step1_creating_jenkins_job.png) 
- Add a general description 
  - select `Git` 
  - enter the https repository URL
![github project url](images_screenshots/github_url_creating_jenkins_job.png) 
- **Source Code Managment**
  - Select `Git`
  - add ssh url from github repo in `Repository URL`
  - If you haven't added your private key generated earlier you will need to click `add` below the `Credentials` dropdown box
  - and add the relevant details including 
![github project crendentials](images_screenshots/adding_github_ssh_private_creating_jenkins_job.png) 
    - Branches to build select `main` or `dev` if you've created a dev branch
- **Build Triggers**
  - Select `GitHub hook trigger for GITScm polling` 
  - N.B. after you've set up your webhook, instructions in section 
- **Build Environment**
  - Select `Provide Node & npm bin/ folder to PATH` and fill out the correct version of NodeJS version 20
  - ![build environment](images_screenshots/build_environment_creating_jenkins_job.png)  
- **Build Steps**
  - select `Execute Shell` from the drop down and enter the following into the shell
![build steps](images_screenshots/build_steps_creaking_jenkins_job.png)  

Double check everything is correct then click Save.
On the Dashboard Click `Build Now`

### Setting up webhook 
#### What is a webhook
- a webhook is a way for external systems (like GitHub, GitLab, or Bitbucket) to notify Jenkins automatically when certain events occur—most commonly, when code is pushed to a repository.

#### Steps 
1. Edit the configuration of job 1 in the section `Build Triggers` select `GitHub hook trigger for GITScm polling`  
2. go to the the github repo page for the app and click on the `Settings`
3. On the lefthand side under the list of options below `General` Select `Webhooks`
4. Select `add webhooks`
5. Fill in the details e.g.
![github webhook](images_screenshots/github_webhook.png)  

## Creating Job 2 on Jenkins
### Purpose 
### Steps
- Click `New Item`
- As in Job 1 add `Enter an item name` :  `shakara-job2-ci-merge`
-  Go to the bottom of the page to `create a new item from other existing, you can use this option: ` 
-  In the `Copy From`  select the job/item to copy as template in this case `shakara-job1-ci-test`
-  Click `OK`
-  This takes you to the `General` page where you can fill in the details for the job configuration 
-  All the details filled are from job 1, the following details are different for job 2 
-  In the `Source Code Managment` Click on `Additional Behaviours`, see below 
![job 2 additional behaviours](images_screenshots/additional_behaviours_job2_creating_jenkins_job.png)   
- this automates the merging of the code from the dev branch to the main branch 
- In the `Build Environment` select `SSH Agent`
- ![job 2 additional behaviours](images_screenshots/ssh_agent_job2_creating_jenkins_job.png)    
- select the appropriate ssh private key, the one used in job 1
- In `Build Steps` remove the commands from job 1 and add
- Blockers here:
  - Did not select `SSH agent` which led to build failing 
  - Need to make changes to the dev branch to trigger the build of job 2 
``` bash 
git push origin HEAD:main
```
    - to push updated changes to the main branch 

- edit Job 1 the `Configuration` of job 1, scroll to the `Post Build Actions` and edit it according to the following 
![job 1 post build actions](images_screenshots/post_build_job1_creating_jenkins_job.png) 
- This will trigger job 2 after job 1 has built successfully 

- In the locally hosted repo on the dev branch add a change, i.e. Add a line to the README.md file 
![change to dev branch](images_screenshots/readme_file_change.png) 
- add, commit and push these changes to the dev branch 
- this will trigger the merging of the changes from the dev branch to the main branch 
![merge to main branch](images_screenshots/github_merged_job2.png)  

## Creating Job 3 on Jenkins 
### Goals: 
- Copy the updated & tested code from Jenkins to the AWS EC2 instance

### Steps:
1. Creating new item
   - following the naming convention : 
        `<yourname>-job3-cd-deploy`
   - copy item from existing item i.e. job 2
2. Click `OK` 
3. Begin edditing the configuration details 
4. 
