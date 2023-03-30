/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the CharArrayStream class.
 */
package buffer

from std import sync.*

/**
 * The class is CharArrayStream
 * @since 0.37.2
 */
public class CharArrayStream {
    private static let DEFAULT_CAPACITY: Int64 = 1024

    private var myData: Array<Char>
    private var start: Int64
    private var length_: Int64
    private let item: Char = ' '

    protected let mu: ReentrantMutex = ReentrantMutex()

    public init() {
        this(DEFAULT_CAPACITY)
    }

    public init(size: Int64) {
        this.myData = Array<Char>(size, item: item)
        this.start = 0
        this.length_ = 0
    }

    public prop let size: Int64 {
        get(){return this.length_}
    }

    public prop let capacity: Int64 {
        get(){return this.myData.size}
    }

    // Convert to character write buffer.
    public func write(ch: Int32): Unit {
        let item: Char = Char(ch)
        this.append(item)
    }

    public func write(item: Char): Unit {
        this.append(item)
    }

    public func append(item: Char): Unit {
        synchronized(this.mu) {
            this.reserve(1)
            this.myData[this.length_] = item
            this.length_ ++
        }
    }

    public func appendAll(buf: Array<Char>): Unit {
        let bufSize: Int64 = buf.size
        if (bufSize == 0) {
            return
        }
        synchronized(this.mu) {
            this.reserve(bufSize)
            buf.copyTo(this.myData, 0, this.start + this.length_, bufSize)
            this.length_ += bufSize
        }
    }

    func reserve(needCapacity: Int64): Unit {
        if (this.myData.size - this.start - this.length_ >= needCapacity){
            return
        }
        this.grow(this.myData.size + needCapacity)
    }

    private func grow(minCapacity: Int64): Unit {
        let oldCapacity: Int64 = this.myData.size
        var newCapacity: Int64 = oldCapacity + (oldCapacity >> 1)
        if (newCapacity < minCapacity) {
            newCapacity = minCapacity
        }
        let newData: Array<Char> = Array<Char>(newCapacity, item: ' ')

        this.myData.copyTo(newData, 0, 0, this.start + this.length_)
        this.myData = newData
    }

    /**
     * Returns a copy of unread data.
     *
     * @return Type of Array<Char>, Returns a copy of unread data.
     * @since 0.37.2
     */
    public func toCharArray(): Array<Char> {
        synchronized (this.mu) {
            return this.myData.slice(this.start, this.length_)
        }
    }

    public func toArray(): Array<Char> {
        let buf: Array<Char> = this.myData.slice(this.start, this.length_)
        this.start = 0
        this.length_ = 0
        return buf
    }

    public func isEmpty(): Bool {
        return this.start >= this.length_
    }

    public func reset(): Unit {
        this.clear()
    }

    public func clear(): Unit {
        this.start = 0
        this.length_ = 0
    }
}
