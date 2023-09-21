/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package oauth4cj

from std import collection.*

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
        for (scope in scopes) {
            scopeBuilder.append(' ').append(scope)
        }
        return scopeBuilder.toString().substring(1)
    }
}

