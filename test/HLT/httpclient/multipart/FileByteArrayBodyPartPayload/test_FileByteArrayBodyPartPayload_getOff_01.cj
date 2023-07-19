// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestFileByteArrayBodyPartPayloadB005{
    /***
        public func getOff(): Int64
        测试场景:获取off，根据调用源返回
        public init(payload: Array<UInt8>)
        public init(payload: Array<UInt8>, off: Int64, len: Int64)
        public init(payload: Array<UInt8>, name: String)
    ***/
    @TestCase
    func testFileByteArrayBodyPartPayloadGetOff01(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload(Array<UInt8>())
        var re01=fileByteArrayBodyPartPayload01.getOff()
        @Assert(re01,0)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload(Array<UInt8>(),1,100)
        var re02=fileByteArrayBodyPartPayload02.getOff()
        @Assert(re02,1)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload(Array<UInt8>(),"name_value")
        var re03=fileByteArrayBodyPartPayload03.getOff()
        @Assert(re03,0)
    }
}