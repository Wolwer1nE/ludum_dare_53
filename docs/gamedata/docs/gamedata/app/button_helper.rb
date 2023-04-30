class ButtonHelper


  BUTTON_SPRITES = {
    active: 'green',
    generic: 'gray',
    danger: 'red'
  }
  BUTTON_CONFIG = {
    w: 80,
    h: 40
  }


  def self.rect(button)
    [button.x, button.y, button.width, button.height]
  end

  def self.draw(args, button)
    args.outputs.sprites << {
      x: button.x,
      y: button.y,
      path: button_for_state(button.state),
      w: button.width || BUTTON_CONFIG[:w],
      h: button.height || BUTTON_CONFIG[:h]
    }

    args.outputs.labels << {
      x: button.x+8, y: button.y+button.height*3/4.0+2, text: button.text,
    }.merge(DEFAULT_LABEL_CONFIG)
  end


  def self.button_for_state(state)
    "/sprites/ui/buttons/#{BUTTON_SPRITES[state]}.png"
  end
end