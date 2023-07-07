/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the TimestampServiceImpl class.
 */
package services

from std import random.*
from std import time.*

/**
 * The class TimestampServiceImpl implementation of the TimestampService interface.
 */
public class TimestampServiceImpl <: TimestampService {

    private var timer: ServiceTimer

    /**
     * Create an TimestampServiceImpl instance.
     *
     * @since 0.38.2
     */
    public init() {
        this.timer = ServiceTimer()
    }

    /**
     * Returns a nonce (unique value for each request).
     *
     * @return nonce
     */
    public func getNonce(): String {
        let ts: Int64 = getTs()
        return (ts + Int64(timer.getRandomInteger())).toString()
    }

    /**
     * Returns the unix timestamp in seconds.
     *
     * @Return String timestamp
     */
    public func getTimestampInSeconds(): String {
        return getTs().toString()
    }

    private func getTs(): Int64 {
        return timer.getMilis() / 1000
    }
}

/**
 * Inner class that uses System for generating the timestamps.
 */
class ServiceTimer {

    private let RANDOM: Random = Random()
    private let DEFAULT_NUM: UInt64 = 32

    init() {}

    func getMilis(): Int64 {
        return getCurrentTimeMillis()
    }

    func getRandomInteger(): Int32 {
        RANDOM.seed = DEFAULT_NUM
        return RANDOM.nextInt32()
    }
}

func getCurrentTimeMillis(): Int64 {
    let res: Duration = DateTime.now() - DateTime.of(year: 1970, month: Month.January, dayOfMonth: 1)
    return res.toMilliseconds()
}
