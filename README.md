Template for webdriver grid with JUnit runner
==========================

<h3>Environment configuration:</h3> <br/>
Setup two properties: HUB_HOME and NODE_HOME <br/>
<i>HUB_HOME</i> - should contain startHub.sh and stopHub.sh from src/test/resources/env/hub and symlink <b>selenium-server.jar</b>
on selenium server jar file; <br/>
 <i>NODE_HOME</i> - should contain startNode.sh and stopNode.sh from src/test/resources/env/node and symlink <b>selenium-server.jar</b>
 on selenium server jar file; <br/>