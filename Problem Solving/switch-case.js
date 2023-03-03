/**
 * Print A, B, C, or D depending on the following criteria:
    If the first character in string  is in the set {a,e,i,o,u}, then print A.
    If the first character in string  is in the set {b,c,d,f,g}, then print B.
    If the first character in string  is in the set {h,j,k,l,m}, then print C.
    If the first character in string  is in the set {n,p,q,r,s,t,v,w,x,y,z}, then print D.
 */


function getLetter(s) {
    let letter;
    let firstCharacter = s.charAt(0);
    
    switch(true) {
        case 'aeiou'.includes(firstCharacter): letter = 'A';
                                                break;
        case 'bcdfg'.includes(firstCharacter): letter = 'B';
                                                break;
        case 'hjklm'.includes(firstCharacter): letter = 'C';
                                                break;
        default : letter ='D'; 
    }
    
    return letter;
}

console.log(getLetter('adfgt'));