defmodule NgepaWeb.Router do
  use NgepaWeb, :router

  import NgepaWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {NgepaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NgepaWeb do
    pipe_through :browser
    live "/", PageLive.Index, :index
    live "/collection/:collection_name", CollectionLive.Index, :index
    live "/shop/:product_name", ShopLive.Index, :index
    live "/shop/:product_name/buy", ShopLive.Index, :buy
    live "/shop/:product_name/:product_order_id/success", ShopLive.Index, :success
    live "/shop/:product_name/failed", ShopLive.Index, :failed
    live "/product_orders/:id", ProductOrderLive.Show, :show
  end

  scope "/", NgepaWeb do
    pipe_through [:browser, :require_authenticated_admin]

    live "/transactions", TransactionLive.Index, :index
    live "/system_users", SystemUserLive.Index, :index

    live "/products", ProductLive.Index, :index
    live "/products/new", ProductLive.Index, :new
    live "/products/:id/edit", ProductLive.Index, :edit

    live "/products/:id", ProductLive.Show, :show
    live "/products/:id/add_color", ProductLive.Show, :add_color
    live "/products/:id/edit_color/:color_id", ProductLive.Show, :edit_color
    live "/products/:id/add_product_image", ProductLive.Show, :add_product_image

    live "/products/:id/edit_product_image/:product_image_id",
         ProductLive.Show,
         :edit_product_image

    live "/products/:id/show/edit", ProductLive.Show, :edit

    live "/product_orders/:id/show/edit", ProductOrderLive.Show, :edit_on_show
    live "/product_orders/:id/new/message", ProductOrderLive.Show, :new_message

    live "/product_orders", ProductOrderLive.Index, :index
    live "/product_orders/new", ProductOrderLive.Index, :new
    live "/product_orders/:id/edit", ProductOrderLive.Index, :edit

    live "/product_orders/:id/show/edit", ProductOrderLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  scope "/api", NgepaWeb do
    pipe_through :api
    resources "/transactions", TransactionController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", NgepaWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", NgepaWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", NgepaWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
