import lustre
import lustre/element.{}
import lustre/element/html.{div, p, h1, h4, button, text, input }
import gleam/list.{append, filter, map}
import lustre/event.{on_click, on_input}
import gleam/io. { debug }
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
      value(model.value),
      on_input(UserUpdatedMessage),
    ]),
    button([on_click(AddTodo(Todo(model.value)))], [
      text("+")
    ]),

    button([on_click(ClearTodos)], [ 
      text("-")
    ]),

    div(
    [],
    map(model.todos, fn(note) { 
      div([style([#("display", "flex"), #("color", "red")])], [
        h4([style([#("margin", "0"), #("padding", "4px")])], [text(note.name), 
          button([
            on_click(RemoveTodo(note)), 
            style([#("margin-left", "4px")])], [ 
            text("-")
          ])
        ]),
      ])
    })
  ),
  ])
}

pub fn update(model: Model, msg: Msg) -> Model { 
  debug(model)
  case msg {

    UserUpdatedMessage(value) -> {
      Model(..model, value: value)
    }

    AddTodo(value) -> { 
      debug(value)
      Model(value: "", todos: append(model.todos, [ value ]))
    }

    RemoveTodo(value) -> { 
      Model(value: "", todos: filter(model.todos, fn(x) { x != value}) )
    }

    ClearTodos -> Model(value: "", todos: [])

  }
}
