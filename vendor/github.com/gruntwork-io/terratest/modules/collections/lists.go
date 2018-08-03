package collections

// ListSubtract removes all the items in list2 from list1.
func ListSubtract(list1 []string, list2 []string) []string {
	out := []string{}

	for _, item := range list1 {
		if !ListContains(list2, item) {
			out = append(out, item)
		}
	}

	return out
}

// ListContains returns true if the given list of strings (haystack) contains the given string (needle).
func ListContains(haystack []string, needle string) bool {
	for _, str := range haystack {
		if needle == str {
			return true
		}
	}

	return false
}
