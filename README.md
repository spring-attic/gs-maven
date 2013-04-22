Building Java Projects with Maven
=================================
This Getting Started guide will walk you through a few basic pieces of setting up and using a Maven build.

To help you get started, we've provided an initial project structure as well as the completed project for you in GitHub:

```sh
$ git clone https://github.com/springframework-meta/gs-maven.git
```

In the `start` folder, you'll find a bare project, ready for you to copy-n-paste code snippets from this document. In the `complete` folder, you'll find the complete project code. 

In both cases, you'll find a simple Java project that we'll build. Our focus will be on the _pom.xml_ file. The Java files are only there as source for our build efforts.

We'll start by installing Maven and then start filling in the _pom.xml_ file. If you already have Maven installed, then you can jump to the [fun part](#defining-a-simple-maven-build).

Installing Maven
----------------
Maven is downloadable as a zip file at http://maven.apache.org/download.cgi. Only the binaries are required, so look for the link to apache-maven-_{version}_-bin.zip or apache-maven-_{version}_-bin.tar.gz.

Once you have downloaded the zip file, unzip it to your computer. Then add the _bin_ folder to your path.

To test the Maven installation, run `mvn` from the command-line like this:

```sh
$ mvn -v
```

If all goes well, you should be presented with some information about the Maven installation. It will look similar to (although perhaps slightly different from) the following:

```sh
Apache Maven 3.0.5 (r01de14724cdef164cd33c7c8c2fe155faf9602da; 2013-02-19 07:51:28-0600)
Maven home: /usr/share/maven
Java version: 1.7.0_09, vendor: Oracle Corporation
Java home: /Library/Java/JavaVirtualMachines/jdk1.7.0_09.jdk/Contents/Home/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "mac os x", version: "10.8.3", arch: "x86_64", family: "mac"
```

Congratulations! You now have Maven installed.

Defining a Simple Maven Build
-----------------------------
Now that Maven is installed, we need to create a Maven project definition. Maven projects are defined with an XML file named _pom.xml_. Among other things, this file expresses the project's name, version, and any dependencies that it has on external libraries.

To get started, create a file named _pom.xml_ at the root of the project and give it the following contents:

```XML
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>org.springframework.gs</groupId>
	<artifactId>gs-maven-start</artifactId>
	<version>1.0.0</version>
	<packaging>jar</packaging>
</project>
```

With the exception of the `<packaging>` element (which is optional), this is the simplest possible _pom.xml_ file necessary to build a Java project. It includes the following details of the project configuration:

* `<modelVersion>` - The POM model version (always 4.0.0).
* `<groupId>` - The group or organization that the project belongs to. Often expressed as an inverted domain name.
* `<artifactId>` - The name to be given to the project's library artifact (e.g., the name of its JAR or WAR file).
* `<version>` - The version of the project that is being built.
* `<packaging>` - How the project should be packaged. Defaults to "jar" for JAR file packaging. Use "war" for WAR file packaging.

At this point we have a minimal, but capable Maven project defined.


Building Java Code
------------------
Maven is now ready to build our project. There are several build lifecycle goals we can execute against it now, including goals to compile our code, create a library package (e.g., a JAR file), and install the library in the local Maven dependency repository.

To try out the build, issue the following at the command line:

```sh
$ mvn compile
```

This will run Maven, telling it to execute the _compile_ goal. When it's finished, you should find the compiled _.class_ files in the _target/classes_ directory.

Since it's unlikely that you'll want to distribute or work with _.class_ files directly, you'll probably want to run the _package_ goal instead:

```sh
$ mvn package
```

The _package_ goal will compile your Java code, run any tests, and finish by packaging the code up in a JAR file within the _target_ directory. The name of the JAR file will be based on the project's `<artifactId>` and `<version>`. For example, given the minimal _pom.xml_ file from before, the JAR file will be named _gs-maven-start-1.0.0.jar_.

> __Note__ : If you've changed the value of `<packaging>` from "jar" to "war", the result will be a WAR file within the _target_ directory instead of a JAR file.

Maven also maintains a repository of dependencies on your local machine (usually in a _.m2/repository_ directory in your home directory) for quick access to project dependencies. If you'd like to install your project's JAR file to that local repository, then you should invoke the `install` goal:

```sh
$ mvn install
```

The _install_ goal will compile, test, and package your project's code and then copy it into the local dependency repository, ready for another project to reference it as a dependency.

Speaking of dependencies, let's see how to declare dependencies in our Maven build.

Declaring Dependencies
----------------------
Our simple Hello World sample is completely self-contained and does not depend on any additional libraries. Most application, however, depend on external libraries to handle common and/or complex functionality.

For example, suppose that in addition to saying "Hello World!", we wanted our application to print the current date and time. While we could use the date and time facilities in the native Java libraries, let's make things more interesting by using the Joda Time libraries.

First, let's change HelloWorld.java to look like this:

```java
package hello;

import org.joda.time.LocalTime;

public class HelloWorld {
  public static void main(String[] args) {
    LocalTime currentTime = new LocalTime();
    System.out.println("The current local time is: " + currentTime);

    Greeter greeter = new Greeter();
    System.out.println(greeter.sayHello());
  }
}
```

Here we're using Joda Time's `LocalTime` class to get and print the current time. 

If we were to run `mvn compile` to build our project now, the build would fail because we've not declared Joda Time as a compile dependency in our build. Let's fix that by adding the following lines to _pom.xml_ (within the `<project>` element):

```xml
<dependencies>
    <dependency>
        <groupId>joda-time</groupId>
        <artifactId>joda-time</artifactId>
        <version>2.2</version>
    </dependency>	
</dependencies>
```

This block of XML declares a list of dependencies for our project. Specifically, it declares a single dependency for the Joda Time library. Within the `<dependency>` element, the dependency coordinates are defined by three subelements:

* `<groupId>` - The group or organization that the dependency belongs to.
* `<artifactId>` - The library that is required.
* `<version>` - The specific version of the library that is required.

By default, all dependencies are scoped as `compile` dependencies. That is, they should be available at compile-time (and if were were building a WAR file, including in the _/WEB-INF/libs_ folder of the WAR). Additionally, you may specify a `<scope>` element to specify one of the following scopes:

* `provided` - Dependencies that are required for compiling the project code, but that will be provided at runtime by a container running the code (e.g., the Java Servlet API).
* `test` - Dependencies that are used for compiling and running tests, but not required for building or running the project's runtime code.

Now if you run `mvn compile` or `mvn package`, Maven should resolve the Joda Time dependency from the Maven Central repository and the build will be successful.


Next Steps
----------
Congratulations! You have not created a very simple, yet effective Maven project definition for building Java projects.

There's much more to building projects with Maven. For continued exploration of Maven, you may want to have a look at the following Getting Started guides:

* Building web applications with Maven
* Setting Maven properties

And for an alternate approach to building projects, your may want to look at [Building Java Projects with Gradle](https://github.com/springframework-meta/gs-gradle/blob/master/README.md).