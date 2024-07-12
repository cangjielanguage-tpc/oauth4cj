/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the ParameterList class.
 */
package oauth4cj

from std import collection.*

public class ParameterList {

    private static let QUERY_STRING_SEPARATOR: String = "?"
    private static let PARAM_SEPARATOR: String = "&"
    private static let PAIR_SEPARATOR: String = "="
    private static let EMPTY_STRING: String = ""

    private let params: ArrayList<OAuth4cjParameter>

    /**
     * Create a ParameterList instance.
     *
     * @since 0.37.2
     */
    public init() {
        this.params = ArrayList<OAuth4cjParameter>()
    }

    init(params: ArrayList<OAuth4cjParameter>) {
        this.params = params
    }

    /**
     * Create a ParameterList instance according to the parameter.
     *
     * @param map of HashMap<String, String>
     * @since 0.37.2
     */
    public init(map: HashMap<String, String>) {
        this.params = ArrayList<OAuth4cjParameter>(map.size)
        if (map.size > 0) {
            for ((k, v) in map) {
                params.append(OAuth4cjParameter(k, v))
            }
        }
    }

    /**
     * Add the key and value to this.
     *
     * @param key of String
     * @param value of String
     * @since 0.37.2
     */
    public func add(key: String, value: String): Unit {
        params.append(OAuth4cjParameter(key, value))
    }

    /**
     * Process the url and return a new string.
     *
     * @param url of String, process the url.
     *
     * @return Type of String
     * @since 0.37.2
     */
    public func appendTo(url: String): String {
        let queryString: String = asFormUrlEncodedString()
        if (queryString == EMPTY_STRING) {
            return url
        } else {
            let separatorNum: Int64 = url.indexOf(QUERY_STRING_SEPARATOR) ?? -1
            var separatorString: String = PARAM_SEPARATOR
            if (separatorNum == -1) {
                separatorString = QUERY_STRING_SEPARATOR.toString()
            }

            return url + separatorString + queryString
        }
    }

    /**
     * Process the information in the ParameterList object and encode it according to OAuthEncoder.
     *
     * @return Type of String, returns a processed and encoded string.
     * @since 0.37.2
     */
    public func asOauthBaseString(): String {
        return OAuthEncoder.encode(asFormUrlEncodedString())
    }

    /**
     * Process the information in the ParameterList object and splice it into a string.
     *
     * @return Type of String, return the spliced String.
     * @since 0.37.2
     */
    public func asFormUrlEncodedString(): String {
        if (params.isEmpty()) {
            return EMPTY_STRING
        }

        let builder: StringBuilder = StringBuilder()
        var isFirst: Bool = true
        for (param in params) {
            if (isFirst) {
                isFirst = false
                builder.append(param.asUrlEncodedPair())
                continue
            }
            builder.append(PARAM_SEPARATOR)
            builder.append(param.asUrlEncodedPair())
        }
        return builder.toString()
    }

    /**
     * Add the other to this ParameterList object.
     *
     * @param other of ParameterList
     * @since 0.37.2
     */
    public func addAll(other: ParameterList): Unit {
        params.appendAll(other.getParams())
    }

    /**
     * Process queryString and append to this ParameterList object.
     *
     * @param queryString of String
     * @since 0.37.2
     */
    public func addQuerystring(queryStr: String): Unit {
        var queryString: String = queryStr
        while (queryString.endsWith(PARAM_SEPARATOR)) {
            queryString = queryString.trimRight(PARAM_SEPARATOR)
        }
        if (!queryString.isEmpty()) {
            var paramsBuf: Array<String> = Array<String>([queryString])
            if (queryString.contains(PARAM_SEPARATOR)) {
                paramsBuf = queryString.split(PARAM_SEPARATOR)
            }

            for (i in 0..paramsBuf.size) {
                let param: String = paramsBuf[i]

                var pair: Array<String> = Array<String>([param])
                let num: Int64 = queryString.count("=")
                if (num == queryString.size && queryString.contains(PAIR_SEPARATOR)) {
                    pair = Array<String>()
                } else if (queryString.contains(PAIR_SEPARATOR)) {
                    pair = param.split(PAIR_SEPARATOR)
                }

                let key: String = OAuthEncoder.decode(pair[0])
                var value: String = EMPTY_STRING
                if (pair.size > 1) {
                    value = OAuthEncoder.decode(pair[1])
                }
                params.append(OAuth4cjParameter(key, value))
            }
        }
    }

    /**
     * Determine whether the current ParameterList object contains a param object.
     *
     * @param param of OAuth4cjParameter, determine whether to include this param object.
     *
     * @return Type of Bool
     * @since 0.37.2
     */
    public func contains(param: OAuth4cjParameter): Bool {
        for (pa in this.params) {
            if (pa == param) {
                return true
            }
        }
        return false
    }

    /**
     * Get the ParameterList object size.
     *
     * @return Type of Int64
     * @since 0.37.2
     */
    public func size(): Int64 {
        return this.params.size
    }

    /**
     * Get the params value.
     *
     * @return Type of ArrayList<OAuth4cjParameter>
     * @since 0.37.2
     */
    public func getParams(): ArrayList<OAuth4cjParameter> {
        return this.params
    }

    /**
     * Returns the sorted new ParameterList object.
     *
     * @return Type of ParameterList
     * @since 0.37.2
     */
    public func sort(): ParameterList {
        let sorted: ParameterList = ParameterList(this.params)
        sorted.params.sortBy(stable: true, comparator: this.compareTo)
        return sorted
    }


    private func compareTo(right: OAuth4cjParameter, left: OAuth4cjParameter): Ordering {
        let keyDiff: Ordering = right.getKey().compare(left.getKey())
        if (keyDiff != Ordering.EQ) {
            return keyDiff
        }
        return right.getValue().compare(left.getValue())
    }
}
