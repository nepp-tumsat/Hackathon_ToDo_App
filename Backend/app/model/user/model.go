package user

import (
	taskModel "github.com/nepp-tumsat/Hackathon_ToDo_App/Backend/app/model/task"
	"gorm.io/gorm"
)

type User struct {
	ID    int              `json:"id" gorm:"primaryKey"`
	Name  string           `json:"name"`
	Level int              `json:"level"`
	Task  []taskModel.Task `gorm:"foreignKey:ID`
}

type UserModel interface {
	CreateUser(user *User) *User
	FindUser(id int) *User
	UpdateUser(user *User) *User
}

type userModel struct {
	db *gorm.DB
}

func NewUserModel(db *gorm.DB) *userModel {
	return &userModel{
		db: db,
	}
}

func (u *userModel) CreateUser(user *User) *User {
	if err := u.db.Create(user).Error; err != nil {
		return nil
	}
	return user
}

func (u *userModel) FindUser(id int) *User {
	user := &User{ID: id}
	u.db.Where(u).First(&user)
	return user
}

func (u *userModel) UpdateUser(user *User) *User {
	id := user.ID
	update_user := &User{ID: id}
	u.db.First(update_user)
	update_user.Name = user.Name
	update_user.Level = user.Level
	if err := u.db.Save(update_user).Error; err != nil {
		return nil
	}
	return update_user
}
