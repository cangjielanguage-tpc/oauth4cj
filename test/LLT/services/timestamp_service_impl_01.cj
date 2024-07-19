// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
public import oauth4cj.*
import std.time.*

func getCurrentTimeMillis(): Int64 {
    let res: Duration = DateTime.now() - DateTime.of(year: 1970, month: Month.January, dayOfMonth: 1)
    return res.toMilliseconds()
}

public func testTimestampServiceImpl_01(): Int32 {

    let ti: TimestampServiceImpl = TimestampServiceImpl()
    let result: String = (getCurrentTimeMillis() / 1000).toString()
    let str: String = ti.getTimestampInSeconds()
    println(result)
    println(str)

    if (str != result) {
        println(1)
        return 1
    }

    return 0
}

public func testTimestampServiceImpl_02(): Int32 {
    let ti: TimestampServiceImpl = TimestampServiceImpl()
    let str: String = ti.getTimestampInSeconds()
    let str2: String = ti.getNonce()

    if (str == str2) {
        println(2)
        return 2
    }

    return 0
}

main() {

    var test_01 = testTimestampServiceImpl_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testTimestampServiceImpl_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}