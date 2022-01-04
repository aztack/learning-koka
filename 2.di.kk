import std/num/random

// "fun effect" ask effect
effect ask<a>
  ctl ask() : a
// "fun effect" emit effect
effect fun emit( msg : string ) : ()
// "val effect"
effect val width : int
effect val endl : string

// add-twice depends on ask effect
fun add-twice() : ask<int> int 
  ask() + ask()

// trunc depends on width effect
fun trunc(s: string): width string
  s.truncate(width)

// emit-hello depends on some effects
fun emit-hello(): <emit, width, endl, console> ()
  emit("hello")
  emit("world!!".truncate(width))
  print(endl)

fun main() {
  // inject ask effect with const
  with ctl ask(){ resume(21) }
  println(add-twice())
  
  // another shortcut way to inject ask effect
  with fun ask(){ 21 }
  println(add-twice())
  
  // inject ask effect with random
  with ctl ask(){ resume(random-int()) }
  println(add-twice())

  // inject "val effect" width with const
  with val width = 2
  println(trunc("hello"))

  // abstracting handlers
  // analogy with inversify.js dependency injection
  fun normal-module(action)
    with fun emit(msg: string){ print(msg ++ " ") }
    with val width = 5
    with val endl = "!\n"
    action()

  fun empty-module(action)
    with fun emit(msg: string){ print("") }
    with val width = 0
    with val endl = ""
    action()

  with normal-module
  emit-hello()

  with empty-module
  emit-hello()

}