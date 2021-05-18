package validators

import (
	"strings"

	"github.com/go-playground/validator/v10"
)

// ValidateCoolTitle checks if the field contains the string "Cool".
func ValidateCoolTitle(field validator.FieldLevel) bool {
	return strings.Contains(field.Field().String(), "Cool")
}
