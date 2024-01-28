FROM amazonlinux:2
WORKDIR /app

# Install Java
RUN amazon-linux-extras install java-openjdk11 -y

# Install Git, wget, and tar
RUN yum install git wget tar -y

# Download and install Maven
RUN wget https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz \
    && tar -xf apache-maven-3.8.8-bin.tar.gz \
    && mv apache-maven-3.8.8 /usr/local/apache-maven \
    && rm apache-maven-3.8.8-bin.tar.gz

# Set Maven environment variables
ENV MAVEN_HOME /usr/local/apache-maven
ENV PATH $PATH:$MAVEN_HOME/bin

# Clone the Git repository and build
RUN git clone https://github.com/anilkumar3577/contact_backend_app.git . \
    && mvn package

# Set the working directory to the target folder
WORKDIR /app/target

CMD ["java", "-jar", "contact-backend-app.jar"]
