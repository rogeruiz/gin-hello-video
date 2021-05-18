package controller

import (
	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"github.com/rogeruiz/gin-hello-world/entity"
	"github.com/rogeruiz/gin-hello-world/service"
	"github.com/rogeruiz/gin-hello-world/validators"
)

// VideoController represents a Gin controller.
type VideoController interface {
	// FindAll returns a slice of all videos
	FindAll() []entity.Video
	// Save is a function that saves the video from the Gin context/data
	// passed in after performing validation.
	Save(ctx *gin.Context) error
}

type controller struct {
	service service.VideoService
}

var validate *validator.Validate

// New creates a new VideoController.
func New(service service.VideoService) VideoController {
	validate = validator.New()
	validate.RegisterValidation("is-cool", validators.ValidateCoolTitle)
	return &controller{
		service: service,
	}
}

func (c *controller) FindAll() []entity.Video {
	return c.service.FindAll()
}

func (c *controller) Save(ctx *gin.Context) error {
	var video entity.Video
	err := ctx.ShouldBindJSON(&video)
	if err != nil {
		return err
	}
	err = validate.Struct(video)
	if err != nil {
		return err
	}
	c.service.Save(video)
	return nil
}
