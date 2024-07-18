// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

//1.6.2 示例
import std.collection.*
public import oauth4cj.*
main() {
    var scopeString: ArrayList<String> = ArrayList<String>()
    scopeString.append("scope_1")
    scopeString.append("scope_2")
    scopeString.append("scope_3")
    var scopeString_add: String = "scope_4"
    var scope: String = ScopeBuilder(scopeString).withScopes(scopeString_add).build()
    var montageString: String = "scope_1 scope_2 scope_3 scope_4"
    if (montageString!=scope) {
        return 1
    }
    println("Scope=${scope}")
    return 0
}