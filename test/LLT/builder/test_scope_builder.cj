// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.collection.*
public import oauth4cj.*

func testScopeBuilder_01(): Int32 {
    var scopeString: String = "scope_1"
    var scope: String = ScopeBuilder().withScope(scopeString).build()
    var montageString: String = "scope_1"
    if (montageString == scope) {
        return 0
    } else {
        return -1
    }
}

func testScopeBuilder_02(): Int32 {
    var scopeString: Array<String> = Array<String>(3, item:"")
    scopeString[0] = "scope_1"
    scopeString[1] = "scope_2"
    scopeString[2] = "scope_3"
    var scope: String = ScopeBuilder().withScopes(scopeString).build()
    var montageString: String = "scope_1 scope_2 scope_3"
    if (montageString == scope) {
        return 0
    } else {
        return -1
    }
}

func testScopeBuilder_03(): Int32 {
    var scopeString: HashSet<String> = HashSet<String>()
    scopeString.put("scope_1")
    scopeString.put("scope_2")
    scopeString.put("scope_3")
    var scope: String = ScopeBuilder().withScopes(scopeString).build()
    var montageString: String = "scope_1 scope_2 scope_3"
    if (montageString == scope) {
        return 0
    } else {
        return -1
    }
}

func testScopeBuilder_04(): Int32 {
    var scopeString: ArrayList<String> = ArrayList<String>()
    scopeString.append("scope_1")
    scopeString.append("scope_2")
    scopeString.append("scope_3")
    var scope: String = ScopeBuilder().withScopes(scopeString).build()
    var montageString: String = "scope_1 scope_2 scope_3"
    if (montageString == scope) {
        return 0
    } else {
        return -1
    }
}

func testScopeBuilder_05(): Int32 {
    var scopeString: Array<String> = Array<String>(3, item:"")
    scopeString[0] = "scope_1"
    scopeString[1] = "scope_2"
    scopeString[2] = "scope_3"
    var scopeString_add: ArrayList<String> = ArrayList<String>()
    scopeString_add.append("scope_4")
    scopeString_add.append("scope_5")
    scopeString_add.append("scope_6")
    var scope: String = ScopeBuilder(scopeString).withScopes(scopeString_add).build()
    var montageString: String = "scope_1 scope_2 scope_3 scope_4 scope_5 scope_6"
    if (montageString == scope) {
        return 0
    } else {
        return -1
    }
}

func testScopeBuilder_06(): Int32 {
    var scopeString: ArrayList<String> = ArrayList<String>()
    scopeString.append("scope_1")
    scopeString.append("scope_2")
    scopeString.append("scope_3")
    var scopeString_add: String = "scope_4"
    var scope: String = ScopeBuilder(scopeString).withScopes(scopeString_add).build()
    var montageString: String = "scope_1 scope_2 scope_3 scope_4"
    if (montageString == scope) {
        return 0
    } else {
        return -1
    }
}

func testScopeBuilder_07(): Int32 {
    var scopeString: String = "scope_1"
    var scopeString_add: String = "scope_2"
    var scope: String = ScopeBuilder(scopeString).withScope(scopeString_add).build()
    var montageString: String = "scope_1 scope_2"
    if (montageString == scope) {
        return 0
    } else {
        return -1
    }
}

main() {
    var test_01 = testScopeBuilder_01()
    var test_02 = testScopeBuilder_02()
    var test_03 = testScopeBuilder_03()
    var test_04 = testScopeBuilder_04()
    var test_05 = testScopeBuilder_05()
    var test_06 = testScopeBuilder_06()
    var test_07 = testScopeBuilder_07()

    var sum = test_01+test_02+test_03+test_04+test_05+test_06+test_07
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}," +
        "test_05=${test_05}, test_06=${test_06}, test_07=${test_07}")
    return sum
}