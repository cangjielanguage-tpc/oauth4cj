/**
 * @file The file declars the CharArrayStream class.
 */
package oauth4cj

internal import std.sync.*

/**
 * The class is CharArrayStream
 * @since 0.37.2
 */
class CharArrayStream {
    private static let DEFAULT_CAPACITY: Int64 = 1024

    private var myData: Array<Rune>
    private var start: Int64
    private var length_: Int64
    private let item: Rune = r' '

    protected let mu: ReentrantMutex = ReentrantMutex()

    init() {
        this(DEFAULT_CAPACITY)
    }

    init(size: Int64) {
        this.myData = Array<Rune>(size, repeat: item)
        this.start = 0
        this.length_ = 0
    }

    func write(item: Rune): Unit {
        this.append(item)
    }

    func append(item: Rune): Unit {
        synchronized(this.mu) {
            this.reserve(1)
            this.myData[this.length_] = item
            this.length_ ++
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
        let newData: Array<Rune> = Array<Rune>(newCapacity, repeat: r' ')

        this.myData.copyTo(newData, 0, 0, this.start + this.length_)
        this.myData = newData
    }

    /**
     * Returns a copy of unread data.
     *
     * @return Type of Array<Rune>, Returns a copy of unread data.
     * @since 0.37.2
     */
    func toCharArray(): Array<Rune> {
        synchronized (this.mu) {
            return this.myData[this.start..(this.start + this.length_)]
        }
    }

    func reset(): Unit {
        this.clear()
    }

    func clear(): Unit {
        this.start = 0
        this.length_ = 0
    }
}
