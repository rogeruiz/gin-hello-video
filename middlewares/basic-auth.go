package middlewares

import "github.com/gin-gonic/gin"

// BasicAuth returns a Gin BasicAuth Account.
func BasicAuth() gin.HandlerFunc {
	return gin.BasicAuth(gin.Accounts{
		"rogeruiz": "test",
	})
}
