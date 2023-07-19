// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartUtilsB005{
    /***
        public static func checkBoundarySyntax(boundary: String): Unit
        测试场景:匹配正则多次:[0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?]
    ***/
    @TestCase
    func testMultipartUtilsCheckBoundarySyntax03(): Unit {
        var flag=1
        var str="111111111@11111111"
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