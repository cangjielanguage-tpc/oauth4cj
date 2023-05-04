from std import math.*

/*****   字符串等价类
1. 空字符串--strEmpty
2. 固定长度(length)字符串--getStringByLength(length)
3. 多行字符串字面量--strMulti
4. 多行原始字符串字面量--strOriginMulti
5. 空白字符串--strBlank
   ****/
public var strEmpty=""
public  var strBlank=" "
public  var strMulti="""
    Hello,
    Oauth4cj"""

public  var strOriginMulti=###"
    Hello,
    Oauth4cj"###
public var strCommon="hello Cangjie"

public var strValues=Array<String>([strEmpty,getStringByLength(1000),strMulti,strOriginMulti,strBlank,strCommon])


/*****    Int64等价类  ******/
public var int64Values=Array<Int64>([Int64.Max,Int64.Min,Int64.Max-1,Int64.Min+1,0])
/*****    Int32等价类  ******/
public var int32Values=Array<Int32>([Int32.Max,Int32.Min,Int32.Max-1,Int32.Min+1,0])
/*****    Int16等价类  ******/
public var int16Values=Array<Int16>([Int16.Max,Int16.Min,Int16.Max-1,Int16.Min+1,0])

/*****    Int8等价类  ******/
public var int8Values=Array<Int8>([Int8.Max,Int8.Min,Int8.Max-1,Int8.Min+1,0])


/*****    Bool等价类  ******/
public var boolValues=Array<Bool>([true,false])

/*****    返回固定长度字符串 ****/
public func getStringByLength(length:Int64):String{
    var str02=""
    var i=0
    while(i<10000){
        str02+=i.toString()
        i=str02.size
    }
    return str02
}
