// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestParameterListB001{
    //空的parameterList,返回空字符串
    @TestCase
    func testAsFormUrlEncodedString01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        @Assert(pl01.asFormUrlEncodedString(),"")
        @Assert(pl02.asFormUrlEncodedString(),"")
    }
}