defmodule Ngepa.TransactionAlgorithim do
  def code_reference_for_book_order(phone_number) do
    timestamp =
      Timex.local()
      |> Timex.format!("{YYYY}{0M}{0D}{h24}{m}{s}")

    first_six_numbers = String.slice(phone_number, 0..5)
    last_six_numbers = String.slice(phone_number, 6..12)

    first_four_timestamp_numbers = String.slice(timestamp, 0..3)
    last_ten_timestamp_numbers = String.slice(timestamp, 4..14)

    first_four_timestamp_numbers <>
      last_six_numbers <> last_ten_timestamp_numbers <> first_six_numbers
  end

  @spec decode_number_from_book_order(binary()) :: binary()
  def decode_number_from_book_order(order) do
    last_six_numbers = String.slice(order, 4..9)

    first_six_numbers = String.slice(order, 20..25)

    first_six_numbers <> last_six_numbers
  end

  def code_reference_for_membership(phone_number) do
    timestamp =
      Timex.local()
      |> Timex.format!("{YYYY}{0M}{0D}{h24}{m}{s}")

    first_six_numbers = String.slice(phone_number, 0..5)
    last_six_numbers = String.slice(phone_number, 6..12)

    first_four_timestamp_numbers = String.slice(timestamp, 0..3)
    last_ten_timestamp_numbers = String.slice(timestamp, 4..14)

    first_four_timestamp_numbers <>
      last_six_numbers <> last_ten_timestamp_numbers <> first_six_numbers
  end

  def decode_number_from_membership(membership) do
    last_six_numbers = String.slice(membership, 4..9)

    first_six_numbers = String.slice(membership, 20..25)

    first_six_numbers <> last_six_numbers
  end

  def code_reference_for_ticket(fixture_id, phone_number) do
    timestamp =
      Timex.local()
      |> Timex.format!("{YYYY}{0M}{0D}{h24}{m}{s}")

    first_six_numbers = String.slice(phone_number, 0..5)
    last_six_numbers = String.slice(phone_number, 6..12)

    first_four_timestamp_numbers = String.slice(timestamp, 0..3)
    last_ten_timestamp_numbers = String.slice(timestamp, 4..14)

    fixture_id <>
      first_four_timestamp_numbers <>
      last_six_numbers <> last_ten_timestamp_numbers <> first_six_numbers
  end

  def decode_fixture_id_from_ticket(ticket) do
    case String.length(ticket) == 27 do
      true ->
        String.slice(ticket, 0..0)

      false ->
        String.slice(ticket, 0..(String.length(ticket) - 27))
    end
  end

  def decode_phone_number_from_ticket(ticket) do
    transaction_ref_without_fixture_id =
      case String.length(ticket) == 27 do
        true ->
          String.slice(ticket, 1..26)

        false ->
          String.slice(ticket, (String.length(ticket) - 26)..(String.length(ticket) - 1))
      end

    last_six_numbers = String.slice(transaction_ref_without_fixture_id, 4..9)

    first_six_numbers = String.slice(transaction_ref_without_fixture_id, 20..25)

    first_six_numbers <> last_six_numbers
  end

  def code_reference_for_product_order(product_id, phone_number) do
    timestamp =
      Timex.local()
      |> Timex.format!("{YYYY}{0M}{0D}{h24}{m}{s}")

    first_six_numbers = String.slice(phone_number, 0..5)
    last_six_numbers = String.slice(phone_number, 6..12)

    first_four_timestamp_numbers = String.slice(timestamp, 0..3)
    last_ten_timestamp_numbers = String.slice(timestamp, 4..14)

    product_id <>
      first_four_timestamp_numbers <>
      last_six_numbers <> last_ten_timestamp_numbers <> first_six_numbers
  end

  def decode_product_id_from_product_order(product_order) do
    case String.length(product_order) == 27 do
      true ->
        String.slice(product_order, 0..0)

      false ->
        String.slice(product_order, 0..(String.length(product_order) - 27))
    end
  end

  def decode_phone_number_from_product_order(product_order) do
    transaction_ref_without_product_id =
      case String.length(product_order) == 27 do
        true ->
          String.slice(product_order, 1..26)

        false ->
          String.slice(
            product_order,
            (String.length(product_order) - 26)..(String.length(product_order) - 1)
          )
      end

    last_six_numbers = String.slice(transaction_ref_without_product_id, 4..9)

    first_six_numbers = String.slice(transaction_ref_without_product_id, 20..25)

    first_six_numbers <> last_six_numbers
  end
end
