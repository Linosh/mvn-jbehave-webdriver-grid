package com.dy.templates.stories

import org.junit.{Ignore, Test, After, Before}
import org.jbehave.core.steps.InstanceStepsFactory
import com.dy.templates.steps.TestSteps
import org.jbehave.core.configuration.{MostUsefulConfiguration, Configuration}
import org.jbehave.core.embedder.Embedder
import org.jbehave.core.io.StoryPathResolver
import java.util.Arrays._
import org.jbehave.core.ConfigurableEmbedder
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.openqa.selenium.remote.{HttpCommandExecutor, CapabilityType, RemoteWebDriver, DesiredCapabilities}
import org.openqa.selenium._
import java.net.{ProtocolFamily, URL}
import java.util.Properties
import java.util
import java.util.concurrent.TimeUnit

@RunWith(classOf[JUnit4])
class TestStory extends ConfigurableEmbedder {

  @Before def setUp() {
    println("JUnit setup")
  }

  @After def tearDown() {
    println("JUnit tearDown")
  }


  override def run(): Unit = {}

  def startSelenium(browser: String) {
    val capability = browser match {
      case "firefox" => DesiredCapabilities.firefox()
      case "chrome" => DesiredCapabilities.chrome()
      case _ => null
    }

    capability.setPlatform(Platform.MAC)
    capability.setCapability(CapabilityType.ENABLE_PROFILING_CAPABILITY, true);

    val gridProps = new Properties();
    gridProps.load(getClass.getClassLoader.getResourceAsStream("grid/grid.properties"))

    val hubUrl = new URL("http", gridProps.getProperty("HUB_SSH_HOST"), gridProps.getProperty("HUB_PORT").toInt, "/wd/hub")
    val httpCmdExec = new HttpCommandExecutor(hubUrl)


    val driver: WebDriver = new RemoteWebDriver(capability)
    driver.manage().timeouts().pageLoadTimeout(30, TimeUnit.SECONDS);
    driver.manage().window().setSize(new Dimension(200, 200))
    driver.get("http://localhost:4444/grid/console")
    Thread.sleep(3000)
    driver.get("http://google.com")
    Thread.sleep(3000)
    driver.get("http://seasonvar.ru")
    Thread.sleep(3000)
    driver.quit()

  }

  @Test def run1() {
    useConfiguration(new MostUsefulConfiguration())
    useStepsFactory(new InstanceStepsFactory(configuration(), new TestSteps()))

    val embedder: Embedder = configuredEmbedder
    val pathResolver: StoryPathResolver = embedder.configuration.storyPathResolver
    val storyPath: String = pathResolver.resolve(classOf[TestStory])

    try {
      startSelenium("firefox")
      embedder.runStoriesAsPaths(asList(storyPath))
    }
    finally {
      embedder.generateCrossReference()
    }
  }

  @Test def run2() {
    useConfiguration(new MostUsefulConfiguration())
    useStepsFactory(new InstanceStepsFactory(configuration(), new TestSteps()))

    val embedder: Embedder = configuredEmbedder
    val pathResolver: StoryPathResolver = embedder.configuration.storyPathResolver
    val storyPath: String = pathResolver.resolve(classOf[TestStory])

    try {
      startSelenium("chrome")
      embedder.runStoriesAsPaths(asList(storyPath))
    }
    finally {
      embedder.generateCrossReference()
    }
  }
}
