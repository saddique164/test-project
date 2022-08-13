  # Task-Project-NewYorker
  ## Introudction
   The task steps have been fulfilled with the best of my knowledge. My nodes are with following IPS .
   1.	Master 192.168.1.11
   2.	Node01 192.168.1.12
   3.	Ubunut-k8s 192.168.1.74  (target node for ansible)
I used master node for all the activites and used the same VM to deploy the cluster on Ubuntu-k8s node. I installed Jenkins on my window machine for saving the resources for all three nodes. I added Master server as an agent in Jenkins server to run the code on it. I used Ansible, Jenkins, Git, xmobaterm, Argocd, Docker engine, kubernetes, Visual Studio Code for completing the assignment.
 
 The Idea of my Continues integration and Continues Delivery is explained in the Picture.
 
 ![Alt text](https://github.com/saddique164/test-project/blob/master/cicd.PNG?raw=true "Title")
 
## TASK 1: 
### Master Node :
            I installed following tools on Master.
1.	Docker engine
2.	Ansible
3.	Python 3.8
4.	Git (I am using master branch for all the activities).
5.	Kubernetes
       The master is being used for controlling all the activities. I created the first task structure using ansible galaxy. My main tasks in in the tasks directory.   
       The path to that task is:
       i.	**/newyorker-kubernetes-ansible/roles/kubnertes-cluster/tasks/main.yml**

In order to execut this file, I have created a **playbook.yaml** and its path is:
       ii. **/newyorker-kubernetes-ansible/roles/**

Please  run the following command to deploy the kubernetes cluster. 
       iii.	**ansible-playbook playbook.yml -i inventory.ini --extra-vars "ansible_sudo_pass=yourPassword"**

Please update the hostname enteries in the **Inventory.txt** file.

I untained master node in order to create a single node cluster because with master node taint we can’t create new resources on it.

## Task 2:  
   ### Installation of Jenkins on kubernetes server
  
  Deploy the Jenkins in kubernetes.
     Please run the files in given order to deploy Jenkins in Kubernetes cluster.
     cd /newyorker-kubernetes-ansible/jenkins-installation.  
     Kubeclt –f create <follow the order>
            i.  1.namespace.yaml
            ii. 2.jenkins-service-account.yaml
            iii. 3. persistent-volume.yaml
            iv. 4.jenkins-deployment.yaml
            v.  5.jenkins-service.yaml

Please access the Jenkins on **http://your-cluster-ip:32000**.
  
## Task 3:
     CI/CD pipeline for building and creating Image.
  These are the steps followed for ccompletion of Pipeline.
  
 **Step 1:**
    I am checking the connection with the git repo for cloning the code on master node. I have used my credentials ID which I got from Jenkins after setting up my github repo in it.

**Sept 2:**
    I am installing required dependencies for the python project using pip service.  Thes list of the requirements could been seen in "requirements.txt" file.

  **Step 3:**
     I am running, testing and killing the application before generating an image for it. All three stages are parallel and I am getting user input to kill the process after checking the output. This will give user the opportunities to stop building the new image if the result is wrong.
   
   **Note** : Use the extra Virtual Machine as agent with jenkins build as it will be using port 8000 for testing. If you will run it on cluster, it will be occupied  by running application in the pod. it will throw connection refused error.

  **Step 4:**
      I am building the new image from the dockerfile and tagging it with the build number. Same image is being pushed to docker hub repository. You can see Dockerfile in the same github repository. You can check the image and its tags on the following link.
   https://hub.docker.com/repository/docker/saddique164/python-fastapi
  
  **Jenkins plugin** : **cloudbees docker push and build**
  
  **step 5:**
      I am retagging the application deployments running in the kubernetes cluster. Since my docker hub repository for the app is also public so it will be no issue for you. However, you could change the image name and tags according to your docker hub user in order to use it. 
  
 I am accessing the application on Nodeport 30006. You can modify the service port yourself for your convenience. later you can access your application on any kubernetes node cluster IP using 30006: The format will be <any-node-ip>:30006. In my case it is 192.168.1.11:30006. 
  
  **Improvement In the Given task:**
      We can use argocd for Continous deployment part. It will help to monitor the cluster state and keep it synch. I can provide the application files for kubernetes on request.
  

## Configuring GitHub with jenkins for webhook
**Step 1**: go to your GitHub repository and click on ‘Settings’.

**Step 2**: Click on Webhooks and then click on ‘Add webhook’.

**Step 3**: In the ‘Payload URL’ field, paste your Jenkins environment URL. At the end of this URL add /github-webhook/. In the ‘Content type’ select: ‘application/json’ and leave the ‘Secret’ field empty.

**Step 4**: on the page ‘Which events would you like to trigger this webhook?’ choose ‘Let me select individual events.’ Then, check ‘Pull Requests’ and ‘Pushes’. At the end of this option, make sure that the ‘Active’ option is checked and click on ‘Add webhook’.

**Step 5**: in Jenkins, Click on the ‘Source Code Management’ tab after editing your project.

**step 6**:  Click on the ‘Build Triggers’ tab and then on the ‘GitHub hook trigger for GITScm polling’. That's it.
