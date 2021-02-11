# Some notes on Maven
## Differences between failsafe and surefire plugins

Failsafe plugin is designed to run integration tests while Surefire to run unit tests.
While Surefire terminates immediately the build when it finds a failing test, 
Failsafe doesn't stop the execution of the Maven build when a test fails, which allows you to clean up all of your artifacts 
during the post-integration-test phase, after which it checks the status of your tests and passes or fails the build accordingly 
during the verify phase. Moreover Failsafe has a pre-integration-test phase during which you can setup some time-costly environment entity, 
such as an application server.
