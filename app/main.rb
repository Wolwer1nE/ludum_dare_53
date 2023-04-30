require 'app/config.rb'
require 'app/initial_state.rb'
require '/app/button_helper.rb'
require '/app/courier_helper.rb'

def tick args
  setup args

  overlay_config = {
    x: 0,
    y: 0,
    w: args.grid.w,
    h: args.grid.h,
    path: "sprites/ui/overlay.png",
    a: 25

  }
  args.outputs.sprites << overlay_config
  if args.state.drag == :finished
    args.state.selected_courier = args.geometry.find_intersect_rect(args.inputs.mouse,
                                                                      args.state.couriers.filter{|x|x.status == :available})
  end

  draw_ui args
  handle_input args

end
def setup(args)
  args.state.drag ||= :finished
  args.state.balance = 50
  # args.outputs.sounds << "sounds/theme.ogg"
  # args.audio[:bg_music] = {inputs: "sounds/theme.ogg", looping: true}
  args.state.couriers ||= InitialState::COURIERS
  buttons = []

  args.state.couriers.each do |courier|
    button_config = {
      x: courier.x - 6,
      y: courier.y - 34,
      state: courier.status == :available ? :generic : :active,
      text: courier.status == :available ? "Assign" : "$#{courier.price}",
      width: 58, height: 32,
      type: :unlock_courier,
      courier_name: courier.name
    }
    buttons.push(button_config)
  end
  args.state.ui_buttons = buttons
end
def draw_layout(args)
  args.outputs.labels << DEFAULT_LABEL_CONFIG.merge({
    x: 20, y: 720, text: 'Couriers',
      size_px: 28,
  })
end

def draw_ui(args)

  draw_layout args

  args.state.ui_buttons.each do |button|
    ButtonHelper.draw(args, button)
    if args.inputs.mouse.click
      if args.inputs.mouse.click.point.inside_rect? ButtonHelper.rect(button)
        args.state.clicked_button = button
      end

    end
  end
  args.state.couriers.each do |courier|
    CourierHelper.draw(args, courier)
  end


end


def handle_input(args)
  selected_courier = args.state.selected_courier
  if args.inputs.mouse.click && selected_courier && args.state.drag == :finished
    args.state.drag = :started
    args.state.mouse_point_inside_square = {
      x: args.inputs.mouse.x - selected_courier.x,
      y: args.inputs.mouse.y - selected_courier.y,
    }
  elsif args.inputs.mouse.held && (args.state.drag == :started || args.state.drag == :ongoing)
    args.state.drag = :ongoing
    selected_courier.x = args.inputs.mouse.x - args.state.mouse_point_inside_square.x
    selected_courier.y = args.inputs.mouse.y - args.state.mouse_point_inside_square.y
  elsif args.inputs.mouse.up && args.state.drag == :ongoing
    args.state.selected_courier = nil
    args.state.drag = :finished
  end


  button = args.state.clicked_button
  return unless button

  case button.type
    when :unlock_courier
      couriers = args.state.couriers
      couriers.map! do |courier|
        if courier.name == button.courier_name
          courier.status = :available
        end
        courier
      end
      args.state.couriers = couriers
    else
      args.outputs.labels << [175 + 150, 610 - 50, args.state.clicked_button.text,  -2]
    end
  # dev mode
  if args.inputs.keyboard.key_down.control
    $gtk.reset
  end



end



