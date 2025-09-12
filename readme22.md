## Part 1: Install Nexus Repository Manager (OSS version)
Option A: Install via Docker (easiest)
docker run -d -p 8081:8081 --name nexus sonatype/nexus3
Nexus UI will be available at: http://<server-ip>:8081

Default admin credentials:
Username: admin
Password: stored in file:
/nexus-data/admin.password
(inside the container, use docker exec -it nexus cat /nexus-data/admin.password)



## Option B: Install on Linux Server (manual)

Download Nexus 3 from Sonatype:
wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
tar -xvzf latest-unix.tar.gz
mv nexus-3* nexus
Run Nexus as a service:
cd nexus/bin
./nexus start
Access UI at http://<server-ip>:8081
Unlock with admin password (nexus-data/admin.password).



## Repository Setup in Nexus

Login → Create Repository → Choose type:
Maven (hosted) → for your own JARs/WARs
Maven (proxy) → to proxy Maven Central
Maven (group) → combine hosted + proxy
Example: Create a hosted Maven repo called maven-releases.

## Part 2: Integrate Nexus with Jenkins

There are two main integrations:

##      Publish Artifacts from Jenkins to Nexus

If your project is Maven-based:
Add Nexus credentials in Jenkins:
Go to Manage Jenkins → Credentials → Add
Kind: Username/Password
ID: nexus-creds
Update pom.xml (distributionManagement):

<distributionManagement>
  <repository>
    <id>nexus</id>
    <url>http://<nexus-server>:8081/repository/maven-releases/</url>
  </repository>
  <snapshotRepository>
    <id>nexus</id>
    <url>http://<nexus-server>:8081/repository/maven-snapshots/</url>
  </snapshotRepository>
</distributionManagement>


Update settings.xml in Jenkins (Maven config):

<servers>
  <server>
    <id>nexus</id>
    <username>admin</username>
    <password>admin123</password>
  </server>
</servers>


Jenkins pipeline stage to deploy:

stage('Deploy to Nexus') {
    steps {
        sh 'mvn clean deploy -s /path/to/settings.xml'
    }
}



Plugins:
* Pipeline stage view
* Pipeline Utility Steps
* AWS Credentials
* AWS Steps
* Rebuild
* Ansi Color
* SonarScanner