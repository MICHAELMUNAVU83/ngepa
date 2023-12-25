defmodule Ngepa.Notify do
  alias Ngepa.Accounts.UserNotifier

  def api_url(), do: "https://api.tiaraconnect.io/api/messaging/sendsms"

  def sms_headers(),
    do: [
      {
        "Content-Type",
        "application/json"
      },
      {
        "Authorization",
        "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyOTAiLCJvaWQiOjI5MCwidWlkIjoiYWUzMGRjZTItMjIzYi00ODUzLWJmMDItNDE5ZWI2MzMzY2Y5IiwiYXBpZCI6MTgzLCJpYXQiOjE2OTM1OTAzNDksImV4cCI6MjAzMzU5MDM0OX0.mG9d0tTkmx49OQKMKQFYKnIQMHFQEIckHBnGe5jTjg3fU95aHLxrtouqsPGr7Yi3GKFt674_ImiLtJavAa4OIw"
      }
    ]

  def send_bulk_sms(numbers_list, message) do
    sms_url = api_url()
    sms_headers = sms_headers()

    numbers_list
    |> Enum.map(fn x ->
      sms_body =
        %{
          "from" => "TIARACONECT",
          "to" => x,
          "message" => message,
          "refId" => "09wiwu088e"
        }
        |> Jason.encode!()

      HTTPoison.post(sms_url, sms_body, sms_headers)
    end)
  end

  def send_ticket_as_sms(number, name, ticket_link, game) do
    sms_url = api_url()
    sms_headers = sms_headers()

    sms_body =
      %{
        "from" => "TIARACONECT",
        "to" => number,
        "message" =>
          "Hello #{name} ,Thanks for purchasing your ticket for #{game}. We look forward to seeing you , download your ticket at #{ticket_link}",
        "refId" => "09wiwu088e"
      }
      |> Jason.encode!()

    HTTPoison.post(sms_url, sms_body, sms_headers)
  end

  def send_ticket_as_email(email, game, name, ticket_link) do
    UserNotifier.deliver(
      email,
      "#{game} Ticket",
      "Hello #{name} ,Thanks for purchasing your ticket for #{game}. We look forward to seeing you , download your ticket at #{ticket_link}"
    )
  end

  def send_book_order_as_sms(number, name, order_link) do
    sms_url = api_url()
    sms_headers = sms_headers()

    sms_body =
      %{
        "from" => "TIARACONECT",
        "to" => number,
        "message" =>
          "Hello #{name} ,Thanks for purchasing Mwamba at 45 Book. We will be reaching out to you soon , you can track your order status here  #{order_link}",
        "refId" => "09wiwu088e"
      }
      |> Jason.encode!()

    HTTPoison.post(sms_url, sms_body, sms_headers)
  end

  def send_book_order_as_email(email, name, order_link) do
    UserNotifier.deliver(
      email,
      "Mwamba at 45 Book Order",
      "Hello #{name} , Thanks for purchasing Mwamba at 45 Book.  We will be reaching out to you soon , you can track your order status here  #{order_link}"
    )
  end

  def send_product_order_as_sms(number, name, product_name, quantity, location, order_link) do
    sms_url = api_url()
    sms_headers = sms_headers()

    sms_body =
      %{
        "from" => "TIARACONECT",
        "to" => number,
        "message" =>
          "Hello #{name} ,Thanks for purchasing #{quantity} #{product_name} to be delivered at #{location}. We will be reaching out to you soon , you can track your order status here  #{order_link}",
        "refId" => "09wiwu088e"
      }
      |> Jason.encode!()

    HTTPoison.post(sms_url, sms_body, sms_headers)
  end

  def send_product_order_as_email(email, name, product_name, quantity, location, order_link) do
    UserNotifier.deliver(
      email,
      "#{product_name} Order - Mwamba RFC",
      "Hello #{name} ,Thanks for purchasing #{quantity} #{product_name} to be delivered at #{location}. We will be reaching out to you soon , you can track your order status here  #{order_link}"
    )
  end

  def send_order_message_as_sms(number, message, name, order_link) do
    sms_url = api_url()
    sms_headers = sms_headers()

    sms_body =
      %{
        "from" => "TIARACONECT",
        "to" => number,
        "message" =>
          "Hello  #{name} , This is a message regarding your order. #{message} . You can track your order here #{order_link}",
        "refId" => "09wiwu088e"
      }
      |> Jason.encode!()

    HTTPoison.post(sms_url, sms_body, sms_headers)
  end

  def send_order_message_as_email(email, message, name, order_link) do
    UserNotifier.deliver(
      email,
      "Order Update",
      "Hello  #{name} , This is a message regarding your order. #{message} . You can track your order here #{order_link}"
    )
  end

  def send_membership_information_as_sms(number, name, membership_number, membership_link) do
    sms_url = api_url()
    sms_headers = sms_headers()

    sms_body =
      %{
        "from" => "TIARACONECT",
        "to" => number,
        "message" =>
          "Hello  #{name} , Welcome to the premium Mwamba Kulabu Membership . This is your Membership Number ,#{membership_number} . You can download your card #{membership_link} as you wait for the delivery of your physical card",
        "refId" => "09wiwu088e"
      }
      |> Jason.encode!()

    HTTPoison.post(sms_url, sms_body, sms_headers)
  end

  def send_membership_information_as_email(email, name, membership_number, membership_link) do
    UserNotifier.deliver(
      email,
      "Kulabu Membership",
      "Hello  #{name} , Welcome to the premium Mwamba Kulabu Membership . This is your Membership Number ,#{membership_number} . You can download your card #{membership_link} as you wait for the delivery of your physical card"
    )
  end
end
