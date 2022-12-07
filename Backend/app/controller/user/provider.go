package user

import (
	model "github.com/nepp-tumsat/Hackathon_ToDo_App/Backend/app/model/user"
	"gorm.io/gorm"
)

func InitializeUserHandler(db *gorm.DB) *UserHandler {
	userModel := model.NewUserModel(db)
	userHandler := NewUserHandler(userModel)
	return userHandler
}
