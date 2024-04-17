import lustre
import lustre/element.{}
import lustre/element/html.{div, p, h1, h4, button, text, input }
import gleam/list.{append, filter}
import lustre/event.{on_click, on_input}
import gleam/io
import lustre/attribute.{placeholder, value, style}

pub type Todo  {
  Todo(name: String)
}

pub type Model {
  Model(value: String, todos: List(Todo) )
}

pub type Msg {
  AddTodo(value: Todo)
  UserUpdatedMessage(value: String)
  RemoveTodo(value: Todo)
  ClearTodos()
}

pub fn init(_flag) -> Model {
  Model(value: "", todos: [])
}

pub fn main() {
  lustre.simple(init, update, view)
}

pub fn view(model: Model) -> element.Element(Msg) { 
  div([], [
    h1([], [text("To Do App")]),
    input([
      attribute.value(model.value),
      event.on_input(UserUpdatedMessage),
    ]),
    button([on_click(AddTodo(Todo(model.value)))], [
      text("+")
    ]),

    button([on_click(ClearTodos)], [ 
      text("-")
    ]),

    div(
    [],
    list.map(model.todos, fn(note) { 
      div([attribute.style([#("display", "flex"), #("color", "red")])], [
        h4([attribute.style([#("margin", "0"), #("padding", "4px")])], [text(note.name), 
          button([
            on_click(RemoveTodo(note)), 
            attribute.style([#("margin-left", "4px")])], [ 
            text("-")
          ])
        ]),
      ])
    })
  ),
  ])
}

pub fn update(model: Model, msg: Msg) -> Model { 
  io.debug(model)
  case msg {

    UserUpdatedMessage(value) -> {
      Model(..model, value: value)
    }

    AddTodo(value) -> { 
      io.debug(value)
      Model(value: "", todos: append(model.todos, [ value ]))
    }

    RemoveTodo(value) -> { 
      Model(value: "", todos: filter(model.todos, fn(x) { x != value}) )
    }

    ClearTodos -> Model(value: "", todos: [])

  }
}
