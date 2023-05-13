//go:build unit
// +build unit

package main

import (
	"reflect"
	"testing"
)

func TestFibonacci(t *testing.T) {
	n := 10
	expected := []int{0, 1, 1, 2, 3, 5, 8, 13, 21, 34}

	t.Run("Test fibonnaci sequence ", func(t *testing.T) {
		sequence := GetFibonacciSeq(n)

		if !reflect.DeepEqual(sequence, expected) {
			t.Errorf("Error comparing fibonnaci sequences %v, wantErr %v", sequence, false)
		}
	})
}
