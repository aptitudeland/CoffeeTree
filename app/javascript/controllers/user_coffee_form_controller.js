import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-coffee-form"
export default class extends Controller {
  static targets = ['coffeeForm', 'weight']

  connect() {
  }

  toggleCoffeeFormVisibility(event) {
    if (event.currentTarget.value !== ''){
      this.coffeeFormTarget.classList.add('d-none')
    } else {
      this.coffeeFormTarget.classList.remove("d-none");
    }
  }

  fetchCoffee(event) {
    event.preventDefault()
    const baseUrl = "/user_coffees/new"

    const formData = new FormData(this.element)
    console.log(formData.get('coffee[name]'))

    const urlParams = new URLSearchParams({
      name:formData.get("coffee[name]"),
    });
    fetch(baseUrl + "?" + urlParams.toString(), {
      headers: {
        'Accept': 'application/json'
      }
    })
      .then(response => response.json())
      .then(data => console.log(data))
  }

  changeWeight(event){
    event.preventDefault()
    this.weightTarget.setAttribute(
      "value",
      parseInt(event.currentTarget.value) + parseInt(this.weightTarget.value)
    );

  }
}
