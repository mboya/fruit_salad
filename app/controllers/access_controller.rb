require 'messenger'

class AccessController < ApplicationController
  def verify
    render plain: 'ok'
  end

  def updates
    render plain: 'ok'
    # logger.info "#{params.to_json}"

    js = params
    js[:bill_reference]

    Rails.logger.info "#{js[:bill_reference]}"

    cus = Customer.first
    cus.external_id

    Messenger.send_message(cus.external_id, "Your payment reference #{js[:bill_reference]} has been posted")
  end
end
