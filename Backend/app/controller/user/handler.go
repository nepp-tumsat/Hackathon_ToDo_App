package user

import (
	"net/http"
	"strconv"

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

func (u *UserHandler) GetUser(c echo.Context) error {
	paramID := c.Param("id")
	userid, err := strconv.Atoi(paramID)
	if err != nil {
		panic(err)
	}
	user := u.model.FindUser(userid)

	return c.JSON(http.StatusOK, user)
}

func (u *UserHandler) UpdateUser(c echo.Context) error {

	user := new(userModel.User)
	if err := c.Bind(user); err != nil {
		return err
	}

	new_user := u.model.FindUser(user.ID)
	user.Level = new_user.Level

	updated_user := u.model.UpdateUser(user)

	return c.JSON(http.StatusOK, updated_user)
}
