// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import model.*

from std import collection.HashMap
from std import collection.ArrayList
from std import io.*

// Response

// close()
public func testResponse_06():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    var stream:ByteArrayStream = ByteArrayStream()
    var closeables:ArrayList<Closeable> = ArrayList<Closeable>()
    var aClass:A = A()
    closeables.append(aClass)
    var response_1:Response = Response(200, "message", headers, stream, closeables)
    try {
        response_1.close()
    } catch (ioE:IOException) {
        println("response_1:${ioE}")
        return -1
    }
    try {
        response_1.close()
    } catch (ioE:IOException) {
        println("response_1:${ioE}")
        return -1
    }
    return 0
}

// close()
public func testResponse_07():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    var stream:ByteArrayStream = ByteArrayStream()
    var closeables:ArrayList<Closeable> = ArrayList<Closeable>()
    var aClass:A = A()
    closeables.append(aClass)
    var bClass:B = B()
    closeables.append(bClass)
    var response_2:Response = Response(200, "message", headers, stream, closeables)
    try {
        response_2.close()
    } catch (ioE:IOException) {
        println("response_2:${ioE}")
        return 0
    }
    return -1
}

// close()
public func testResponse_08():Int32 {
    var headers:HashMap<String, String> = HashMap<String, String>()
    var stream:ByteArrayStream = ByteArrayStream()
    var closeables:ArrayList<Closeable> = ArrayList<Closeable>()
    var response_3:Response = Response(200, "message", headers, stream, closeables)
    try {
        response_3.close()
    } catch (ioE:IOException) {
        println("response_3:${ioE}")
        return -1
    }
    return 0
}

class A <: Closeable {
    public init() {}
    public func close():Unit {
        println("A close")
    }
}

class B <: Closeable {
    public init() {}
    public func close():Unit {
        throw IOException("ioException")
    }
}

main() {
    var test_06 = testResponse_06()
    var test_07 = testResponse_07()
    var test_08 = testResponse_08()

    var sum = test_06+test_07+test_08
    println(sum)
    println("test_06=${test_06}, test_07=${test_07}, test_08=${test_08}")
    return sum
}