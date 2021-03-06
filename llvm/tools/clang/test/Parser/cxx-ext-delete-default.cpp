// RUN: %clang_cc1 -fsyntax-only -verify -std=c++98 %s

struct A {
  A(const A&) = delete; // expected-warning {{accepted as a C++11 extension}}
  A& operator=(const A&) = delete; // expected-warning {{accepted as a C++11 extension}}
  A() = default; // expected-warning {{accepted as a C++11 extension}}
  ~A();
};

void f() = delete; // expected-warning {{accepted as a C++11 extension}}
A::~A() = default; //expected-warning {{accepted as a C++11 extension}}
