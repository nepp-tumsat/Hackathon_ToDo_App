package controller

import (
	"net/http"

	"github.com/labstack/echo"
	"github.com/nepp-tumsat/Hackathon_ToDo_App/app/controller/task"
	"github.com/nepp-tumsat/Hackathon_ToDo_App/app/controller/user"
	"gorm.io/gorm"
)

func InitalizeServer(db *gorm.DB) *echo.Echo {

	e := echo.New()
	handlers := initializeHandlers(db)

	user.UserRoute(e, handlers.User)
	task.TaskRoute(e, handlers.Task)
	e.GET("/server-health", healthCheck)
	return e
}

func healthCheck(ctx echo.Context) error {
	return ctx.String(http.StatusOK, "OK")
}

type handlers struct {
	User *user.UserHandler
	Task *task.TaskHandler
}

func initializeHandlers(db *gorm.DB) handlers {
	return handlers{
		User: user.InitializeUserHandler(db),
		Task: task.InitializeTaskHandler(db),
	}
}
