// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import httpclient.multipart.*
@Test
public class TestMultipartUtilsB005{
    /***
        public static func checkBoundarySyntax(boundary: String): Unit
        测试场景:不匹配正则:[0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?]
    ***/
    @TestCase
    func testMultipartUtilsCheckBoundarySyntax01(): Unit {
        var flag=1
        var str="@"
        var errorMsg=""
        try{
            MultipartUtils.checkBoundarySyntax(str)
        }catch(e:IllegalArgumentException){
            errorMsg=#"{'boundary'='"# + str + #"'} has invalid syntax. Should be '[0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?]"# + #"'."#
            if(e.toString().contains(errorMsg)){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}