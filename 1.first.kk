effect raise_effect // type
  ctl raise_operation( msg : string ) : a // operation

fun safe-divide( x : int, y : int ) : raise_effect int 
  if y==0 then raise_operation("div-by-zero")
  else x / y

// raise-const is total again
// and the handler discharged the raise_effect.
fun rise-const(x: int, y: int) : total int
  with handler
    ctl raise_operation(msg){42}
  8 + safe-divide(x, y) 

fun main() {
  println(rise-const(20, 0))
}
