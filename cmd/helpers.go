package cmd

import "strings"

// isCacheFallbackErr returns true if the error indicates a permission
// or access issue (401, 403, 404) where falling back to cache is appropriate.
func isCacheFallbackErr(err error) bool {
	if err == nil {
		return false
	}
	msg := err.Error()
	return strings.Contains(msg, "status 401") ||
		strings.Contains(msg, "status 403") ||
		strings.Contains(msg, "status 404")
}
