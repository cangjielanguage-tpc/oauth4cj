// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuthAsyncRequestCallbackB004{
    /***
        func onCompleted(response: T): Unit
        func onThrowable(e: Exception): Unit
        接口可被实现即可
    ***/
    @TestCase
    func testOAuthAsyncRequestCallback01(): Unit {
        var sub01=SubOAuthAsyncRequestCallback()
        sub01.onCompleted("onCompleted")
        sub01.onThrowable(Exception())
        @Assert(sub01.getFlagOnCompleted(),"pass")
        @Assert(sub01.getFlagOnThrowable(),"pass")
    }
}
