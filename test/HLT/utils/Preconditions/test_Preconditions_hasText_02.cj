// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import commons.*

@Test
public class TestPreconditions03{
    public var params=Array<String>()
 	//str中仅包含非空白字符， 返回true
    @TestCase
    func testHasText02(): Unit {
        params=Array<String>(["abc","中z~！！@#中12~!@#$%^^&&*30"])//非空白字符串
        for (param in params){
            @Assert(Preconditions.hasText(param),true)
        }
    }
} 