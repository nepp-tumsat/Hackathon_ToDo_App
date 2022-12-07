package main

import (
	"log"
	"net/http"
	"strconv"
	"time"

	"github.com/nepp-tumsat/Hackathon_ToDo_App/Backend/app/controller"
	tmodel "github.com/nepp-tumsat/Hackathon_ToDo_App/Backend/app/model/task"
	umodel "github.com/nepp-tumsat/Hackathon_ToDo_App/Backend/app/model/user"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

func ConnectDB(dbOpen gorm.Dialector, config gorm.Option, count uint64) (db *gorm.DB, err error) {
	for count > 1 {
		db, err = gorm.Open(dbOpen, config)
		time.Sleep(time.Second * 2)
		count--
		log.Println("retry count:" + strconv.FormatUint(count, 10))
	}

	db.Migrator().CreateTable(umodel.User{})
	db.Migrator().CreateTable(tmodel.Task{})

	return db, err
}

func main() {
	dsn := "user:password@tcp(db:3306)/todo_db?charset=utf8mb4&parseTime=True&loc=Local"

	dbOpen := mysql.Open(dsn)
	config := &gorm.Config{}

	db, err := ConnectDB(dbOpen, config, 10)
	if err != nil {
		panic(err)
	}

	server := controller.InitalizeServer(db)

	if err := server.Start("0.0.0.0:8080"); err != http.ErrServerClosed {
		log.Fatal(err)
	}
}
