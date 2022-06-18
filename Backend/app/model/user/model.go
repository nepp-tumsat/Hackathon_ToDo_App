package user

import (
	"gorm.io/gorm"
)

type User struct {
	ID    int     `json:"id" gorm:"primaryKey"`
	Name  string  `json:"name"`
	Level float64 `json:"level"`
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
	if err := u.db.Save(user).Error; err != nil {
		return nil
	}
	return user
}
