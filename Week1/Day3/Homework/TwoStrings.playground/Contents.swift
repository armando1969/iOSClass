

func twoStrings(n: Int, string1: String, string2: String) -> String
{
    
    var letterSet1 = Set<Character>()
    var letterSet2 = Set<Character>()
    
    for i in 0..<string1.count
    {
        letterSet1.insert(string1[string1.index(string1.startIndex, offsetBy: i)])
    }
    for j in 0..<string2.count
    {
        letterSet2.insert(string2[string2.index(string2.startIndex, offsetBy: j)])
    }
    if letterSet1.count < letterSet2.count {
        for n in 0..<letterSet1.count {
            if(letterSet2.contains(string1[string1.index(string1.startIndex, offsetBy: n)])) {
                return "Yes"
            }
        }
    }
    else    {
        for m in 0..<letterSet2.count {
            if(letterSet1.contains(string2[string2.index(string2.startIndex, offsetBy: m)])) {
                return "Yes"
            }
        }
    }
    return "NO"
}

var areTheretwoStrings = twoStrings(n: 4, string1: "wouldyoulikefries", string2: "abcabcabcabcabcabc")
var arethereTwoStrings2 = twoStrings(n: 4, string1: "hackerrankcommunity", string2: "cdecdecdecdecde")
var arethereTwoStrings3 = twoStrings(n: 4, string1: "jackandjill", string2: "wentupthehill")
var arethereTwoStrings4 = twoStrings(n: 4, string1: "writetoyourparrents", string2: "fghmqzldbc")

print(areTheretwoStrings)
print(arethereTwoStrings2)
print(arethereTwoStrings3)
print(arethereTwoStrings4)
