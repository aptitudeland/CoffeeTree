import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-coffee-form"
export default class extends Controller {
  static targets = ['coffeeForm', 'weight']

  connect() {
  }

  fetchCoffee(event) {
    event.preventDefault()
    const baseUrl = "/user_coffees/new"
    const formData = new FormData(this.element)
    const urlParams = new URLSearchParams();

    if (formData.get("coffee[name]") !== '')
      urlParams.append("coffee[name]", formData.get("coffee[name]"));
    if (formData.get("coffee[roaster]") !== "")
      urlParams.append("coffee[roaster]", formData.get("coffee[roaster]"));
    if (formData.get("coffee[roasting_date]") !== '')
      urlParams.append(
        "coffee[roasting_date]",
        formData.get("coffee[roasting_date]")
      );

    window.location.href = baseUrl + "?" + urlParams.toString();
  }

  changeWeight(event){
    event.preventDefault()
    this.weightTarget.setAttribute(
      "value",
      parseInt(event.currentTarget.value) + parseInt(this.weightTarget.value)
    );
  }
}
