package task

import (
	model "github.com/nepp-tumsat/Hackathon_ToDo_App/app/model/task"
	"gorm.io/gorm"
)

func InitializeTaskHandler(db *gorm.DB) *TaskHandler {
	taskModel := model.NewTaskModel(db)
	userHandler := NewTaskHandler(taskModel)
	return userHandler
}
