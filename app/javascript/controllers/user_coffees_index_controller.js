import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-coffees-index"
export default class extends Controller {
  connect() {
  }

  archiveCoffee(event) {
    event.preventDefault()
    let url = event.currentTarget.href
    let csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    let target = event.currentTarget
    fetch(url, { method: "PATCH", headers: { "X-CSRF-Token": csrfToken } }).then(
      (res) => {
        if (res.status == 200)
          target.parentElement.parentElement.parentElement.outerHTML = "";
      }
    );
  }
}
