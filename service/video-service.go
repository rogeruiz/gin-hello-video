package service

import "github.com/rogeruiz/gin-hello-world/entity"

// VideoService represents a Gin service.
type VideoService interface {
	// Save is a function which appends a video to the videoService
	// structure. It returns the video being added.
	Save(entity.Video) entity.Video
	// FindAll returns all the videos found in the videoService structure.
	FindAll() []entity.Video
}

type videoService struct {
	videos []entity.Video
}

// New creates a new VideoService.
func New() VideoService {
	return &videoService{}
}

func (s *videoService) Save(video entity.Video) entity.Video {
	s.videos = append(s.videos, video)
	return video
}

func (s *videoService) FindAll() []entity.Video {
	return s.videos
}
