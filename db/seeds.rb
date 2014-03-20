if Rails.env.development?
  ['Arduino', 'Leap Motion', 'Mini Printer', 'Raspberry Pi', 'Webcam'].each do |hardware|
    Hardware.create name: hardware
  end
end