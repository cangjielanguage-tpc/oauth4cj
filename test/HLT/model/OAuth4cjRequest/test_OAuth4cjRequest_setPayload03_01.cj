// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    @TestCase
    func testOAuth4cjRequestsetPayload0301(): Unit {
        var file02=File("file02.txt",OpenOption.CreateOrTruncate(true))
        file02.write("hello world".toUtf8Array())
        file02.close()
        var file03=File("file02.txt",OpenOption.Open(true,false))
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        oauth4cjRequest.setPayload(file03)
        @Assert(oauth4cjRequest.getFilePayload().getOrThrow().readToEnd(),"hello world".toUtf8Array())
        var file01=File("file01.txt",OpenOption.CreateOrTruncate(true))
        oauth4cjRequest.setPayload(file01)
        @Assert(oauth4cjRequest.getFilePayload().getOrThrow().readToEnd(),Array<UInt8>())

    }
}