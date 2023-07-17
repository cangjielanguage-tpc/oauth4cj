// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from std import io.*

main (){

    var flag = testOAuth4cjRequestgetQueryStringParams01()
    if (flag != 0){
        return flag
    }

    flag = testOAuth4cjRequestgetQueryStringParams02()
    if (flag != 0){
        return flag
    }
    return flag
}

/***
    初始化查询：url不带参数，url无效协议
***/
func testOAuth4cjRequestgetQueryStringParams01(): Int64 {
    var url="sss://www.baidu.com"

    try{
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
        oauth4cjRequest.getQueryStringParams().asFormUrlEncodedString()
    }catch(e:Exception){
        //e.printStackTrace()
        if(e.toString().contains("Malformed URL")){
             return 0
        }
    }
    return 1
}

func testOAuth4cjRequestgetQueryStringParams02(): Int64 {
    var url="www.baidu.com"
    try{
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
        oauth4cjRequest.getQueryStringParams().asFormUrlEncodedString()
    }catch(e:Exception){
        if(e.toString().contains("Malformed URL")){
             return 0
        }
    }
    return 1
}
