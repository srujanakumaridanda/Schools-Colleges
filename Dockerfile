FROM tomcat:11-jre17
COPY School_test_project.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
