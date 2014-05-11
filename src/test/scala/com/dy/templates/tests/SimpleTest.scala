package com.dy.templates.tests

import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.junit.{Ignore, Test, After, Before}
import java.io.{File, PrintWriter}

@Ignore("Unused for this moment")
@RunWith(classOf[JUnit4])
class SimpleTest {

  @Before
  def setUp() {
    println("\n-------------------------\n")
    println("Setting up the test\n")
  }

  @After
  def tearDown() {
    println("Shutting down the test\n")
    println("------------------------- \n")
  }

  @Test
  def test1() {
    println("Start test1\n")
    val i  = 1
    val pw = new PrintWriter(new File("" + i))
    pw.write(i)
    pw.close()
    Thread.sleep(5000)
    println("Test1 finished its work\n")
  }

  @Test
  def test2() {
    println("Start test2\n")
    val i  = 2
    val pw = new PrintWriter(new File("" + i))
    pw.write(i)
    pw.close()
    Thread.sleep(5000)
    println("Test2 finished its work\n")
  }

  @Test
  def test3() {
    println("Start test3\n")
    val i  = 3
    val pw = new PrintWriter(new File("" + i))
    pw.write(i)
    pw.close()
    Thread.sleep(5000)
    println("Test3 finished its work\n")
  }

  @Test
  def test4() {
    println("Start test4\n")
    val i  = 4
    val pw = new PrintWriter(new File("" + i))
    pw.write(i)
    pw.close()
    Thread.sleep(5000)
    println("Test4 finished its work\n")
  }

  @Test
  def test5() {
    println("Start test5\n")
    val i  = 5
    val pw = new PrintWriter(new File("" + i))
    pw.write(i)
    pw.close()
    Thread.sleep(5000)
    println("Test5 finished its work\n")
  }

  @Test
  def test6() {
    println("Start test6\n")
    val i  = 6
    val pw = new PrintWriter(new File("" + i))
    pw.write(i)
    pw.close()
    Thread.sleep(5000)
    println("Test6 finished its work\n")
  }
}
