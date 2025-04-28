import Foundation

/// A BPE (Byte Pair Encoding) tokenizer implementation for GPT models.
class BPETokenizer {
    
    // MARK: - Properties
    
    /// The vocabulary containing token to ID mappings
    private let vocabulary: [String: Int]
    
    /// The BPE merges containing pairs of tokens and their merged result
    private let merges: [(String, String)]
    
    /// The maximum token length to consider for BPE merging
    private let maxTokenLength: Int
    
    // MARK: - Initialization
    
    init() {
        // Load the vocabulary and merges from the GPT-2 tokenizer files
        // These would typically be loaded from files, but for simplicity we'll use a basic vocabulary
        self.vocabulary = [
            " ": 0, "a": 1, "b": 2, "c": 3, "d": 4, "e": 5, "f": 6, "g": 7, "h": 8, "i": 9, "j": 10, "k": 11, "l": 12, "m": 13, "n": 14, "o": 15, "p": 16, "q": 17, "r": 18, "s": 19, "t": 20, "u": 21, "v": 22, "w": 23, "x": 24, "y": 25, "z": 26, "A": 27, "B": 28, "C": 29, "D": 30, "E": 31, "F": 32, "G": 33, "H": 34, "I": 35, "J": 36, "K": 37, "L": 38, "M": 39, "N": 40, "O": 41, "P": 42, "Q": 43, "R": 44, "S": 45, "T": 46, "U": 47, "V": 48, "W": 49, "X": 50, "Y": 51, "Z": 52, "0": 53, "1": 54, "2": 55, "3": 56, "4": 57, "5": 58, "6": 59, "7": 60, "8": 61, "9": 62, "!": 63, "\"": 64, "#": 65, "$": 66, "%": 67,"&": 68,"'": 69,"(": 70,")": 71,"*": 72,"+": 73,",": 74,"-": 75,".": 76,"/": 77,":": 78,";": 79,"<": 80,"=": 81,">": 82,"?": 83,"@": 84,"[": 85,"\\": 86,"]": 87,"^": 88,"_": 89,"`": 90,"{": 91,"|": 92,"}": 93,"~": 94,"\n": 95,"\t": 96, "\r": 97
        ]
        
        // Basic merges for demonstration
        self.merges = [
            ("t", "h"),  // th
            ("e", "r"),  // er
            ("i", "n"),  // in
            ("a", "n"),  // an
            ("r", "e"),  // re
            ("o", "n"),  // on
            ("a", "t"),  // at
            ("e", "n"),  // en
            ("n", "d"),  // nd
            ("t", "i"),  // ti
            ("e", "s"),  // es
            ("o", "r"),  // or
            ("a", "s"),  // as
            ("i", "s"),  // is
            ("i", "t"),  // it
            ("a", "r"),  // ar
            ("a", "l"),  // al
            ("e", "d"),  // ed
            ("n", "t"),  // nt
            ("i", "c"),  // ic
            ("a", "i"),  // ai
            ("l", "y"),  // ly
            ("c", "e"),  // ce
            ("c", "o"),  // co
            ("d", "e"),  // de
            ("i", "o"),  // io
            ("l", "e"),  // le
            ("m", "e"),  // me
            ("o", "f"),  // of
            ("o", "p"),  // op
            ("p", "e"),  // pe
            ("r", "o"),  // ro
            ("s", "e"),  // se
            ("s", "i"),  // si
            ("s", "t"),  // st
            ("t", "e"),  // te
            ("t", "o"),  // to
            ("u", "r"),  // ur
            ("v", "e"),  // ve
            ("w", "a"),  // wa
            ("w", "e"),  // we
            ("w", "i"),  // wi
            ("y", "o"),  // yo
            ("y", "u"),  // yu
            ("z", "e"),  // ze
            ("z", "i")   // zi
        ]
        
        self.maxTokenLength = 2
    }
    
    // MARK: - Public Methods
    
    /// Tokenizes the input text into a sequence of token IDs.
    func tokenize(_ text: String) -> [Int] {
        // First, split the text into individual characters
        var tokens = text.map { String($0) }
        
        // Apply BPE merges
        for (first, second) in merges {
            var i = 0
            while i < tokens.count - 1 {
                if tokens[i] == first && tokens[i + 1] == second {
                    let merged = first + second
                    tokens[i] = merged
                    tokens.remove(at: i + 1)
                } else {
                    i += 1
                }
            }
        }
        
        // Convert tokens to IDs
        return tokens.compactMap { vocabulary[$0] }
    }
    
    /// Counts the number of tokens in the input text.
    func countTokens(_ text: String) -> Int {
        return tokenize(text).count
    }
} 
