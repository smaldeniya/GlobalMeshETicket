package com.globalmesh.test;

import java.util.ArrayList;
import java.util.List;

import com.globalmesh.util.RandomKeyGen;
import com.globalmesh.util.Utility;

public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		List<String> a = new ArrayList<String>();
		
		for(int i=0; i < 100000000; i++) {
			String rand = RandomKeyGen.createId();
			if(a.contains(rand)){
				System.out.println("contains " + rand);
			} else {
				a.add(rand);
			}
		}
	}

}
