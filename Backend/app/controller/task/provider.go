package task

import (
	model "github.com/nepp-tumsat/Hackathon_ToDo_App/Backend/app/model/task"
	umodel "github.com/nepp-tumsat/Hackathon_ToDo_App/Backend/app/model/user"
	"gorm.io/gorm"
)

func InitializeTaskHandler(db *gorm.DB) *TaskHandler {
	taskModel := model.NewTaskModel(db)
	userModel := umodel.NewUserModel(db)
	taskHandler := NewTaskHandler(taskModel, userModel)
	return taskHandler
}
