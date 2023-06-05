// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuthAsyncRequestCallbackB004{
    /***
        func onCompleted(response: T): Unit
        func onThrowable(e: Exception): Unit
        接口可被实现即可
    ***/
    @TestCase
    func testOAuthAsyncRequestCallback01(): Unit {
        var sub01=SubOAuthAsyncRequestCallback<String>()
        sub01.onCompleted("onCompleted")
        sub01.onThrowable(Exception())
        @Assert(sub01.getFlagOnCompleted(),"pass")
        @Assert(sub01.getFlagOnThrowable(),"pass")
    }
}

public class SubOAuthAsyncRequestCallback<String> <:OAuthAsyncRequestCallback<String>{
    public static var flag_onCompleted="fail"
    public static var flag_onThrowable="fail"
    public func onCompleted(response: String): Unit{
        flag_onCompleted="pass"
    }
    public func onThrowable(e: Exception): Unit{
        flag_onThrowable="pass"
    }
    public func getFlagOnCompleted():String{
        return  (flag_onCompleted  as String).getOrThrow()
    }
    public func getFlagOnThrowable():String{
        return  (flag_onThrowable  as String).getOrThrow()
    }
}