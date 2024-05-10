// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestParameterB001{
    //字符串角度
    @TestCase
    func testasUrlEncodedPair01(): Unit {
        var p01=OAuth4cjParameter("key01","value01")
        for (i in strValues){
            p01=OAuth4cjParameter(i,i)
            @Assert(p01.asUrlEncodedPair(),OAuthEncoder.encode(i)+"="+OAuthEncoder.encode(i))
        }
    }
    //相等
    @TestCase
    func testCompareTo01(): Unit {
        var p01=OAuth4cjParameter("key01","value01")
        var p02=OAuth4cjParameter("key01","value01")
        var p03=OAuth4cjParameter("","")
        var p04=OAuth4cjParameter("","")
        @Assert(p01.compareTo(p02),Ordering.EQ)
        @Assert(p03.compareTo(p04),Ordering.EQ)
    }
    //不等
    @TestCase
    func testCompareTo02(): Unit {
        var p01=OAuth4cjParameter("key01","value01")
        var p02=OAuth4cjParameter("key01","value02")
        var p03=OAuth4cjParameter("key02","value02")
        var p04=OAuth4cjParameter("key02","")

        @Assert(p01.compareTo(p02),Ordering.LT)
        @Assert(p02.compareTo(p01),Ordering.GT)
        @Assert(p02.compareTo(p03),Ordering.LT)
        @Assert(p03.compareTo(p02),Ordering.GT)
        @Assert(p01.compareTo(p03),Ordering.LT)
        @Assert(p03.compareTo(p01),Ordering.GT)

        @Assert(p04.compareTo(p03),Ordering.LT)
        @Assert(p03.compareTo(p04),Ordering.GT)

    }
    //相等
    @TestCase
    func testEquals01(): Unit {
        var p01=OAuth4cjParameter("key01","value01")
        var p02=OAuth4cjParameter("key01","value01")
        var p03=OAuth4cjParameter("","")
        var p04=OAuth4cjParameter("","")
        @Assert(p01==p02,true)
        @Assert(p03==p04,true)
    }
    //不等
    @TestCase
    func testEquals02(): Unit {
        var p01=OAuth4cjParameter("key01","value01")
        var p02=OAuth4cjParameter("key01","value02")
        var p03=OAuth4cjParameter("key02","value02")
        var p04=OAuth4cjParameter("key02","")
        var p05=OAuth4cjParameter("","value02")
        var p06=OAuth4cjParameter("","")
        @Assert(p01==p02,false)
        @Assert(p03==p02,false)
        @Assert(p03==p01,false)
        @Assert(p04==p06,false)
        @Assert(p05==p06,false)
        @Assert(p04==p06,false)
    }
    //字符串角度
    @TestCase
    func testGetKey01(): Unit {
        var p01=OAuth4cjParameter("key01","value01")
        for (i in strValues){
            p01=OAuth4cjParameter(i,i)
            @Assert(p01.getKey(),i)
        }
    }
    //字符串角度
    @TestCase
    func testGetValue01(): Unit {
        var p01=OAuth4cjParameter("key01","value01")
        for (i in strValues){
            p01=OAuth4cjParameter(i,i)
            @Assert(p01.getValue(),i)
        }
    }
    //字符串角度
    @TestCase
    @OverflowWrapping
    func testHashCode01(): Unit {
        var p01=OAuth4cjParameter("key01","value01")
        for (i in strValues){
            p01=OAuth4cjParameter(i,i)
            @Assert(p01.hashCode(),i.hashCode()*2)
        }
    }
}