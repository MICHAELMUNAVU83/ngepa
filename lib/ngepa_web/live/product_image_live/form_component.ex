defmodule NgepaWeb.ProductImageLive.FormComponent do
  use NgepaWeb, :live_component

  alias Ngepa.ProductImages

  @impl true
  def update(%{product_image: product_image} = assigns, socket) do
    changeset = ProductImages.change_product_image(product_image)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:uploaded_files, [])
     |> allow_upload(:image, accept: ~w(.jpg .png .jpeg), max_entries: 1)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"product_image" => product_image_params}, socket) do
    changeset =
      socket.assigns.product_image
      |> ProductImages.change_product_image(product_image_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product_image" => product_image_params}, socket) do
    save_product_image(socket, socket.assigns.action, product_image_params)
  end

  defp save_product_image(socket, :edit_product_image, product_image_params) do
    uploaded_files =
      consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
        dest = Path.join([:code.priv_dir(:ngepa), "static", "uploads", Path.basename(path)])

        # The `static/uploads` directory must exist for `File.cp!/2`
        # and MyAppWeb.static_paths/0 should contain uploads to work,.
        File.cp!(path, dest)
        {:ok, "/uploads/" <> Path.basename(dest)}
      end)

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}

    case List.first(uploaded_files) do
      nil ->
        new_product_image_params =
          Map.put(product_image_params, "image_url", socket.assigns.product_image.image_url)

        update_product_image(socket, new_product_image_params)

      _ ->
        full_url = "priv/static" <> List.first(uploaded_files)

        {:ok, data} =
          Cloudex.upload(full_url)

        new_product_image_params =
          Map.put(product_image_params, "image_url", data.secure_url)

        File.rm(full_url)

        update_product_image(socket, new_product_image_params)
    end
  end

  defp update_product_image(socket, params) do
    case ProductImages.update_product_image(
           socket.assigns.product_image,
           params
         ) do
      {:ok, _product_image} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product image updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product_image(socket, :add_product_image, product_image_params) do
    uploaded_files =
      consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
        dest = Path.join([:code.priv_dir(:ngepa), "static", "uploads", Path.basename(path)])

        # The `static/uploads` directory must exist for `File.cp!/2`
        # and MyAppWeb.static_paths/0 should contain uploads to work,.
        File.cp!(path, dest)
        {:ok, "/uploads/" <> Path.basename(dest)}
      end)

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
    full_url = "priv/static" <> List.first(uploaded_files)

    {:ok, data} =
      Cloudex.upload(full_url)

    new_product_image_params =
      Map.put(product_image_params, "image_url", data.secure_url)

    File.rm(full_url)

    case IO.inspect(ProductImages.create_product_image(new_product_image_params)) do
      {:ok, _product_image} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product image created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
