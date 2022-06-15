package user

import (
	"net/http"

	"github.com/labstack/echo"
	userModel "github.com/nepp-tumsat/Hackathon_ToDo_App/app/model/user"
)

type UserHandler struct {
	model userModel.UserModel
}

func NewUserHandler(u userModel.UserModel) *UserHandler {
	return &UserHandler{
		model: u,
	}
}
func (u *UserHandler) Signup(c echo.Context) error {
	user := new(userModel.User)
	if err := c.Bind(user); err != nil {
		return err
	}
	user.Level = 0
	if user.Name == "" {
		return &echo.HTTPError{
			Code:    http.StatusBadRequest,
			Message: "invalid name",
		}
	}

	u.model.CreateUser(user)

	return c.JSON(http.StatusCreated, user)
}
