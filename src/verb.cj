/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package oauth4cj

/**
 * An enumeration containing the most common HTTP Verbs.
 */
public enum Verb <: ToString {
    | GET
    | POST
    | PUT
    | DELETE
    | HEAD
    | OPTIONS 
    | TRACE
    | PATCH
    
    /**
     * Whether a request body is required
     *
     * @Return Bool The return value varies depending on the operation
     *              GET=false POST=true PUT=true DELETE=false
     *              HEAD=false OPTIONS=false TRACE=false PATCH=true
     */
    public func isRequiresBody(): Bool {
        match (this) {
            case GET => false
            case POST => true
            case PUT => true
            case DELETE => false
            case HEAD => false
            case OPTIONS => false
            case TRACE => false
            case PATCH => true
        }
    }

    /**
     * Whether permission is required
     *
     * @Return Bool The return value varies depending on the operation
     *              GET=false POST=true PUT=true DELETE=true
     *              HEAD=false OPTIONS=false TRACE=false PATCH=false
     */
    public func isPermitBody(): Bool {
        match (this) {
            case GET => false
            case POST => true
            case PUT => true
            case DELETE => true
            case HEAD => false
            case OPTIONS => false
            case TRACE => false
            case PATCH => true
        }
    }

    /**
     * Convert the Verb name to a string
     *
     * @Return String The converted string
     */
    public func toString(): String {
        match (this) {
            case GET => "GET"
            case POST => "POST"
            case PUT => "PUT"
            case DELETE => "DELETE"
            case HEAD => "HEAD"
            case OPTIONS => "OPTIONS"
            case TRACE => "TRACE"
            case PATCH => "PATCH"
        }
    }
}