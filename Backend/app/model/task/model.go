package task

import (
	// "time"

	"gorm.io/gorm"
)

type Task struct {
	ID     int64     `json:"id" gorm:"primaryKey"`
	UserID int64     `json:"userid"`
	Task   string    `json:"task"`
	Exp    int64     `json:"exp"`
	// Due    time.Time `json:"due"`
	Due    string `json:"due"`

	Done   bool      `json:"done"`
}

type TaskModel interface {
	CreateTask(task *Task) *Task
	FindTask(id int64) *Task
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

func (t *taskModel) FindTask(id int64) *Task {
	task := &Task{ID: id}
	t.db.Where(t).First(&task)
	return task
}
