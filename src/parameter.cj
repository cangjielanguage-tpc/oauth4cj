/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the OAuth4cjParameter class.
 */
package oauth4cj


public class OAuth4cjParameter {

    private let key: String
    private let value: String

    /**
     * Create a OAuth4cjParameter instance according to the parameter.
     *
     * @param key of String
     * @param value of String
     * @since 0.37.2
     */
    public init(key: String, value: String) {
        this.key = key
        this.value = value
    }

    /**
     * Encode the information in this OAuth4cjParameter object according to OAuthEncoder and splice it into a string.
     *
     * @return Type of String, return the spliced String.
     * @since 0.37.2
     */
    public func asUrlEncodedPair(): String {
        return OAuthEncoder.encode(key) + "=" + OAuthEncoder.encode(value)
    }

    /**
     * Get the key.
     *
     * @return Type of String
     * @since 0.37.2
     */
    public func getKey(): String {
        return this.key
    }

    /**
     * Get the value.
     *
     * @return Type of String
     * @since 0.37.2
     */
    public func getValue(): String {
        return this.value
    }

    /**
     * Get hash code.
     *
     * @return Type of Int64
     * @since 0.37.2
     */
    @OverflowWrapping
    public func hashCode(): Int64 {
        return key.hashCode() + value.hashCode()
    }

    /**
     * Overload the operator '==' to return the comparison results of two OAuth4cjParameter instances.
     *
     * @param that of OAuth4cjParameter
     *
     * @return Type of Bool
     * @since 0.37.2
     */
    public operator func ==(that: OAuth4cjParameter): Bool {
        if (refEq(this, that)) {
            return true
        }
        return (that.getKey() == this.key) && (that.getValue() == this.value)
    }

    /**
     * Determine the relationship between a OAuth4cjParameter instance and another OAuth4cjParameter instance.
     *
     * @param parameter of OAuth4cjParameter, another OAuth4cjParameter instance for comparison.
     *
     * @return Type of Ordering, If greater than, Ordering.GT is returned;
     *                           If equal, Ordering.EQ is returned;
     *                           If less than, Ordering.LT is returned.
     * @since 0.37.2
     */
    public func compareTo(parameter: OAuth4cjParameter): Ordering {
        let keyDiff: Ordering = this.key.compare(parameter.getKey())
        if (keyDiff != Ordering.EQ) {
            return keyDiff
        }
        return this.value.compare(parameter.getValue())
    }
}
