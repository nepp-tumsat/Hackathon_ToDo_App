package task

import (
	"github.com/labstack/echo"
)

func TaskRoute(e *echo.Echo, handler *TaskHandler) {
	e.POST("/tasks", handler.CreateTask)
	e.GET("/users/:id/tasks", handler.GetAllTask)
	e.GET("/tasks/:id", handler.GetTask)
	e.PATCH("/tasks/:id", handler.CompleteTask)
	e.DELETE("/tasks/:id", handler.DeleteTask)
}
