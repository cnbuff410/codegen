// Tests for xxx.go

package xxx_test

import "testing"

func Testxxx(t *testing.T) {
	result := GCD(in1, in2)
	if result != out {
		t.Errorf("gcd(%d, %d) = %d, want %d", in1, in2, result, out)
	}
}
