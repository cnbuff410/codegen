// Created by Kun Li(likunarmstrong@gmail.com) on xx/xx/xx.
// Copyright (c) 2014 Athlete Architect. All rights reserved.

package xxx_test

import "testing"

func Testxxx(t *testing.T) {
	result := GCD(in1, in2)
	if result != out {
		t.Errorf("gcd(%d, %d) = %d, want %d", in1, in2, result, out)
	}
}
