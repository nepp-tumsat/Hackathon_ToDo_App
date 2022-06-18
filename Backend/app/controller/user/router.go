package user

import (
	"github.com/labstack/echo"
)

func UserRoute(e *echo.Echo, handler *UserHandler) {
	e.POST("/users", handler.Signup)
	e.GET("/users/:id", handler.GetUser)
}
