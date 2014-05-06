package com.dy.templates.stories

import org.jbehave.core.junit.JUnitStory
import org.junit.{After, Before}
import org.jbehave.core.steps.{InjectableStepsFactory, InstanceStepsFactory}
import com.dy.templates.steps.TestSteps
import org.jbehave.core.configuration.{MostUsefulConfiguration, Configuration}

class TestStory extends JUnitStory {

  @Before
  def setUp() {
    println("JUnit setup")
  }

  @After
  def tearDown() {
    println("JUnit tearDown")
  }


  override def configuration(): Configuration = new MostUsefulConfiguration()

  override def stepsFactory() = new InstanceStepsFactory(configuration(), new TestSteps())

}
