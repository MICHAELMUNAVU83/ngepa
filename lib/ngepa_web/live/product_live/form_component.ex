defmodule NgepaWeb.ProductLive.FormComponent do
  use NgepaWeb, :live_component

  alias Ngepa.Products

  @impl true
  def update(%{product: product} = assigns, socket) do
    changeset = Products.change_product(product)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:uploaded_files, [])
     |> allow_upload(:image, accept: ~w(.jpg .png .jpeg), max_entries: 1)
     |> assign(:changeset, changeset)}
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :image, ref)}
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Products.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  defp save_product(socket, :edit, product_params) do
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
        new_product_params =
          Map.put(product_params, "primary_image", socket.assigns.product.primary_image)

        update_product(socket, new_product_params)

      _ ->
        full_url = "priv/static" <> List.first(uploaded_files)

        {:ok, data} =
          Cloudex.upload(full_url)

        new_product_params =
          Map.put(product_params, "primary_image", data.secure_url)

        File.rm(full_url)
        update_product(socket, new_product_params)
    end
  end

  defp update_product(socket, params) do
    case Products.update_product(socket.assigns.product, params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product(socket, :new, product_params) do
    uploaded_files =
      consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
        IO.inspect(path)
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

    new_product_params =
      Map.put(product_params, "primary_image", data.secure_url)

    File.rm(full_url)

    case Products.create_product(new_product_params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
