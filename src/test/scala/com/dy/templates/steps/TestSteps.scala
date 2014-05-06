package com.dy.templates.steps

import org.jbehave.core.annotations.{Then, When, Given}

class TestSteps {
  @Given("system in default state")
  def systemDefaultState() {
    Thread.sleep(5000)
    println("System is in default state")
  }

  @When("I do something")
  def userAction() {
    println("Uses made some action")
  }

  @Then("system is in a different state")
  def changeSystemState() {
    println("System's state changed")
  }

}
