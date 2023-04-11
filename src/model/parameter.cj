/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the Parameter class.
 */
package model


public class Parameter {

    private let key: String
    private let value: String

    /**
     * Create a Parameter instance according to the parameter.
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
     * Encode the information in this Parameter object according to OAuthEncoder and splice it into a string.
     *
     * @return Type of String, return the spliced String.
     * @since 0.37.2
     */
    public func asUrlEncodedPair(): String {
        return OAuthEncoder.encode(key).concat("=").concat(OAuthEncoder.encode(value))
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
    public func hashCode(): Int64 {
        return key.hashCode() + value.hashCode()
    }

    /**
     * Overload the operator '==' to return the comparison results of two Parameter instances.
     *
     * @param that of Parameter
     *
     * @return Type of Bool
     * @since 0.37.2
     */
    public operator func ==(that: Parameter): Bool {
        if (refEq(this, that)) {
            return true
        }
        return that.getKey().equals(this.key) && that.getValue().equals(this.value)
    }

    /**
     * Determine the relationship between a Parameter instance and another Parameter instance.
     *
     * @param parameter of Parameter, another Parameter instance for comparison.
     *
     * @return Type of Ordering, If greater than, Ordering.GT is returned;
     *                           If equal, Ordering.EQ is returned;
     *                           If less than, Ordering.LT is returned.
     * @since 0.37.2
     */
    public func compareTo(parameter: Parameter): Ordering {
        let keyDiff: Ordering = this.key.compare(parameter.getKey())
        if (keyDiff != Ordering.EQ) {
            return keyDiff
        }
        return this.value.compare(parameter.getValue())
    }
}
