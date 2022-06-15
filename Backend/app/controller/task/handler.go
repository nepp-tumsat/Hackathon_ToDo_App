package task

import (
	"net/http"

	"github.com/labstack/echo"
	taskModel "github.com/nepp-tumsat/Hackathon_ToDo_App/app/model/task"
)

type TaskHandler struct {
	model taskModel.TaskModel
}

func NewTaskHandler(u taskModel.TaskModel) *TaskHandler {
	return &TaskHandler{
		model: u,
	}
}
func (u *TaskHandler) CreateTask(c echo.Context) error {
	task := new(taskModel.Task)
	if err := c.Bind(task); err != nil {
		return err
	}
	if task.Task == "" {
		return &echo.HTTPError{
			Code:    http.StatusBadRequest,
			Message: "invalid name",
		}
	}

	u.model.CreateTask(task)

	return c.JSON(http.StatusCreated, task)
}