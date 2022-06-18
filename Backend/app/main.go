package main

import (

	// "fmt"
	"log"
	"net/http"

	// "os"

	"github.com/nepp-tumsat/Hackathon_ToDo_App/app/controller"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

func main() {
	dsn := "root:password@tcp(localhost:3306)/todo_db?charset=utf8mb4&parseTime=True&loc=Local"
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
	// db, err := connectDB()
	if err != nil {
		log.Fatal(err)
		return
	}

	server := controller.InitalizeServer(db)

	if err := server.Start("localhost:8080"); err != http.ErrServerClosed {
		log.Fatal(err)
	}
}

// func connectDB() (*gorm.DB, error) {
// 	dbConf := newDBConfig()
// 	return gorm.Open(mysql.Open(dbConf.dsn()), &gorm.Config{})
// }

// type dbConfig struct {
// 	Driver   string
// 	User     string
// 	Password string
// 	Host     string
// 	Port     string
// 	Database string
// }

// func newDBConfig() dbConfig {
// 	return dbConfig{
// 		User:     os.Getenv("MYSQL_USER"),
// 		Password: os.Getenv("MYSQL_PASSWORD"),
// 		Host:     os.Getenv("MYSQL_HOST"),
// 		Port:     os.Getenv("MYSQL_PORT"),
// 		Database: os.Getenv("MYSQL_DATABASE"),
// 	}
// }

// func (c *dbConfig) dsn() string {
// 	return fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local", c.User, c.Password, c.Host, c.Port, c.Database)
// }
