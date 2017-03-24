require 'messenger'
# require 'AfricasTalkingGateway'

class MessengerController < ApplicationController
  def verify
    if params['hub.mode'] == 'subscribe' && params['hub.verify_token'] == ENV['FACEBOOK_TOKEN']
      render plain: params['hub.challenge']
    else
      render status: :bad_request, text: nil
    end
  end

  def updates
    render plain: 'ok'
    Messenger.parse_payload(params).each do |entry|
      entry[:messages].each do |message|
        begin
          sender = message[:sender_id]
          
          cus = Customer.find_or_create_by(external_id: sender)
          step = cus.step.nil? ? '1' : cus.step.to_s

          if message[:type] == 'Postback'
            if

            case step
              when step = '1'
                Messenger.send_message(sender, 'welcome to Team Next')
                Messenger.send_message(sender, 'Some of the Products available')
                
                Messenger.sender_action(sender, 'typing_on')
                sleep 1.5
                collection = Product.all.collect{|p| 
                  {
                    title: p.name, 
                    image_url: "https://26fa0d3c.ngrok.io"+p.avatar.url(:medium), 
                    subtitle: p.name,
                    buttons:[
                      {
                        type: "postback",
                        title: "Order",
                        payload: "order"
                      }
                    ]
                  }
                }
                Messenger.sender_action(sender, 'typing_off')
                Messenger.send_products(sender, collection)

                cus.step = 2
                cus.save!
              when '4'
                Messenger.sender_action(sender, 'typing_on')
                sleep 1.5
                Messenger.sender_action(sender, 'typing_off')

                Messenger.send_message(sender, 'Thank you for choosing Team Next - Fruit Bot')
                Messenger.send_message(sender, 'Here is your purchase receipt')

                Messenger.sender_action(sender, 'typing_on')
                sleep 1.5
                Messenger.sender_action(sender, 'typing_off')

                Messenger.send_receipt(sender)

                options = ['Pay']
                Messenger.send_message(sender.external_id, 'you wanna pay for it now?', options)
              
              else
                Messenger.sender_action(sender, 'typing_on')
                sleep 1.5
                Messenger.sender_action(sender, 'typing_off')
                
                options = ['1', '2', '3']
                Messenger.send_message(sender, 'how many would you want?', options)

                cus.step = 3
                cus.save!
              end
            end
          elsif message[:type] != 'Delivery'
            case step
              when '1'
                Messenger.send_message(sender, 'welcome to Team Next')
                Messenger.send_message(sender, 'Some of the Products available')
                
                Messenger.sender_action(sender, 'typing_on')
                sleep 1.5
                collection = Product.all.collect{|p| 
                  {
                    title: p.name, 
                    image_url: "https://26fa0d3c.ngrok.io"+p.avatar.url(:medium), 
                    subtitle: p.name,
                    buttons:[
                      {
                        type: "postback",
                        title: "Order",
                        payload: "order"
                      }
                    ]
                  }
                }
                Messenger.sender_action(sender, 'typing_off')
                Messenger.send_products(sender, collection)

                cus.step = 2
                cus.save!
              when '2'
                Messenger.send_message(sender, 'this is where you left off last time')
                step_two(cus)
              when '3'
                Messenger.sender_action(sender, 'typing_on')
                sleep 1
                Messenger.send_message(sender, "Thank you for ordering #{message[:text]}")

                cus.step = 4
                cus.save!

                Messenger.sender_action(sender, 'typing_on')
                sleep 1
                Messenger.send_message(sender, "Some of the available vendors")
                collection = Vendor.all.collect{|p| 
                  {
                    title: p.name,
                    subtitle: "located at: #{p.location} and selling at: #{p.price}",
                    buttons:[
                      {
                        type: "postback",
                        title: "Buy",
                        payload: "buy"
                      }
                    ]
                  }
                }
                Messenger.send_products(sender, collection)
              when '4'

            end
            
          end
        rescue Exception => e
          logger.error "Error on handling updates"
        end
      end
    end
  end

  def step_two sender
    Messenger.sender_action(sender.external_id, 'typing_on')
    sleep 1.5
    Messenger.sender_action(sender.external_id, 'typing_off')
    
    options = ['1', '2', '3']
    Messenger.send_message(sender.external_id, 'how many would you want?', options)

    sender.step = 3
    sender.save!
  end

end