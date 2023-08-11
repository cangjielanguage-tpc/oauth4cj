// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestByteArrayBodyPartPayloadB005{
    /***
        public func getHeaders(): HashMap<String, String>
        测试场景:返回Payload，调用源
    ***/
    @TestCase
    func testByteArrayBodyPartPayloadGetHeaders01(): Unit {
        var headers=HashMap<String,String>([("headers","header_value")])
        var exp_new_headers=HashMap<String,String>([("Content-Type","content-type")])
        var bodypayload01=ByteArrayBodyPartPayload(Array<UInt8>(),1,1,headers)
        var bodypayload02=ByteArrayBodyPartPayload(Array<UInt8>(),headers)
        var bodypayload03=ByteArrayBodyPartPayload(Array<UInt8>(),"content-type")
        var bodypayload04=ByteArrayBodyPartPayload(Array<UInt8>(),1,1,"content-type")
        var bodypayload05=ByteArrayBodyPartPayload(Array<UInt8>())
        var bodypayload06=ByteArrayBodyPartPayload(Array<UInt8>(),1,1)

        @Assert(bodypayload01.getHeaders(),headers)
        @Assert(bodypayload02.getHeaders(),headers)
        @Assert(bodypayload03.getHeaders(),exp_new_headers)
        @Assert(bodypayload04.getHeaders(),exp_new_headers)
        @Assert(bodypayload05.getHeaders(),HashMap<String,String>())
        @Assert(bodypayload06.getHeaders(),HashMap<String,String>())
    }
    /***
        public func getLen(): Int64
        测试场景:返回Payload，调用源
    ***/
    @TestCase
    func testByteArrayBodyPartPayloadGetLen01(): Unit {
        var bodypayload01=ByteArrayBodyPartPayload(Array<UInt8>(),1,1,HashMap<String,String>())
        var bodypayload02=ByteArrayBodyPartPayload(Array<UInt8>(100,item:UInt8(3)),HashMap<String,String>())
        var bodypayload03=ByteArrayBodyPartPayload(Array<UInt8>(),"content-type")
        var bodypayload04=ByteArrayBodyPartPayload(Array<UInt8>(),1,1,"content-type")
        var bodypayload05=ByteArrayBodyPartPayload(Array<UInt8>())
        var bodypayload06=ByteArrayBodyPartPayload(Array<UInt8>(),1,1)

        @Assert(bodypayload01.getLen(),1)
        @Assert(bodypayload02.getLen(),100)
        @Assert(bodypayload03.getLen(),0)
        @Assert(bodypayload04.getLen(),1)
        @Assert(bodypayload05.getLen(),0)
        @Assert(bodypayload06.getLen(),1)
    }
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
    /***
        public func getPayload(): Array<UInt8>
        测试场景:返回Payload，调用源
    ***/
    @TestCase
    func testByteArrayBodyPartPayloadGetPayload01(): Unit {
        var bodypayload01=ByteArrayBodyPartPayload(Array<UInt8>(),1,1,HashMap<String,String>())
        var bodypayload02=ByteArrayBodyPartPayload(Array<UInt8>(),HashMap<String,String>())
        var bodypayload03=ByteArrayBodyPartPayload(Array<UInt8>(),"content-type")
        var bodypayload04=ByteArrayBodyPartPayload(Array<UInt8>(),1,1,"content-type")
        var bodypayload05=ByteArrayBodyPartPayload(Array<UInt8>())
        var bodypayload06=ByteArrayBodyPartPayload(Array<UInt8>(),1,1)

        @Assert(bodypayload01.getPayload(),Array<UInt8>())
        @Assert(bodypayload02.getPayload(),Array<UInt8>())
        @Assert(bodypayload03.getPayload(),Array<UInt8>())
        @Assert(bodypayload04.getPayload(),Array<UInt8>())
        @Assert(bodypayload05.getPayload(),Array<UInt8>())
        @Assert(bodypayload06.getPayload(),Array<UInt8>())
    }
}