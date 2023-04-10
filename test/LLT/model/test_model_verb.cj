// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import model.*

// Verb

// isRequiresBody()
public func testVerb_01():Int32 {
    if (Verb.GET.isRequiresBody()) {
        return -1
    }
    if (!Verb.POST.isRequiresBody()) {
        return -1
    }
    if (!Verb.PUT.isRequiresBody()) {
        return -1
    }
    if (Verb.DELETE.isRequiresBody()) {
        return -1
    }
    if (Verb.HEAD.isRequiresBody()) {
        return -1
    }
    if (Verb.OPTIONS.isRequiresBody()) {
        return -1
    }
    if (Verb.TRACE.isRequiresBody()) {
        return -1
    }
    if (Verb.PATCH.isRequiresBody()) {
        return -1
    }
    return 0
}

// isPermitBody()
public func testVerb_02():Int32 {
    if (Verb.GET.isPermitBody()) {
        return -1
    }
    if (Verb.POST.isPermitBody()) {
        return -1
    }
    if (Verb.PUT.isPermitBody()) {
        return -1
    }
    if (!Verb.DELETE.isPermitBody()) {
        return -1
    }
    if (Verb.HEAD.isPermitBody()) {
        return -1
    }
    if (Verb.OPTIONS.isPermitBody()) {
        return -1
    }
    if (Verb.TRACE.isPermitBody()) {
        return -1
    }
    if (Verb.PATCH.isPermitBody()) {
        return -1
    }
    return 0
}

main() {
    var test_01 = testVerb_01()
    var test_02 = testVerb_02()

    var sum = test_01+test_02
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}")
    return sum
}
