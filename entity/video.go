package entity

// Person structure
type Person struct {
	FirstName string `json:"first_name" binding:"required"`
	LastName  string `json:"last_name" binding:"required"`
	Age       int8   `json:"age" binding:"gte=1,lte=130"`
	Email     string `json:"email" validate:"required,email"`
}

// Video structure
type Video struct {
	Title       string `json:"title" binding:"min=2,max=80" validate:"is-cool"`
	Description string `json:"description" binding:"max=100"`
	URL         string `json:"url" binding:"required,url"`
	Author      Person `json:"author" binding:"required"`
}
