/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package oauth

/**
 * OAuth1 Signature Type
 */
public enum OAuth1SignatureType <: ToString {
    | HEADER
    | QUERY_STRING

    /**
     * Get oauth1 signature type string
     * 
     * @return String type string
     */
    public func toString(): String {
        match (this) {
            case HEADER => "HEADER"
            case QUERY_STRING => "QUERY_STRING"
        }
    }
}

