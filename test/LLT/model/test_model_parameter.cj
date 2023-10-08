// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*

// public init("", "") public init("key", "value")  public func getKey() public func getValue()
public func testParameter_01():Int32 {
    var para = Parameter("", "")
    if (!"".equals(para.getKey())) {
        println(para.getKey())
        return -1
    }
    if (!"".equals(para.getValue())) {
        println(para.getValue())
        return -1
    }

    var para_2 = Parameter("key", "value")
    if (!"key".equals(para_2.getKey())) {
        println(para_2.getKey())
        return -1
    }
    if (!"value".equals(para_2.getValue())) {
        println(para_2.getValue())
        return -1
    }

    return 0
}

// public func hashCode(): Int64
public func testParameter_02():Int32 {
    var para = Parameter("", "")
    var keyCode = para.getKey().hashCode()
    var valueCode = para.getValue().hashCode()
    var code = keyCode + valueCode
    if (code != para.hashCode()) {
        return -1
    }

    var para_2 = Parameter("key", "value")
    var keyCode_2 = para_2.getKey().hashCode()
    var valueCode_2 = para_2.getValue().hashCode()
    var code_2 = keyCode_2 + valueCode_2
    if (code_2 != para_2.hashCode()) {
        return -1
    }
    return 0
}

// public operator func ==(that: Parameter): Bool
public func testParameter_03():Int32 {
    var para = Parameter("key", "value")
    var result = para == para
    if (!result) {
        return -1
    }

    var para_2 = Parameter("key_2", "value_2")
    var result_2 = para == para_2
    if (result_2) {
        return -1
    }

    var para_3 = Parameter("key", "value_3")
    var result_3 = para == para_3
    if (result_3) {
        return -1
    }

    var para_4 = Parameter("key_4", "value")
    var result_4 = para == para_4
    if (result_4) {
        return -1
    }
    return 0  
}

// public func compareTo(parameter: Parameter): Ordering
public func testParameter_04():Int32 {
    var para = Parameter("key", "value")
    var result = para.compareTo(para)
    if (result != Ordering.EQ) {
        return -1
    }

    var para_2 = Parameter("key_2", "value")
    var result_2 = para.compareTo(para_2)
    if (result_2 != Ordering.LT) {
        return -1
    }

    var para_3 = Parameter("key", "3_value")
    var result_3 = para.compareTo(para_3)
    if (result_3 != Ordering.GT) {
        return -1
    }

    return 0
}

// 注意这个方法：asUrlEncodedPair返回的结果是编码后结果，需要调用解码才能正确比较
public func testParameter_05():Int32 {
    var para = Parameter("key key", "value value")
    var encoded = para.asUrlEncodedPair()
    if (!"key key=value value".equals(OAuthEncoder.decode(encoded))) {
        println(OAuthEncoder.decode(encoded))
        return -1
    }
    return 0
}

main() {
    var test_01 = testParameter_01()
    var test_02 = testParameter_02()
    var test_03 = testParameter_03()
    var test_04 = testParameter_04()
    var test_05 = testParameter_05()

    var sum = test_01+test_02+test_03+test_04+test_05
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}, test_05=${test_05}")
    return sum
}