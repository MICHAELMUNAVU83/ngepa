// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar";

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

const toggleButton = document.getElementById("toggleButton");
const sidebar = document.getElementById("sidebar");

toggleButton.addEventListener("click", () => {
  sidebar.classList.toggle("-translate-x-full");
});

document.getElementById("sidebarContent").addEventListener("click", () => {
  sidebar.classList.toggle("-translate-x-full");
});

let Hooks = {};
Hooks.ProductLocation = {
  mounted() {
    const input = document.getElementById("product_order_location");

    const delivery_latitude_product_order = document.getElementById(
      "delivery_latitude_product_order"
    );
    const delivery_longitude_product_order = document.getElementById(
      "delivery_longitude_product_order"
    );

    const options = {
      fields: ["address_components", "geometry", "icon", "name"],
      componentRestrictions: { country: "ke" },
    };

    const autocomplete1 = new google.maps.places.Autocomplete(input, options);

    autocomplete1.addListener("place_changed", () => {
      const place1 = autocomplete1.getPlace();

      delivery_latitude_product_order.value = place1.geometry.location.lat();
      delivery_longitude_product_order.value = place1.geometry.location.lng();
    });
  },

  updated() {
    const input = document.getElementById("product_order_location");

    const delivery_latitude_product_order = document.getElementById(
      "delivery_latitude_product_order"
    );
    const delivery_longitude_product_order = document.getElementById(
      "delivery_longitude_product_order"
    );

    const options = {
      fields: ["address_components", "geometry", "icon", "name"],
      componentRestrictions: { country: "ke" },
    };

    const autocomplete1 = new google.maps.places.Autocomplete(input, options);

    autocomplete1.addListener("place_changed", () => {
      const place1 = autocomplete1.getPlace();

      delivery_latitude_product_order.value = place1.geometry.location.lat();
      delivery_longitude_product_order.value = place1.geometry.location.lng();
    });
  },
};

Hooks.LocationMap = {
  mounted() {
    const lat = document.getElementById("product-order-latitude").innerText;
    const lng = document.getElementById("product-order-longitude").innerText;

    function initMap() {
      const map = new google.maps.Map(
        document.getElementById("product-order-map"),
        {
          center: {
            lat: parseFloat(lat),
            lng: parseFloat(lng),
          },
          zoom: 8,
        }
      );
      new google.maps.Marker({
        position: {
          lat: parseFloat(lat),
          lng: parseFloat(lng),
        },
        map,
        title: "Hello World!",
      });
    }
    initMap();
  },

  updated() {
    const lat = document.getElementById("product-order-latitude").innerText;
    const lng = document.getElementById("product-order-longitude").innerText;

    function initMap() {
      const map = new google.maps.Map(
        document.getElementById("product-order-map"),
        {
          center: {
            lat: parseFloat(lat),
            lng: parseFloat(lng),
          },
          zoom: 8,
        }
      );
      new google.maps.Marker({
        position: {
          lat: parseFloat(lat),
          lng: parseFloat(lng),
        },
        map,
        title: "Hello World!",
      });
    }
    initMap();
  },
};

Hooks.ProductSwiper = {
  mounted() {
    const swiper = new Swiper(".swiper", {
      // Optional parameters
      direction: "horizontal",
      loop: true,
      autoplay: {
        delay: 5000,
      },
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },

      // If we need pagination

      // And if we need scrollbar
    });
  },
  updated() {
    const swiper = new Swiper(".swiper", {
      // Optional parameters
      direction: "horizontal",
      loop: true,
      autoplay: {
        delay: 5000,
      },
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },

      // If we need pagination

      // And if we need scrollbar
    });
  },
};

Hooks.ShopSwiper = {
  mounted() {
    const swiper = new Swiper(".shopswiper", {
      // Optional parameters

      loop: true,
      rewind: true,
      autoplay: {
        delay: 5000,
      },
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
      slidesPerView: 1,

      breakpoints: {
        640: {
          slidesPerView: 2,
          spaceBetween: 20,
        },
        768: {
          slidesPerView: 3,
          spaceBetween: 40,
        },
        1024: {
          slidesPerView: 3,
          spaceBetween: 40,
        },
      },

      // If we need pagination

      // And if we need scrollbar
    });
  },
  updated() {
    const swiper = new Swiper(".shopswiper", {
      // Optional parameters

      loop: true,
      rewind: true,
      autoplay: {
        delay: 5000,
      },
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
      slidesPerView: 1,

      breakpoints: {
        640: {
          slidesPerView: 2,
          spaceBetween: 20,
        },
        768: {
          slidesPerView: 3,
          spaceBetween: 40,
        },
        1024: {
          slidesPerView: 3,
          spaceBetween: 40,
        },
      },

      // If we need pagination

      // And if we need scrollbar
    });
  },
};

// Hooks.Trending = {
//   mounted() {
//     var swiper = new Swiper(".mySwiper", {
//       direction: "vertical",
//       pagination: {
//         el: ".swiper-pagination",
//         clickable: true,
//       },
//     });
//   },
// };

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (info) => topbar.show());
window.addEventListener("phx:page-loading-stop", (info) => topbar.hide());

let liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  params: { _csrf_token: csrfToken },
});

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
