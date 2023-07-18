// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestByteArrayBodyPartPayloadB005{
    /***
        public func getOff(): Int64
        测试场景:返回Payload，调用源
    ***/
    @TestCase
    func testByteArrayBodyPartPayloadGetOff01(): Unit {
        var bodypayload01=ByteArrayBodyPartPayload(Array<UInt8>(),1,1,HashMap<String,String>())
        var bodypayload02=ByteArrayBodyPartPayload(Array<UInt8>(100,item:UInt8(3)),HashMap<String,String>())
        var bodypayload03=ByteArrayBodyPartPayload(Array<UInt8>(),"content-type")
        var bodypayload04=ByteArrayBodyPartPayload(Array<UInt8>(),1,1,"content-type")
        var bodypayload05=ByteArrayBodyPartPayload(Array<UInt8>())
        var bodypayload06=ByteArrayBodyPartPayload(Array<UInt8>(),1,1)

        @Assert(bodypayload01.getOff(),1)
        @Assert(bodypayload02.getOff(),0)
        @Assert(bodypayload03.getOff(),0)
        @Assert(bodypayload04.getOff(),1)
        @Assert(bodypayload05.getOff(),0)
        @Assert(bodypayload06.getOff(),1)
    }
}