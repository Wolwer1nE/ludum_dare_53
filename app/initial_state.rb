# frozen_string_literal: true
module InitialState
  start_x = 20
  x_delta = 72
  start_y = 620
  y_delta = -100
  COURIERS = [
    {
      name: 'Greg',
      price: 0,
      status: :available,
      x: start_x,
      y: start_y
    },
    {
      name: 'Dr01dy',
      price: 20,
      status: :available,
      x: start_x+x_delta,
      y: start_y,
      animation_config: {
        available: {
          name: 'idle',
          count: 4},
        on_mission: {
          name: 'walk',
          count: 4},
        not_available: {
          name: 'idle',
          count: 4}
      }
    },
    {
      name: 'Harley',
      price: 25,
      status: :not_available,
      x: start_x+2*x_delta,
      y: start_y,
    },
    {
      name: 'Jimmy',
      price: 35,
      status: :not_available,
      x: start_x,
      y: start_y + y_delta
    },
    {
      name: 'Sue',
      price: 45,
      status: :not_available,
      x: start_x + x_delta,
      y: start_y + y_delta
    },
    {
      name: 'July',
      price: 45,
      status: :not_available,
      x: start_x + 2*x_delta,
      y: start_y + y_delta
    },
    {
      name: 'Robby',
      price: 80,
      status: :not_available,
      x: start_x,
      y: start_y + 2*y_delta
    },
    {
      name: 'Melinda',
      price: 200,
      status: :not_available,
      x: start_x + x_delta,
      y: start_y+2*y_delta,
    },
    {
      name: 'Shadow',
      price: 320,
      status: :not_available,
      x: start_x + 2*x_delta,
      y: start_y+2*y_delta,
    }
  ]
end
