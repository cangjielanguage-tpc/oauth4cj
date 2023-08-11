// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestParameterListB001{
    //空列表新增
    @TestCase
    func testAdd01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        @Assert(pl01.size(),0)
        @Assert(pl02.size(),0)
        pl01.add("key03","value03")
        pl02.add("key03","value03")
        @Assert(pl01.size(),1)
        @Assert(pl02.size(),1)
    }
    //非空列表新增
    @TestCase
    func testAdd02(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)//非空表
        @Assert(pl03.size(),2)
        pl03.add("key03","value03")
        @Assert(pl03.size(),3)
    }
    //多次连续新增(键值对存在/不存在)
    @TestCase
    func testAdd03(): Unit {
        var pl01=ParameterList()
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)
        @Assert(pl01.size(),0)
        @Assert(pl02.size(),0)
        @Assert(pl03.size(),2)
        pl01.add("key01","value01")
        pl01.add("key02","value02")
        pl01.add("key03","value03")
        pl02.add("key01","value01")
        pl02.add("key02","value02")
        pl02.add("key03","value03")
        pl03.add("key02","value02")
        pl03.add("key03","value03")
        @Assert(pl01.size(),3)
        @Assert(pl02.size(),3)
        @Assert(pl03.size(),4)
    }
    //字符串角度
    @TestCase
    func testAdd04(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)
        var sizeBefore=pl03.size()
        @Assert(sizeBefore,2)
        for (i in strValues){
            pl03.add(i,i)
        }
        @Assert(pl03.size(),sizeBefore+strValues.size)
    }
    //空列表新增,other为空或者非空
    @TestCase
    func testAddAll01(): Unit {
        var other01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var other02=ParameterList(map01)//空表
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var other03=ParameterList(map02)//非空表

        var pl01=ParameterList()//空表
        var pl02=ParameterList()//空表
        var pl03=ParameterList()//空表

        var pl04=ParameterList(map01)//空表
        var pl05=ParameterList(map01)//空表
        var pl06=ParameterList(map01)//空表
        pl01.addAll(other01)
        pl02.addAll(other02)
        pl03.addAll(other03)

        pl04.addAll(other01)
        pl05.addAll(other02)
        pl06.addAll(other03)

        @Assert(pl01.size(),0)
        @Assert(pl02.size(),0)
        @Assert(pl03.size(),2)
        @Assert(pl04.size(),0)
        @Assert(pl05.size(),0)
        @Assert(pl06.size(),2)
    }
    //非空列表新增,other为空或者非空
    @TestCase
    func testAddAll02(): Unit {
        var other01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var other02=ParameterList(map01)//空表
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key03","")])
        var other03=ParameterList(map02)//非空表

        var pl01=ParameterList(map02)
        var pl02=ParameterList(map02)
        var pl03=ParameterList(map02)
        var baseSize=pl01.size()
        pl01.addAll(other01)
        pl02.addAll(other02)
        pl03.addAll(other03)
        @Assert(pl01.size(),baseSize+other01.size())
        @Assert(pl02.size(),baseSize+other02.size())
        @Assert(pl03.size(),baseSize+other03.size())
    }
    //多次新增达到1000次
    @TestCase
    func testAddAll03(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key03","")])
        var other03=ParameterList(map02)//非空表
        var pl03=ParameterList(map02)
        var baseSize=pl03.size()
        var i=0
		while(i<1000){
            pl03.addAll(other03)
            i+=1
		}
        @Assert(pl03.size(),baseSize+other03.size()*1000)
    }
    //queryString为空，没有变化
    @TestCase
    func testAddQuerystring01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)//非空表

        var queryString=""
        pl01.addQuerystring(queryString)
        pl02.addQuerystring(queryString)
        pl03.addQuerystring(queryString)

        @Assert(pl01.size(),0)
        @Assert(pl02.size(),0)
        @Assert(pl03.size(),2)
    }
    //queryString非空，含&(首位，中间，尾部),不含=
    @TestCase
    func testAddQuerystring02(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        //含&--首位
        var pl01=ParameterList(map02)
        var queryString01="&abc"
        pl01.addQuerystring(queryString01)
        @Assert(pl01.size(),map02.size+2)
        @Assert(pl01.contains(Parameter("abc","")),true)
        @Assert(pl01.contains(Parameter("","")),true)
        //含&--中间
        var pl02=ParameterList(map02)//非空表
        var queryString02="a&bc"
        pl02.addQuerystring(queryString02)
        @Assert(pl02.size(),map02.size+2)
        @Assert(pl02.contains(Parameter("a","")),true)
        @Assert(pl02.contains(Parameter("bc","")),true)
        //含&--尾部
        var pl03=ParameterList(map02)//非空表
        var queryString03="abc&"
        pl03.addQuerystring(queryString03)
        @Assert(pl03.size(),map02.size+1)
        @Assert(pl03.contains(Parameter("abc","")),true)
        @Assert(pl03.contains(Parameter("","")),false)
    }
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
    //queryString非空，不含&,不含=
    @TestCase
    func testAddQuerystring04(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        //=左侧无值
        var pl01=ParameterList(map02)//非空表
        var queryString01="abc"
        pl01.addQuerystring(queryString01)
        @Assert(pl01.size(),map02.size+1)
        @Assert(pl01.contains(Parameter("abc","")),true)
    }
    //queryString非空，不含&,含=(=前后是否有值，多个等号)
    @TestCase
    func testAddQuerystring05(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        //=左侧无值
        var pl01=ParameterList(map02)//非空表
        var queryString01="=abc"
        pl01.addQuerystring(queryString01)
        @Assert(pl01.size(),map02.size+1)
        @Assert(pl01.contains(Parameter("","abc")),true)

        //=左右侧均有值
        var pl02=ParameterList(map02)//非空表
        var queryString02="ab=c"
        pl02.addQuerystring(queryString02)
        @Assert(pl02.size(),map02.size+1)
        @Assert(pl02.contains(Parameter("ab","c")),true)
        //=右侧无值
        var pl03=ParameterList(map02)//非空表
        var queryString03="abc="
        pl03.addQuerystring(queryString03)
        @Assert(pl03.size(),map02.size+1)
        @Assert(pl03.contains(Parameter("abc","")),true)
        //=右侧均无值
        var pl04=ParameterList(map02)//非空表
        var queryString04="="
        var exp_flag_04=0
        try{
            pl04.addQuerystring(queryString04)
        }catch(w:Exception){
            exp_flag_04=1
        }
        @Assert(exp_flag_04,1)

        //存在多个等号
        var pl05=ParameterList(map02)//非空表
        var queryString05="abc=bcd=cdv"
        pl05.addQuerystring(queryString05)
        @Assert(pl05.size(),map02.size+1)
        @Assert(pl05.contains(Parameter("abc","bcd")),true)//忽略了第二个等号之后的值

        //存在连续=
        var pl06=ParameterList(map02)//非空表
        var queryString06="=="
        var exp_flag_06=0
        try{
            pl06.addQuerystring(queryString06)
        }catch(w:Exception){
            exp_flag_06=1
        }
        @Assert(exp_flag_06,1)
    }
    //queryString非空，连续新增
    @TestCase
    func testAddQuerystring06(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        //=左侧无值
        var pl01=ParameterList(map02)//非空表
        var queryString01="=a&bc&c=1"
        var queryString02="a&bd=c"
        var queryString03="b=c"
        pl01.addQuerystring(queryString01)
        pl01.addQuerystring(queryString02)
        pl01.addQuerystring(queryString03)
        @Assert(pl01.size(),map02.size+3+2+1)
        @Assert(pl01.contains(Parameter("","a")),true)
        @Assert(pl01.contains(Parameter("bc","")),true)
        @Assert(pl01.contains(Parameter("c","1")),true)
        @Assert(pl01.contains(Parameter("a","")),true)
        @Assert(pl01.contains(Parameter("bd","c")),true)
        @Assert(pl01.contains(Parameter("b","c")),true)
    }
    //asFormUrlEncodedString()结果为空，url不包含'?'和 '&'返回入参url
    @TestCase
    func testAppendTo01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        var url="www.baidu.com"
        @Assert(pl01.appendTo(url),url)
        @Assert(pl02.appendTo(url),url)
    }
    //asFormUrlEncodedString()结果为空，url包含'?'和 '&'返回入参url
    @TestCase
    func testAppendTo02(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        var url="www.bai&du.co?m"
        @Assert(pl01.appendTo(url),url)
        @Assert(pl02.appendTo(url),url)
    }
    //asFormUrlEncodedString()结果不为空，url包含'?','?'在尾部,中间,首部,返回url+&+asFormUrlEncodedString()
    @TestCase
    func testAppendTo03(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key03","")])
        var pl03=ParameterList(map02)//非空表
        var url01="&www.baidu.com?"
        var url02="www.baidu.c?om&"
        var url03="?ww&w.baidu.com"
        @Assert(pl03.appendTo(url01),url01+"&"+pl03.asFormUrlEncodedString())
        @Assert(pl03.appendTo(url02),url02+"&"+pl03.asFormUrlEncodedString())
        @Assert(pl03.appendTo(url03),url03+"&"+pl03.asFormUrlEncodedString())
    }
    //asFormUrlEncodedString()结果不为空，url不包含'?',返回url+？+asFormUrlEncodedString()
    @TestCase
    func testAppendTo04(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key03","")])
        var pl03=ParameterList(map02)//非空表
        var url="www.baidu.com"
        @Assert(pl03.appendTo(url),url+"?"+pl03.asFormUrlEncodedString())
    }
    //空的parameterList,返回空字符串
    @TestCase
    func testAsFormUrlEncodedString01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        @Assert(pl01.asFormUrlEncodedString(),"")
        @Assert(pl02.asFormUrlEncodedString(),"")
    }
    //非空parameterList，返回各个Parameter调用asUrlEncodedPair()之后的值，并将其用&链接起来:较少个数
    @TestCase
    func testAsFormUrlEncodedString02(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key03","")])
        var pl03=ParameterList(map02)//非空表
        var re_exp=""
        for (i in map02){
            re_exp=re_exp+"&"+OAuthEncoder.encode(i[0]).concat("=").concat(OAuthEncoder.encode(i[1]))
        }
        re_exp=re_exp.substring(1)
        @Assert(pl03.asFormUrlEncodedString(),re_exp)
    }
    //非空parameterList，返回各个Parameter调用asUrlEncodedPair()之后的值，并将其用&链接起来:1000个
    @TestCase
    func testAsFormUrlEncodedString03(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)//非空表
        var i=0
		while(i<1000){
            pl03.add("key-1000","value-1000")
			i++
        }
        @Assert(pl03.size(),1002)
        var re_exp=""
        for (i in map02){
            re_exp=re_exp+"&"+OAuthEncoder.encode(i[0]).concat("=").concat(OAuthEncoder.encode(i[1]))
        }
        i=0
		while(i<1000){
            re_exp=re_exp+"&"+OAuthEncoder.encode("key-1000").concat("=").concat(OAuthEncoder.encode("value-1000"))
			i++
        }
        re_exp=re_exp.substring(1)
        @Assert(pl03.asFormUrlEncodedString(),re_exp)
    }
    //空的parameterList,返回空字符串
    @TestCase
    func testAsOauthBaseString01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        @Assert(pl01.asOauthBaseString(),"")
        @Assert(pl02.asOauthBaseString(),"")
    }
    //非空parameterList，返回各个Parameter调用asUrlEncodedPair()之后的值，并将其用&链接起来:较少个数
    @TestCase
    func testAsOauthBaseString02(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key03","")])
        var pl03=ParameterList(map02)//非空表
        var re_exp=""
		for (i in map02){
		    re_exp=re_exp+"&"+OAuthEncoder.encode(i[0]).concat("=").concat(OAuthEncoder.encode(i[1]))
		}
        re_exp=re_exp.substring(1)
        @Assert(pl03.asOauthBaseString(),OAuthEncoder.encode(re_exp))
    }
    //非空parameterList，返回各个Parameter调用asUrlEncodedPair()之后的值，并将其用&链接起来:1000个
    @TestCase
    func testAsOauthBaseString03(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)//非空表
        var i=0
		while(i<1000){
			pl03.add("key-1000","value-1000")
			i++
		}
        @Assert(pl03.size(),1002)
        var re_exp=""
        for (i in map02){
            re_exp=re_exp+"&"+OAuthEncoder.encode(i[0]).concat("=").concat(OAuthEncoder.encode(i[1]))
        }
		i=0
		while(i<1000){
			re_exp=re_exp+"&"+OAuthEncoder.encode("key-1000").concat("=").concat(OAuthEncoder.encode("value-1000"))
			i++
		}
        re_exp=re_exp.substring(1)
        @Assert(pl03.asOauthBaseString(),OAuthEncoder.encode(re_exp))
    }
    //包含，返回true
    @TestCase
    func testContains01(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key01","value03")])
        //=左侧无值
        var pl01=ParameterList(map02)//非空表
        pl01.add("key03","")
        pl01.add("","value03")
        @Assert(pl01.size(),map02.size+2)
        @Assert(pl01.contains(Parameter("key01","value01")),false)
        @Assert(pl01.contains(Parameter("key01","value03")),true)
        @Assert(pl01.contains(Parameter("key03","")),true)
        @Assert(pl01.contains(Parameter("","value03")),true)
    }
    //不包含,  返回false
    @TestCase
    func testContains02(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl01=ParameterList(map02)//非空表
        @Assert(pl01.contains(Parameter("","")),false)
        @Assert(pl01.contains(Parameter("key04","")),false)
        @Assert(pl01.contains(Parameter("key01","value01")),true)
        @Assert(pl01.contains(Parameter("key02","value01")),false)
    }
    //空列表，经过改变后，也随之变化
    @TestCase
    func testGetParams01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        @Assert(pl01.getParams().size,0)
        @Assert(pl02.getParams().size,0)
        pl01.add("key03","value03")
        pl02.add("key03","value03")
        @Assert(pl01.getParams().size,1)
        @Assert(pl02.getParams().size,1)
    }
    //非空列表,经过改变后，也随之变化
    @TestCase
    func testGetParams02(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)//非空表
        @Assert(pl03.size(),2)
        pl03.add("key03","value03")
        @Assert(pl03.size(),3)
        @Assert(pl03.getParams().size,3)
    }
    //空列表，经过改变后，也随之变化
    @TestCase
    func testSort01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        var s01_pl01=pl01.sort()
        var s01_pl02=pl01.sort()
        @Assert(s01_pl01.getParams().size,0)
        @Assert(s01_pl02.getParams().size,0)
        pl01.add("key03","value04")
        pl02.add("key03","value04")
        var s02_pl01=pl01.sort()
        var s02_pl02=pl01.sort()
        @Assert(s02_pl01.getParams().size,1)
        @Assert(s02_pl02.getParams().size,1)
        pl01.add("key03","value03")
        pl02.add("key03","value03")
        pl01.add("key04","value03")
        pl02.add("key04","value03")
        pl01.add("key03","value03")
        pl02.add("key03","value03")
        var exp=ArrayList<Parameter>([Parameter("key03","value03"),Parameter("key03","value03"),Parameter("key03","value04"),Parameter("key04","value03")])
        var s03_pl01=pl01.sort().getParams()
        var s03_pl02=pl02.sort().getParams()
        var flag=1
        for (index in 0..s03_pl01.size){
            flag=1
            if(s03_pl01[index]==exp[index] && s03_pl02[index]==exp[index]){
                flag=0
            }
            @Assert(flag,0)
        }

    }
    //非空列表,经过改变后，也随之变化
    @TestCase
    func testSort02(): Unit {
        var map01=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl01=ParameterList(map01)//非空表
        pl01.add("key03","value03")
        pl01.add("","value03")
        pl01.add("key03","")
        pl01.add("key04","")
        var exp=ArrayList<Parameter>([Parameter("","value03"),Parameter("key01","value01"),Parameter("key02","value02"),Parameter("key03",""),Parameter("key03","value03"),Parameter("key04","")])
        var s_pl01=pl01.sort().getParams()
        var flag=1
        for (index in 0..s_pl01.size){
            flag=1
            if(s_pl01[index]==exp[index]){
                flag=0
            }
            @Assert(flag,0)
        }
    }
}