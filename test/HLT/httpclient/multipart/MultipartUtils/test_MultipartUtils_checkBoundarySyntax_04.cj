// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartUtilsB005{
    /***
        public static func checkBoundarySyntax(boundary: String): Unit
        测试场景:全匹配:[0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?]
    ***/
    @TestCase
    func testMultipartUtilsCheckBoundarySyntax03(): Unit {
        var flag=1
        var str="11111111111111111111111111111111111111111111111111111111111111111111111"
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