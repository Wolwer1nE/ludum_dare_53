require 'app/config.rb'
require 'app/initial_state.rb'
require '/app/button_helper.rb'
require '/app/courier_helper.rb'

def tick args

  args.state.couriers ||= InitialState::COURIERS
  buttons =    [{x: 0, y: 0, width: 80, height: 40, state: :active, text: 'Hello'},
                {x: 0, y: 40, width: 80, height: 40, state: :danger, text: 'No'}]
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

  draw_ui args
  handle_input args

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


  if args.inputs.keyboard.key_down.control && args.inputs.keyboard.key_down.r
    $gtk.reset
  end
end



