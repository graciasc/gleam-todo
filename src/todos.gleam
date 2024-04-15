import lustre
import lustre/element
import lustre/element/html
import gleam/list
import lustre/event
import gleam/io

pub type Todo  {
  Todo(name: String)
}

pub type Model = List(Todo)

pub type Msg {
  AddTodo
  RemoveTodo
}

// pub type Todos = List(Todo)

pub fn init(_flag) -> Model {
  []
}

pub fn main() {
  // model
  // view
  // controller
  lustre.simple(init, update, view)
}

pub fn view(model: Model) -> element.Element(Msg) { 
  // array of objects
  // using lustre element I would have to build seperate elements
  // let todos: Todo = Todo("New Todo")
   html.div([], [
     html.h1([], [element.text("To Do App")]),
     html.button([event.on_click(AddTodo)], [
      element.text("+")
     ]),
     // element.text(todos),
      html.button([event.on_click(RemoveTodo)], [ 
        element.text("-")
     ])
  ])
}

pub fn update(model: Model, msg: Msg) -> Model { 
  case msg {
    AddTodo ->  list.append(model, [Todo("New Todo")])
    RemoveTodo -> list.filter(model, fn(x) { x == Todo("New Todo")}) 
  }
}
