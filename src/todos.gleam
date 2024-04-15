import lustre
import lustre/element
// import lustre/attribute
import lustre/element/html
import lustre/event

pub fn main() {
  // model
  // view
  view()
  // controller
}

pub fn view() { 
  // array of objects
  let todos = []
  // using lustre element I would have to build seperate elements
 lustre.element(
   html.div([], [
     html.h1([], [element.text("To Do App")]),
     html.button([event.on_click(add_todo)], [
      element.text("+")
     ]),
     // element.text(todos),
      html.button([event.on_click(remove_todo)], [ 
        element.text("-")
     ])
   ]))
}

// adds to the bottom
pub fn add_todo() {}
// removes from the bottom
pub fn remove_todo() {}

