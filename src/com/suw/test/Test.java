package com.suw.test;


public class Test {
	
	public static void main(String[] args) {
		String s = "b #light# code #/light# #code# public void a(){ int a=3; }; #/code#";
		s = s.replace("#light#", "asd");
		int indexOf = s.indexOf("#light#");
		System.out.println(indexOf);
		System.out.println(s);
	}
}
