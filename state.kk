effect state<a>
  fun get() : a
  fun set( x : a ) : ()

fun sumdown( sum : int = 0 ) : <state<int>,div> int
  val i = get()
  if i <= 0 then sum else 
    set( i - 1 )
    sumdown( sum + i )

fun state( init : a, action : () -> <state<a>,div|e> b ) : <div|e> (b,a)
  var st := init
  with return(x) {(x, st)}
  with handler
    fun get() { st }
    fun set(i){ st := i }
  action()

fun main() {
  println(state(10){ sumdown() })
}