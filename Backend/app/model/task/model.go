package task

import (
	// "time"

	"gorm.io/gorm"
)

type Task struct {
	ID     int    `json:"id" gorm:"primaryKey"`
	UserID int    `json:"userid"`
	Task   string `json:"task"`
	Exp    int    `json:"exp"`
	// Due    time.Time `json:"due"`
	Due string `json:"due"`

	Done bool `json:"done"`
}

type TaskModel interface {
	CreateTask(task *Task) *Task
	GetTask(id int) *Task
	GetTasks(userID int) []*Task
	UpdateTask(task *Task) *Task
}

type taskModel struct {
	db *gorm.DB
}

func NewTaskModel(db *gorm.DB) *taskModel {
	return &taskModel{
		db: db,
	}
}

func (t *taskModel) CreateTask(task *Task) *Task {
	if err := t.db.Create(task).Error; err != nil {
		return nil
	}
	return task
}

func (t *taskModel) GetTask(id int) *Task {
	task := &Task{ID: id}
	t.db.Where(t).First(&task)
	return task
}

func (t *taskModel) GetTasks(userID int) []*Task {
	var tasks []*Task
	t.db.Where("user_id = ?", userID).Find(tasks)
	return tasks
}

func (t *taskModel) UpdateTask(task *Task) *Task {
	if err := t.db.Save(task).Error; err != nil {
		return nil
	}
	return task
}
