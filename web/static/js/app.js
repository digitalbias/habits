import React from "react"
import ReactDOM from "react-dom"
import App from "./components/App"

const habitContainer = document.getElementById("habit-container")
if (habitContainer) {
  const habits = JSON.parse(habitContainer.dataset.habits)
  const [_empty, year, month, day] = window.location.pathname.split("/")
  const date = new Date(
    parseInt(year),
    parseInt(month) - 1,
    parseInt(day)
  )

  ReactDOM.render(
    <App date={date} data={habits} />,
    habitContainer
  )
}
