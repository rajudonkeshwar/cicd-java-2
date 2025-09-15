      #!/bin/bash
      sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
      sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
      sudo yum upgrade -y
      sudo dnf install java-17-amazon-corretto -y	  
      sudo yum install jenkins -y
      sudo systemctl start jenkins
      sudo systemctl enable jenkins
	sudo yum install git maven -y
      sudo yum install docker -y
      sudo service docker start
      sudo usermod -aG docker $USER
      sudo usermod -aG docker jenkins
      sudo systemctl enable docker.service
      sudo systemctl enable containerd.service
      systemctl restart docker
      sudo chmod 666 /var/run/docker.sock
      systemctl restart docker
      sudo docker run -itd --name sonar -p 9000:9000 sonarqube
      sudo rpm -ivh https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.rpm
      docker run -d -p 8081:8081 --name nexus sonatype/nexus3
      
      ARCH=amd64
      PLATFORM=$(uname -s)_$ARCH
      #eksctl
      curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
      tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz -y
      mv /tmp/eksctl /usr/local/bin


      #kubens tool install
      git clone https://github.com/ahmetb/kubectx /opt/kubectx
      ln -s /opt/kubectx/kubens /usr/local/bin/kubens
      