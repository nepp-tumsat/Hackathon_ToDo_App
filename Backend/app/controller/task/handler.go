package task

import (
	"net/http"
	"strconv"

	"github.com/labstack/echo"
	taskModel "github.com/nepp-tumsat/Hackathon_ToDo_App/Backend/app/model/task"
	userModel "github.com/nepp-tumsat/Hackathon_ToDo_App/Backend/app/model/user"
)

type TaskHandler struct {
	model  taskModel.TaskModel
	umodel userModel.UserModel
}

func NewTaskHandler(t taskModel.TaskModel, u userModel.UserModel) *TaskHandler {
	return &TaskHandler{
		model:  t,
		umodel: u,
	}
}
func (t *TaskHandler) CreateTask(c echo.Context) error {
	task := new(taskModel.Task)
	// task.Task = c.FormValue("task")
	// userid := c.FormValue("userid")
	// exp := c.FormValue("exp")
	// task.UserID, _ = strconv.Atoi(userid)
	// task.Exp, _ = strconv.Atoi(exp)
	// task.Due = c.FormValue("due")

	if err := c.Bind(task); err != nil {
		return err
	}

	t.model.CreateTask(task)

	return c.JSON(http.StatusCreated, task)
}

func (t *TaskHandler) GetAllTask(c echo.Context) error {
	paramID := c.Param("id")
	userID, _ := strconv.Atoi(paramID)

	tasks := t.model.GetTasks(userID)
	return c.JSON(http.StatusOK, tasks)
}

func (t *TaskHandler) GetTask(c echo.Context) error {
	paramID := c.Param("id")
	taskID, _ := strconv.Atoi(paramID)

	task := t.model.GetTask(taskID)

	return c.JSON(http.StatusOK, task)
}

func (t *TaskHandler) CompleteTask(c echo.Context) error {
	paramID := c.Param("id")
	taskID, _ := strconv.Atoi(paramID)

	task := t.model.GetTask(taskID)
	if task.Done == true {
		return &echo.HTTPError{
			Code:    http.StatusBadRequest,
			Message: "完了済みです",
		}
	}
	task.Done = true
	t.model.UpdateTask(task)

	user := t.umodel.FindUser(task.UserID)
	user.Level += task.Exp

	t.umodel.UpdateUser(user)

	return c.JSON(http.StatusCreated, user)
}

func (t *TaskHandler) DeleteTask(c echo.Context) error {
	paramID := c.Param("id")
	taskID, _ := strconv.Atoi(paramID)

	t.model.DeleteTask(taskID)

	return c.JSON(http.StatusOK, nil)
}
