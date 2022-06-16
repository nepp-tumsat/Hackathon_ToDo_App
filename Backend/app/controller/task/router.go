package task

import (
	"github.com/labstack/echo"
)

func TaskRoute(e *echo.Echo, handler *TaskHandler) {
	e.POST("/tasks", handler.CreateTask)
	e.PATCH("/tasks/:id", handler.CompleteTask)
}
