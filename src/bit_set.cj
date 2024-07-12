/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the BitSet class.
 */
package oauth4cj

/**
 * The class is BitSet
 * @since 0.37.2
 */
class BitSet {

    private static let ADDRESS_BITS_PER_WORD: Int64 = 6

    private var words: Array<Int64>
    private var wordsInUse: Int64 = 0

    private var sizeIsSticky: Bool = false

    protected init(nbits: Int64) {
        if (nbits < 0) {
            throw OAuth4cjException("nbits < 0: ${nbits}")
        }
        this.sizeIsSticky = true
        this.words = Array<Int64>(wordIndex(nbits - 1) + 1, item: 0)
    }

    // Given a bit index, returns the word index that contains it.
    private static func wordIndex(bitIndex: Int64): Int64 {
        return bitIndex >> ADDRESS_BITS_PER_WORD
    }

    /**
     * Sets true of the bit at the specified index.
     *
     * @param a bit index
     *
     * @since 0.37.2
     */
    protected func set(bits: Int64): Unit {
        var bitIndex: Int64 = bits
        if (bitIndex < 0) {
            throw IndexOutOfBoundsException("bitIndex < 0: ${bitIndex}")
        }

        let wordIndex: Int64 = wordIndex(bitIndex)
        expandTo(wordIndex)

        if (bitIndex > 63) {
            bitIndex = bitIndex % 64
        }
        words[wordIndex] |= (1 << bitIndex)
    }

    /**
     * Returns the value of the bit with the specified index.
     * If the bit of index bit is currently set in this BitSet, then this value is true;
     * Otherwise, the result is false.
     *
     * @param a bit index
     *
     * @return The return type of Bool
     * @since 0.37.2
     */
    protected func get(bits: Int64): Bool {
        var bitIndex: Int64 = bits
        if (bitIndex < 0) {
            throw IndexOutOfBoundsException("bitIndex < 0: ${bitIndex}")
        }

        let wordIndex: Int64 = wordIndex(bitIndex)
        if (bitIndex > 63) {
            bitIndex = bitIndex % 64
        }
        return (wordIndex < wordsInUse) && ((words[wordIndex] & (1 << bitIndex)) != 0)
    }

    private func expandTo(wordIndex: Int64): Unit {
        let wordsRequired: Int64 = wordIndex + 1
        if (this.wordsInUse < wordsRequired) {
            ensureCapacity(wordsRequired)
            this.wordsInUse = wordsRequired
        }
    }

    private func ensureCapacity(wordsRequired: Int64): Unit {
        let len: Int64 = words.size
        if (len < wordsRequired) {
            var request: Int64 = 2 * len
            if (request < wordsRequired) {
                request = wordsRequired
            }
            let arr: Array<Int64> = Array<Int64>(request, item: 0)
            this.words.copyTo(arr, 0, 0, len)
            this.words = arr
            this.sizeIsSticky = false
        }
    }
}
