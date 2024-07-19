/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */
package oauth4cj


/**
 * Scope Builder
 */
public class ScopeBuilder {
    private let scopes: HashSet<String> = HashSet<String>()

    /**
     * Create ScopeBuilder instance
     */
    public init() {
    }

    /**
     * Create ScopeBuilder instance
     *
     * @param scope The scope string
     */
    public init(scope: String) {
        withScope(scope)
    }

    /**
     * Create ScopeBuilder instance
     *
     * @param scopes The scope array
     */
    public init(scopes: Array<String>) {
        withScopes(scopes)
    }

    /**
     * Create ScopeBuilder instance
     *
     * @param scopes The scope collection
     */
    public init(scopes: Collection<String>) {
        withScopes(scopes)
    }

    /**
     * Add scope
     *
     * @param scope The scope string
     * @return ScopeBuilder ScopeBuilder instance
     */
    public func withScope(scope: String): ScopeBuilder {
        scopes.put(scope)
        return this
    }

    /**
     * Add scopes
     *
     * @param scopes The scope array
     * @return ScopeBuilder ScopeBuilder instance
     */
    public func withScopes(scopes: Array<String>): ScopeBuilder {
        this.scopes.putAll(scopes)
        return this
    }

    /**
     * Add scopes
     *
     * @param scopes The scope collection
     * @return ScopeBuilder ScopeBuilder instance
     */
    public func withScopes(scopes: Collection<String>): ScopeBuilder {
        this.scopes.putAll(scopes)
        return this
    }

    /**
     * Build complete scope string
     *
     * @return String complete scope string
     */
    public func build(): String {
        let scopeBuilder: StringBuilder = StringBuilder()
        var isFirst: Bool = true
        for (scope in scopes) {
            if (isFirst) {
                isFirst = false
                scopeBuilder.append(scope)
                continue
            }
            scopeBuilder.append(r' ')
            scopeBuilder.append(scope)
        }
        var scopeString = scopeBuilder.toString()
        Preconditions.checkEmptyString(scopeString, "Cannot get String from a empty ScopeBuilder.")
        return scopeString
    }
}

