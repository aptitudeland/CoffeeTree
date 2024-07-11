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
    const urlParams = new URLSearchParams();

    if (formData.get("coffee[name]") !== '')
      urlParams.append("name", formData.get("coffee[name]"));
    if (formData.get("coffee[roaster]") !== "")
      urlParams.append("roaster", formData.get("coffee[roaster]"));
    if (formData.get("coffee[roasting_date]") !== "")
      urlParams.append("roasting_date", formData.get("coffee[roasting_date]"));


    window.location.href = baseUrl + "?" + urlParams.toString();
    
    fetch(baseUrl + "?" + urlParams.toString(), {
      headers: {
        'Accept': 'application/html'
      }
    })
      .then(response => response.json())
      .then(data => {
        console.log(data)
        this.#fillCoffeeForm(data.coffee)
  })
  }

  changeWeight(event){
    event.preventDefault()
    this.weightTarget.setAttribute(
      "value",
      parseInt(event.currentTarget.value) + parseInt(this.weightTarget.value)
    );
  }

  #fillCoffeeForm(coffeeData){
    const country = this.element.querySelector("#coffee_country")
    country.setAttribute("defaultValue", coffeeData.country);

    this.#fillTextInput("#coffee_process", coffeeData.process);
    this.#fillTextInput("#coffee_region", coffeeData.region);
    this.#fillTextInput("#coffee_altitude", coffeeData.altitude);
  }

  #fillTextInput(name, value) {
    this.element
      .querySelector(name)
      .setAttribute("value", value);
  }
}
