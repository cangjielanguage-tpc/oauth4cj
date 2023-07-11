// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestTimestampServiceImplB004{
    /***
        public func getNonce(): String
        测试场景:返回值为当前当前秒数加上一个整形随机数
    ***/
    @TestCase
    func testTimestampServiceImplGetNonce01(): Unit {
        let regex_re="^[0-9]*$"
        let r1 = Regex(regex_re)
        let timestampServiceImpl=TimestampServiceImpl()
        let re=timestampServiceImpl.getNonce()
        var flag=0
        try{
            r1.matches(re).getOrThrow()
        }catch(e:NoneValueException){
            flag=1
        }
        @Assert(flag,0)
    }
}