// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestParameterListB001{
    //queryString非空，含&,含=(=前后是否有值)
    @TestCase
    func testAddQuerystring03(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        //=左侧无值
        var pl01=ParameterList(map02)//非空表
        var queryString01="=a&bc"
        pl01.addQuerystring(queryString01)
        @Assert(pl01.size(),map02.size+2)
        @Assert(pl01.contains(Parameter("","a")),true)
        @Assert(pl01.contains(Parameter("bc","")),true)
        //=左右侧均有值
        var pl02=ParameterList(map02)//非空表
        var queryString02="a&b=c"

        pl02.addQuerystring(queryString02)
        @Assert(pl02.size(),map02.size+2)
        @Assert(pl02.contains(Parameter("b","c")),true)
        //=右侧无值
        var pl03=ParameterList(map02)//非空表
        var queryString03="a&bc="

        pl03.addQuerystring(queryString03)
        @Assert(pl03.size(),map02.size+2)
        @Assert(pl03.contains(Parameter("bc","")),true)
        //=右侧均无值
        var pl04=ParameterList(map02)//非空表
        var queryString04="&=&"
        var exp_flag=1
        try{
            pl04.addQuerystring(queryString04)
        }catch(e:IndexOutOfBoundsException){
            exp_flag=0
        }
        @Assert(exp_flag,0)
    }
}