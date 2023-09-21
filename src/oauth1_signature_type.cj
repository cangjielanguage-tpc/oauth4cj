/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package oauth4cj

/**
 * OAuth1 Signature Type
 */
public enum OAuth1SignatureType <: ToString {
    | HEADER_SIGNATURE
    | QUERY_STRING_SIGNATURE

    /**
     * Get oauth1 signature type string
     * 
     * @return String type string
     */
    public func toString(): String {
        match (this) {
            case HEADER_SIGNATURE => "HEADER"
            case QUERY_STRING_SIGNATURE => "QUERY_STRING"
        }
    }
}

