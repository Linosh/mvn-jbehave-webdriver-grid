package samples

import org.junit._
import Assert._

@Test
class AppTest {

    @Test
    def testOK() {
      val s = List(1,2,3,4,5).reverse.foldLeft(""){
        (acc, v) =>
          acc + v
      }

      println(s)
      assertTrue(true)
    }

//    @Test
//    def testKO() = assertTrue(false)

}


